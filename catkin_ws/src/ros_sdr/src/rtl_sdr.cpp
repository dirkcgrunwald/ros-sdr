#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/UInt8MultiArray.h"

#include <sstream>

#include "ros/ros.h"
#include "ros_sdr/rtlsdr_config.h"
#include "ros_sdr/rtlsdr_config_srv.h"
#include "ros_sdr/rtlsdr_config_current.h"
#include "ros_sdr/rtlsdr_data.h"
#include "rtl-sdr.h"

#define DEFAULT_SAMPLE_RATE	2048000
#define DEFAULT_BUF_LENGTH	(16 * 16384)
#define MINIMAL_BUF_LENGTH	512
#define MAXIMAL_BUF_LENGTH	(256 * 16384)

static rtlsdr_dev_t *dev = NULL;

static bool rtlsdr_discard_samples = false;
static ros::Time rtlsdr_discard_until;

#define NS_TO_MS(x) ( (x) * 1000 * 1000 )
#define RTLSDR_SETTLE_TIME_NS (NS_TO_MS(5))

ros_sdr::rtlsdr_config rtlsdr_current_state;

bool rtlsdr_verbose = false;

/*
 * The following function configures the rtlsdr with the
 * input parameters and if the configuration change causes
 * a transient, returns the time (in microseconds) for which
 * samples should be discard before passing them on to consumer.
 *
 * We only make those changes if the input and output differ.
 *
 */

int nearest_gain(rtlsdr_dev_t *dev, int target_gain)
{
  int i, r, err1, err2, count, nearest;
  int* gains;
  r = rtlsdr_set_tuner_gain_mode(dev, 1);
  if (r < 0) {
    fprintf(stderr, "WARNING: Failed to enable manual gain.\n");
    return r;
  }
  count = rtlsdr_get_tuner_gains(dev, NULL);
  if (count <= 0) {
    return 0;
  }
  gains = (int*) malloc(sizeof(int) * count);
  count = rtlsdr_get_tuner_gains(dev, gains);
  nearest = gains[0];
  for (i=0; i<count; i++) {
    err1 = abs(target_gain - nearest);
    err2 = abs(target_gain - gains[i]);
    if (err2 < err1) {
      nearest = gains[i];
    }
  }
  free(gains);
  return nearest;
} 

int
rtlsdr_set_config(rtlsdr_dev_t *dev,
		  ros_sdr::rtlsdr_config *output,
		  ros_sdr::rtlsdr_config *input)
{
  int delay = 0;

  ROS_INFO("Configure RTLSDR");

  if ( output -> dithering != input -> dithering ) {
    rtlsdr_set_dithering(dev, input -> dithering);
    output -> dithering = input -> dithering;
    delay = (delay < RTLSDR_SETTLE_TIME_NS) ? RTLSDR_SETTLE_TIME_NS : delay;
    ROS_INFO("Set RTLSDR dithering to %d\n", output -> dithering);
  }

    if ( output -> direct_sampling != input -> direct_sampling ) {
    rtlsdr_set_direct_sampling(dev, input -> direct_sampling);
    output -> direct_sampling = input -> direct_sampling;
    delay = (delay < RTLSDR_SETTLE_TIME_NS) ? RTLSDR_SETTLE_TIME_NS : delay;
    ROS_INFO("Set RTLSDR direct_sampling to %d\n", output -> direct_sampling);
  }

  if ( output -> sample_rate != input -> sample_rate ) {
    rtlsdr_set_sample_rate(dev, input -> sample_rate);
    output -> sample_rate = input -> sample_rate;
    delay = (delay < RTLSDR_SETTLE_TIME_NS) ? RTLSDR_SETTLE_TIME_NS : delay;
    ROS_INFO("Set RTLSDR sample_rate to %u\n", output -> sample_rate);
  }

  if (output -> frequency != input -> frequency ) {
    ROS_INFO("Try to set RTLSDR frequency to %u\n", input -> frequency);
    rtlsdr_set_center_freq(dev, input -> frequency);

    output -> frequency = rtlsdr_get_center_freq(dev);
    delay = (delay < RTLSDR_SETTLE_TIME_NS) ? RTLSDR_SETTLE_TIME_NS : delay;
    ROS_INFO("RTLSDR frequency set to %u\n", output -> frequency);
  }

  if ( output -> gainmode != input -> gainmode ) {
    rtlsdr_set_tuner_gain_mode(dev, input -> gainmode);
    output -> gainmode = input -> gainmode;
    ROS_INFO("Set RTLSDR gainmode to %d\n", output -> gainmode);
  } 

  /*
   * Calling nearest gain flips it into non-auto-gain mode.
   */
  if ( input -> gainmode ) {
    int nearest = nearest_gain(dev, input -> gain);
    ROS_INFO("nearest gain to %d is %d\n", input -> gain, nearest);
    if ( output -> gain != nearest) {
      output -> gain = nearest;
      rtlsdr_set_tuner_gain_mode(dev, 1);
      rtlsdr_set_tuner_gain(dev, output -> gain);
      ROS_INFO("Set RTLSDR gain to %d\n", output -> gain);
    }
  }

  int realGain = rtlsdr_get_tuner_gain(dev);
  if ( realGain != output -> gain ) {
    output -> gain = realGain;
    ROS_INFO("Actual RTLSDR gain set to %d\n", output -> gain);
  }


  if ( output -> ppm_error != input -> ppm_error ) {
    output -> ppm_error = input -> ppm_error;
    ROS_INFO("Set RTLSDR ppm_error to %d\n", output -> ppm_error);
  }

  //
  // Mark the samples as invalid until the specified time
  //

  if ( delay > 0 ) {
    rtlsdr_discard_samples = true;
    rtlsdr_discard_until = ros::Time::now() + ros::Duration(0, delay);
    ROS_INFO("Set sample discard until now + %d ns", delay);
  } else {
    rtlsdr_discard_samples = false;
  }

  return delay;
}

