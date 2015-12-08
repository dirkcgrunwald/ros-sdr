#include "ros/ros.h"
#include "ros/header.h"
#include <fstream>
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
#include "ros_sdr/rtlsdr_config.h"
#include "ros_sdr/rtlsdr_config_srv.h"
#include "ros_sdr/rtlsdr_config_current.h"
#include "ros_sdr/rtlsdr_data.h"

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


void addGPS(ros_sdr_proto::sdr_payload& payload)
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

  ros_sdr_proto::sdr_payload payload;

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

  int sz = msg.iq.layout.dim[0].size;
  for(int i = 0; i < sz; i += 2) {
    payload.add_i( msg.iq.data[i] );
    payload.add_q( msg.iq.data[i+ 1]);
  }

  payload.SerializeToOstream(protobufOutput);
  protobufOutput -> flush();
  protobufOutput -> close();
  std::exit(0);

}

void rtlsdr_outCallback(const ros_sdr::rtlsdr_data& msg)
{
  ROS_INFO("I heard rtlsdr message..\n");
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "sdr_recorder");
  ros::NodeHandle n;

  GOOGLE_PROTOBUF_VERIFY_VERSION;

  protobufOutput = new std::ofstream(PROTOBUFF_FILE_OUTPUT_NAME, std::ios::out | std::ios::trunc | std::ios::binary);

  ros::Subscriber sub_hackrf = n.subscribe("hackrf_out", 1000, hackrf_outCallback);
  ros::Subscriber sub_rtlsdr = n.subscribe("rtlsdr_out", 1000, rtlsdr_outCallback);

  ros::spin();

  google::protobuf::ShutdownProtobufLibrary();

  return 0;
}
