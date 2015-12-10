#include "ros/ros.h"
#include "ros/header.h"
#include <fstream>
#include <endian.h>

#include <mavros/mavros.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/CommandHome.h>
#include <mavros_msgs/CommandTOL.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/Vector3Stamped.h>
#include <sensor_msgs/NavSatFix.h>
#include <geometry_msgs/TransformStamped.h>
#include "std_msgs/String.h"
#include "ros_sdr/hackrf_config.h"
#include "ros_sdr/hackrf_config_srv.h"
#include "ros_sdr/hackrf_config_current.h"
#include "ros_sdr/hackrf_data.h"

#ifdef ROS_SDR_SUPPORT_RTL_SDR
#include "ros_sdr/rtlsdr_config.h"
#include "ros_sdr/rtlsdr_config_srv.h"
#include "ros_sdr/rtlsdr_config_current.h"
#include "ros_sdr/rtlsdr_data.h"
#endif

#include "sdr_data.pb.h"


#define PROTOBUFF_FILE_OUTPUT_NAME "/tmp/sdr_recorder.data"
std::ofstream *protobufOutput = NULL;


struct {
  ros::Time time_stamp;
  geometry_msgs::Pose pose;
  sensor_msgs::NavSatStatus status;
  double latitude;
  double longitude;
  double altitude;
  double position_covariance[9];
} pos_state;

pthread_cond_t newPose;
static bool haveSeenPose = false;


#include <zlib.h>

/** Compress a STL string using zlib with given compression level and return
 * the binary data. */
void compress_string(const std::string& str,
		     std::string& outstring,
		     int compressionlevel = Z_BEST_SPEED)
{
  z_stream zs;                        // z_stream is zlib's control structure
  memset(&zs, 0, sizeof(zs));

  if (deflateInit(&zs, compressionlevel) != Z_OK)
    throw(std::runtime_error("deflateInit failed while compressing."));

  zs.next_in = (Bytef*)str.data();
  zs.avail_in = str.size();           // set the z_stream's input

  int ret;
  char outbuffer[32768];

  // retrieve the compressed bytes blockwise
  do {
    zs.next_out = reinterpret_cast<Bytef*>(outbuffer);
    zs.avail_out = sizeof(outbuffer);

    ret = deflate(&zs, Z_FINISH);

    if (outstring.size() < zs.total_out) {
      // append the block to the output string
      outstring.append(outbuffer,
		       zs.total_out - outstring.size());
    }
  } while (ret == Z_OK);

  deflateEnd(&zs);

  if (ret != Z_STREAM_END) {          // an error occurred that was not EOF
    std::ostringstream oss;
    oss << "Exception during zlib compression: (" << ret << ") " << zs.msg;
    throw(std::runtime_error(oss.str()));
  }
}

//
// Write buffer to file with little endian unsigned length ahead of it
//
void emitProtobuf(std::string& data, std::ofstream *output)
{
  /* Test for a little-endian machine */
  unsigned int len = htole32(data.size());

  output -> write((const char*) &len, sizeof(unsigned int));
  output -> write((const char*) data.data(), data.size());
  output -> flush();
}


/**
 * This tutorial demonstrates simple receipt of messages over the ROS system.
 */
void SDRposCallback(const geometry_msgs::PoseStamped& msg)
{
  pos_state.pose = msg.pose;
}

void SDRGPSCallback(const sensor_msgs::NavSatFix& msg)
{

  pos_state.time_stamp = msg.header.stamp;
  pos_state.status = msg.status;
  pos_state.latitude = msg.latitude;
  pos_state.longitude = msg.longitude;
  pos_state.altitude = msg.altitude;
  for (int i = 0; i < 9; i++) {
    pos_state.position_covariance[i] = msg.position_covariance[i];
  }
  pthread_cond_signal(&newPose);

  //
  // We want to check if the GPS header makes sense...
  //
  haveSeenPose = true;
}