bool rtlsdr_config_srv(ros_sdr::rtlsdr_config_srv::Request  &req,
		   ros_sdr::rtlsdr_config_srv::Response &res)
{
  rtlsdr_set_config(dev, &res.output, &req.input);
  rtlsdr_current_state = res.output;
  ROS_INFO("COMBO sending back response:\n");
  return true;
}


bool rtlsdr_config_current(ros_sdr::rtlsdr_config_current::Request  &req,
		   ros_sdr::rtlsdr_config_current::Response &res)
{
  ROS_INFO("rtlsdr_config_current sending back response:");
  res.output = rtlsdr_current_state;
  return true;
}


int main(int argc, char **argv)
{
  ros::init(argc, argv, "rtl_sdr");
  ros::NodeHandle n;

  ros::ServiceServer srv_rtlsdr_config_srv = n.advertiseService("rtlsdr_config_srv",
							    rtlsdr_config_srv);

  ros::ServiceServer srv_rtlsdr_config_current = n.advertiseService("rtlsdr_config_current",
								    rtlsdr_config_current);

  ROS_INFO("Ready to configure rtl_sdr.");
  ros::Publisher rtlsdr_pub = n.advertise<ros_sdr::rtlsdr_data>("rtlsdr_out",
								1000);
  int out_block_size = MAXIMAL_BUF_LENGTH;
  uint32_t dev_index = 0;

  int r = rtlsdr_open(&dev, (uint32_t) dev_index);
  if ( r < 0 ) {
    ROS_INFO("Failed to open rtlsdr device #%d.\n", dev_index);
    return 1;
  }

  ros_sdr::rtlsdr_config rtlsdr_init;

  rtlsdr_init.frequency = 700 * 1000000; // 700Mhz
  rtlsdr_init.sample_rate = 2048000;
  rtlsdr_init.gainmode = 1; // manual
  rtlsdr_init.gain  = 490;
  rtlsdr_init.ppm_error = 0;
  rtlsdr_init.dithering = 1;
  rtlsdr_init.direct_sampling = 0;

  rtlsdr_set_config(dev, &rtlsdr_current_state, &rtlsdr_init);

  rtlsdr_reset_buffer(dev);

  ros_sdr::rtlsdr_data msg;
  msg.output = rtlsdr_current_state;

  //  std::vector<uint8> *buffer = new std::vector<uint8>(block_size);
  std_msgs::UInt8MultiArray &buffer = msg.iq;
  buffer.layout.dim.push_back(std_msgs::MultiArrayDimension());
  buffer.layout.dim[0].size = out_block_size;
  buffer.layout.dim[0].stride = 1;
  buffer.layout.dim[0].label = "IQ";
  buffer.data.resize(out_block_size);


  int count = 0;
  while (ros::ok())
    {
      int nread = 0;
      rtlsdr_read_sync(dev, buffer.data.data(), out_block_size, &nread);
      if ( rtlsdr_verbose ) {
	ROS_INFO("Got %d bytes from rtl_sdr\n", nread);
      }

      if ( rtlsdr_discard_samples ) {
	rtlsdr_reset_buffer(dev);

	ros::Duration remaining = rtlsdr_discard_until - ros::Time::now();
	
	if ( rtlsdr_discard_until > ros::Time::now() ) {
	  ROS_INFO("Ignore data during transient.. (%d, %d) remaining...\n", remaining.sec, remaining.nsec);
	} else {
	  ROS_INFO("Transient discard has passed...\n");
	  rtlsdr_discard_samples = false;
	}
      } else {
	msg.output = rtlsdr_current_state;
	rtlsdr_pub.publish(msg);
      }

      ros::spinOnce();

      //      loop_rate.sleep();
      ++count;
    }


  ROS_INFO("ros_sdr rtl_sdr exits\n");
  

  return 0;
}
