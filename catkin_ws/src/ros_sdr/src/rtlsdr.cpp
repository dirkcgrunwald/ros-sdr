#include "ros/ros.h"
#include "std_msgs/String.h"

#include <sstream>

#include "ros/ros.h"
#include "ros_sdr/rtlsdr_config.h"
#include "rtl-sdr.h"

#define DEFAULT_SAMPLE_RATE	2048000
#define DEFAULT_BUF_LENGTH	(16 * 16384)
#define MINIMAL_BUF_LENGTH	512
#define MAXIMAL_BUF_LENGTH	(256 * 16384)

static rtlsdr_dev_t *dev = NULL;

typedef  struct {
  uint32_t frequency;
  uint32_t sample_rate;
  uint32_t autogain;
  uint32_t gain;
  uint32_t ppm_error;
} rtlsdr_config_vars;

rtlsdr_config_vars rtlsdr_current;

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
  gains = malloc(sizeof(int) * count);
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
rtlsdr_set_config(rtlsdr_dev-t *dev,
		  rtlsdr_config_vars *output,
		  rtlsdr_config_vars *input)
{
  int delay = 0;

  if (output -> frequency != input -> frequency ) {
    rtlsdr_set_center_freq(dev, input -> frquency);
    output -> frequency = input.frequency;
    delay = (delay < 5000) ? 5000 : delay;
  }

  if ( output -> sample_rate != input -> sample_rate ) {
    rtlsdr_set_sample_rate(dev, samp_rate);
p    output -> sample_rate = input -> sample_rate;
    delay = (delay < 5000) ? 5000 : delay;
  }

  if ( output -> autogain != input.autogain ) {
    r = rtlsdr_set_tuner_gain_mode(dev, input -> autogain);
    output -> autogain = input -> autogain;
  }

  /*
   * Calling nearest gain flips it into non-auto-gain mode....
   * Not clear what we should do...
   */
  int nearest = nearest_gain(dev, input -> gain);
  if ( output -> gain != nearest) {
    rtlsdr_set_gain_mode(dev, 1);
    rtlsdr_
  }
  output -> ppm_error = input -> ppm_error;
}


bool rtlsdr_config(ros_sdr::rtlsdr_config::Request  &req,
		   ros_sdr::rtlsdr_config::Response &res)
{
  ROS_INFO("COMBO sending back response:\n");
  return true;
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "rtl_sdr");
  ros::NodeHandle n;

  ros::ServiceServer service = n.advertiseService("rtlsdr_config",
						  rtlsdr_config);
  ROS_INFO("Ready to configure rtl_sdr.");
  ros::Publisher chatter_pub = n.advertise<std_msgs::String>("rtlsdr_out",
							     1000);
  ros::Rate loop_rate(10);

  
  int out_block_size = DEFAULT_BUF_LENGTH;
  uint32_t dev_index = 0;

  uint8_t *buffer = (uint8_t*) malloc( out_block_size * sizeof(uint8_t) );

  int r = rtlsdr_open(&dev, (uint32_t) dev_index);
  if ( r < 0 ) {
    ROS_INFO("Failed to open rtlsdr device #%d.\n", dev_index);
    return 1;
  }

  rtlsdr_config_vars rtlsdr_proposed =
    {
      .frequency = 2400 * 1000,
      .sample_rate = 2048000,
      .autogain = 0,
      .gain  = 10,
      .ppm_error = 0
    };


  int count = 0;
  while (ros::ok())
    {
      std_msgs::String msg;

      std::stringstream ss;
      ss << "hello world " << count;
      msg.data = ss.str();

      /*      ROS_INFO("%s", msg.data.c_str()); */

      /**
       * The publish() function is how you send messages. The parameter
       * is the message object. The type of this object must agree with the type
       * given as a template parameter to the advertise<>() call, as was done
       * in the constructor above.
       */
      chatter_pub.publish(msg);

      ros::spinOnce();

      loop_rate.sleep();
      ++count;
    }


  return 0;
}
