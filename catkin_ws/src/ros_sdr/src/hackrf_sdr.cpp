#include "ros/ros.h"
#include "std_msgs/String.h"
#include "std_msgs/UInt8MultiArray.h"

#include <sstream>

#include "ros/ros.h"
#include "ros_sdr/hackrf_config.h"
#include "ros_sdr/hackrf_config_srv.h"
#include "ros_sdr/hackrf_config_current.h"
#include "ros_sdr/hackrf_data.h"
#include "libhackrf/hackrf.h"

#define DEFAULT_SAMPLE_RATE	2048000
#define DEFAULT_BUF_LENGTH	(16 * 16384)
#define MINIMAL_BUF_LENGTH	512
#define MAXIMAL_BUF_LENGTH	(256 * 16384)

static hackrf_device *hackrfDev;

static bool hackrf_discard_samples = false;
static ros::Time hackrf_discard_until;

#define NS_TO_MS(x) ( (x) * 1000 * 1000 )
#define HACKRF_SETTLE_TIME_NS (NS_TO_MS(5))

ros_sdr::hackrf_config hackrf_current_state;

bool hackrf_verbose = false;

/*
 * Sample rates - these need to be adjusted for HackRF
 */
#define MAXIMUM_RATE			20000000
#define MINIMUM_RATE			 2000000
#define DEFAULT_TARGET			 2000000

static int hackRFclosestTargetRate(int rate)
{
  if ( rate < MINIMUM_RATE || rate < 9000000) {
    return MINIMUM_RATE;
  } else if (rate < 11500000 ) {
    return 10000000;
  } else if (rate < 15000000 ) {
    return 12500000;
  } else if (rate < 18000000) {
    return 16000000;
  } else {
    return 20000000;
  }
}

int
hackrf_set_config(hackrf_device *dev,
		  ros_sdr::hackrf_config *output,
		  ros_sdr::hackrf_config *input)
{
  int delay = 0;

  ROS_INFO("Configure HACKRF");

  if ( output -> sampleRate != input -> sampleRate ) {
    hackrf_set_sample_rate(dev, input -> sampleRate);
    output -> sampleRate = input -> sampleRate;
    delay = (delay < HACKRF_SETTLE_TIME_NS) ? HACKRF_SETTLE_TIME_NS : delay;
    ROS_INFO("Set HACKRF sample_rate to %f\n", output -> sampleRate);
  }

  if (output -> frequency != input -> frequency ) {
    ROS_INFO("Try to set HACKRF frequency to %lu\n", input -> frequency);
    hackrf_set_freq(dev, input -> frequency);
    output -> frequency = input -> frequency;
    delay = (delay < HACKRF_SETTLE_TIME_NS) ? HACKRF_SETTLE_TIME_NS : delay;
    ROS_INFO("HACKRF frequency set to %lu\n", output -> frequency);
  }

  if ( output -> lnaGain != input -> lnaGain) {
    hackrf_set_lna_gain(dev, input -> lnaGain);
    output -> lnaGain = input -> lnaGain;
    ROS_INFO("Set HACKRF gain to %d\n", output -> lnaGain);
  }

  if ( output -> vgaGain != input -> vgaGain) {
    hackrf_set_vga_gain(dev, input -> vgaGain);
    output -> vgaGain = input -> vgaGain;
    ROS_INFO("Set HACKRF gain to %d\n", output -> vgaGain);
  }

  if ( output -> txvgaGain != input -> txvgaGain) {
    hackrf_set_txvga_gain(dev, input -> txvgaGain);
    output -> txvgaGain = input -> txvgaGain;
    ROS_INFO("Set HACKRF gain to %d\n", output -> txvgaGain);
  }


  if ( output -> ampEnable != input -> ampEnable ) {
    hackrf_set_amp_enable(dev, input -> ampEnable);
    output -> ampEnable = input -> ampEnable;
    delay = (delay < HACKRF_SETTLE_TIME_NS) ? HACKRF_SETTLE_TIME_NS : delay;
    ROS_INFO("Set HACKRF ampEnable to %d\n", output -> ampEnable);
  }

  if ( output -> antennaEnable != input -> antennaEnable ) {
    hackrf_set_antenna_enable(dev, input -> antennaEnable);
    output -> antennaEnable = input -> antennaEnable;
    delay = (delay < HACKRF_SETTLE_TIME_NS) ? HACKRF_SETTLE_TIME_NS : delay;
    ROS_INFO("Set HACKRF antennaEnable to %d\n", output -> antennaEnable);
  }


  //
  // Mark the samples as invalid until the specified time
  //

  if ( delay > 0 ) {
    hackrf_discard_samples = true;
    hackrf_discard_until = ros::Time::now() + ros::Duration(0, delay);
    ROS_INFO("Set sample discard until now + %d ns", delay);
  } else {
    hackrf_discard_samples = false;
  }

  return delay;
}