void addGPS(ros_sdr_proto::sdr_config_payload& payload)
{
  if ( ! haveSeenPose ) {
    return;
  }

  payload.mutable_stamp() -> set_sec(pos_state.time_stamp.sec );
  payload.mutable_stamp() -> set_nsec(pos_state.time_stamp.nsec );

  ros_sdr_proto::Pose& pose = *payload.mutable_pose();
  pose.mutable_position() -> set_x( pos_state.pose.position.x );
  pose.mutable_position() -> set_y( pos_state.pose.position.y );
  pose.mutable_position() -> set_z( pos_state.pose.position.z );

  pose.mutable_orientation() -> set_x( pos_state.pose.orientation.x );
  pose.mutable_orientation() -> set_y( pos_state.pose.orientation.y );
  pose.mutable_orientation() -> set_z( pos_state.pose.orientation.z );
  pose.mutable_orientation() -> set_w( pos_state.pose.orientation.w );

  for (int i = 0; i < 9; i++) {
    pose.add_position_covariance( pos_state.position_covariance[i] );
  }
  ros_sdr_proto::NavSatStatus& status = *payload.mutable_status();
  status.set_status( pos_state.status.status );
  status.set_service( pos_state.status.service );
}

 

void hackrf_outCallback(const ros_sdr::hackrf_data& msg)
{
  ROS_INFO("I heard hackrf message..\n");

  if ( ! protobufOutput ) {
    return; // file isn't open
  }

  ros_sdr_proto::sdr_config_payload payload;

  //
  // Time stamp will be over-written with GPS time if available
  //
  payload.mutable_stamp() -> set_sec(msg.header.stamp.sec );
  payload.mutable_stamp() -> set_nsec(msg.header.stamp.nsec );

  addGPS(payload);

  ros_sdr_proto::hackrf_config& hackrf = *payload.mutable_hackrf();
  hackrf.set_frequency(msg.output.frequency);
  hackrf.set_sample_rate(msg.output.sample_rate);
  hackrf.set_baseband_filter_bw_hz(msg.output.baseband_filter_bw_hz);
  hackrf.set_lnagain(msg.output.lnaGain);
  hackrf.set_vgagain(msg.output.vgaGain);
  hackrf.set_ampenable(msg.output.ampEnable);
  hackrf.set_antennaenable(msg.output.antennaEnable);
  hackrf.set_txvgagain(msg.output.txvgaGain);

  std::string data;
  payload.SerializeToString(&data);
  emitProtobuf(data, protobufOutput);

  ros_sdr_proto::iq_payload iqpayload;
  int sz = msg.iq.layout.dim[0].size;
  for(int i = 0; i < sz; i += 2) {
    iqpayload.add_i( msg.iq.data[i] );
    iqpayload.add_q( msg.iq.data[i+ 1]);
  }

  std::string iqdata;
  iqpayload.SerializeToString(&iqdata);
  std::string ziqdata;
  compress_string(iqdata, ziqdata);
  emitProtobuf(ziqdata, protobufOutput);
}

#ifdef ROS_SDR_SUPPORT_RTL_SDR
void rtlsdr_outCallback(const ros_sdr::rtlsdr_data& msg)
{
  ROS_INFO("I heard rtlsdr message..\n");
}
#endif

int main(int argc, char **argv)
{
  ros::init(argc, argv, "sdr_recorder");
  ros::NodeHandle n;

  GOOGLE_PROTOBUF_VERIFY_VERSION;

  protobufOutput = new std::ofstream(PROTOBUFF_FILE_OUTPUT_NAME, std::ios::out | std::ios::trunc | std::ios::binary);

  //
  // do not put a long back-up queue on these. The the system is having
  // trouble keeping up, you'll backlog the queue and suck up all the RAM.
  // Better to just lose some packets.
  //
  ros::Subscriber sub_hackrf = n.subscribe("hackrf_out", 10, hackrf_outCallback);
#ifdef ROS_SDR_SUPPORT_RTL_SDR
  ros::Subscriber sub_rtlsdr = n.subscribe("rtlsdr_out", 10, rtlsdr_outCallback);
#endif

  ros::spin();

  google::protobuf::ShutdownProtobufLibrary();

  return 0;
}