bool hackrf_config_srv(ros_sdr::hackrf_config_srv::Request  &req,
		   ros_sdr::hackrf_config_srv::Response &res)
{
  hackrf_set_config(hackrfDev, &res.output, &req.input);
  hackrf_current_state = res.output;
  ROS_INFO("COMBO sending back response:\n");
  return true;
}


bool hackrf_config_current(ros_sdr::hackrf_config_current::Request  &req,
		   ros_sdr::hackrf_config_current::Response &res)
{
  ROS_INFO("hackrf_config_current sending back response:");
  res.output = hackrf_current_state;
  return true;
}


int hackrf_rx_callback(hackrf_transfer* transfer)
{
  int i;
  if ( hackrf_verbose ) {
    fprintf(stderr,"rx_callback %d bytes\n", transfer -> valid_length);
  }

  ROS_INFO("Got %d bytes from hackrf_sdr\n", transfer -> valid_length);

  //memcpy(&hackrfBuffer[hackrfBufferTail], 
  //	 transfer -> buffer, transfer -> valid_length);
  //  hackrfBufferTail += transfer -> valid_length;


  return 0; /* always be happy */
}


int main(int argc, char **argv)
{
  ros::init(argc, argv, "hackrf_sdr");
  ros::NodeHandle n;

  ros::ServiceServer srv_hackrf_config_srv = n.advertiseService("hackrf_config_srv",
							    hackrf_config_srv);

  ros::ServiceServer srv_hackrf_config_current = n.advertiseService("hackrf_config_current",
								    hackrf_config_current);

  ROS_INFO("Ready to configure hackrf_sdr.");
  ros::Publisher hackrf_pub = n.advertise<ros_sdr::hackrf_data>("hackrf_out",
								1000);
  int out_block_size = MAXIMAL_BUF_LENGTH;
  uint32_t dev_index = 0;


  int r = hackrf_init();
  if (r < 0) {
    fprintf(stderr, "Failed to init hackrf device.\n");
    exit(1);
  }


  r = hackrf_open(&hackrfDev);
  if ( r < 0 ) {
    ROS_INFO("Failed to open hackrf device #%d.\n", dev_index);
    return 1;
  }

  ros_sdr::hackrf_config hackrf_init;

  hackrf_init.frequency = 700 * 1000000; // 700Mhz
  hackrf_init.sampleRate = 2048000;
  hackrf_init.lnaGain  = 16;
  hackrf_init.vgaGain  = 16;
  hackrf_init.txvgaGain  = 16;
  hackrf_init.ampEnable = 0;
  hackrf_init.antennaEnable = 0;

  hackrf_set_config(hackrfDev, &hackrf_current_state, &hackrf_init);

  ros_sdr::hackrf_data msg;
  msg.output = hackrf_current_state;

  //  std::vector<uint8> *buffer = new std::vector<uint8>(block_size);
  std_msgs::UInt8MultiArray &buffer = msg.iq;
  buffer.layout.dim.push_back(std_msgs::MultiArrayDimension());
  buffer.layout.dim[0].size = out_block_size;
  buffer.layout.dim[0].stride = 1;
  buffer.layout.dim[0].label = "IQ";
  buffer.data.resize(out_block_size);

  hackrf_start_rx(hackrfDev, hackrf_rx_callback, NULL);

  int count = 0;
  while (ros::ok())
    {
      int nread = 0;
      //      hackrf_read_sync(dev, buffer.data.data(), out_block_size, &nread);
      if ( hackrf_verbose ) {
	ROS_INFO("Got %d bytes from hackrf_sdr\n", nread);
      }

      if ( hackrf_discard_samples ) {
	//	hackrf_reset_buffer(hackrfDev);

	ros::Duration remaining = hackrf_discard_until - ros::Time::now();
	
	if ( hackrf_discard_until > ros::Time::now() ) {
	  ROS_INFO("Ignore data during transient.. (%d, %d) remaining...\n", remaining.sec, remaining.nsec);
	} else {
	  ROS_INFO("Transient discard has passed...\n");
	  hackrf_discard_samples = false;
	}
      } else {
	msg.output = hackrf_current_state;
	hackrf_pub.publish(msg);
      }

      ros::spinOnce();

      //      loop_rate.sleep();
      ++count;
    }


  ROS_INFO("ros_sdr hackrf_sdr exits\n");
  

  return 0;
}
