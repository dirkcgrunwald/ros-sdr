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

#define DEFAULT_SAMPLE_RATE	10000000
#define DEFAULT_BUF_LENGTH	(16 * 16384)
#define MINIMAL_BUF_LENGTH	512
#define MAXIMAL_BUF_LENGTH	(256 * 16384)

static hackrf_device *hackrfDev;

static ros::Publisher hackrf_pub;
static ros_sdr::hackrf_data msg;
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

/* forward declare */
int
hackrf_set_config(hackrf_device *dev,
		  ros_sdr::hackrf_config *output,
		  ros_sdr::hackrf_config *input);


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

  if ( hackrf_discard_samples ) {

    ros::Duration remaining = hackrf_discard_until - ros::Time::now();
	
    if ( hackrf_discard_until > ros::Time::now() ) {
      ROS_INFO("Ignore data during transient.. (%d, %d) remaining...\n", remaining.sec, remaining.nsec);
    } else {
      ROS_INFO("Transient discard has passed...\n");
      hackrf_discard_samples = false;
    }
  } else {

    ROS_INFO("Got %d bytes from hackrf_sdr, first two are %d, %d\n",
	     transfer -> valid_length, transfer -> buffer[0],  transfer -> buffer[1]);

    int offset = 0;
    int lth = transfer -> valid_length;
    std_msgs::UInt8MultiArray &buffer = msg.iq;
    while (offset < lth) {
      int left = transfer -> valid_length - offset;
      int len = left;
      if ( left > buffer.layout.dim[0].size ) {
	len = buffer.layout.dim[0].size;
      }
      memcpy(buffer.data.data(), &(transfer -> buffer[offset]), len);
      msg.output = hackrf_current_state;
      buffer.layout.dim[0].size = len;
      hackrf_pub.publish(msg);
      ros::spinOnce();
      offset += len;
    }
  }
  return 0;
}



int
hackrf_set_config(hackrf_device *dev,
		  ros_sdr::hackrf_config *output,
		  ros_sdr::hackrf_config *input)
{
  int delay = 0;
  bool restart_hackrf = false;


  if (hackrf_is_streaming(dev)) {
    ROS_INFO("Configure HACKRF after stopping streaming..");
    //
    // This appears to stop it from ever streaming again,
    // although we turn it on later. Need to check hackrf_transfer
    // to see what is up
    //
    // hackrf_stop_rx(dev);
    restart_hackrf = true;
  } else {
    ROS_INFO("Configure HACKRF while not streaming..");
  }

  //
  // Discard samples if a finished sample is delivered while we are
  // changing the configuration. This means we need to always set the
  // discard to true or false at the end of this routine.
  //

  hackrf_discard_samples = true;
  hackrf_discard_until = ros::Time::now() + ros::Duration(0, NS_TO_MS(5));


  if ( output -> sample_rate != input -> sample_rate ) {
    hackrf_set_sample_rate(dev, input -> sample_rate);
    output -> sample_rate = input -> sample_rate;

    output -> baseband_filter_bw_hz = hackrf_compute_baseband_filter_bw_round_down_lt(input -> sample_rate);
    int result = hackrf_set_baseband_filter_bandwidth(dev, output -> baseband_filter_bw_hz);

    delay = (delay < HACKRF_SETTLE_TIME_NS) ? HACKRF_SETTLE_TIME_NS : delay;
    ROS_INFO("Set HACKRF sample_rate to %f and filter %d\n", 
	     output -> sample_rate, output -> baseband_filter_bw_hz);
  }

  if (output -> frequency != input -> frequency ) {
    ROS_INFO("Try to set HACKRF frequency to %llu\n", (unsigned long long) input -> frequency);
    hackrf_set_freq(dev, input -> frequency);
    output -> frequency = input -> frequency;
    delay = (delay < HACKRF_SETTLE_TIME_NS) ? HACKRF_SETTLE_TIME_NS : delay;
    ROS_INFO("HACKRF frequency set to %llu\n", (unsigned long long) output -> frequency);
  }

  if ( output -> lnaGain != input -> lnaGain) {
    hackrf_set_lna_gain(dev, input -> lnaGain);
    output -> lnaGain = input -> lnaGain;
    ROS_INFO("Set HACKRF lna gain to %d\n", output -> lnaGain);
  }

  if ( output -> vgaGain != input -> vgaGain) {
    hackrf_set_vga_gain(dev, input -> vgaGain);
    output -> vgaGain = input -> vgaGain;
    ROS_INFO("Set HACKRF vga gain to %d\n", output -> vgaGain);
  }

  if ( output -> txvgaGain != input -> txvgaGain) {
    hackrf_set_txvga_gain(dev, input -> txvgaGain);
    output -> txvgaGain = input -> txvgaGain;
    ROS_INFO("Set HACKRF txvga gain to %d\n", output -> txvgaGain);
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

  if ( restart_hackrf ) {
    ROS_INFO("Restart HACKRF streaming..");
    hackrf_start_rx(dev, hackrf_rx_callback, NULL);
  }

  return delay;
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

  hackrf_pub = n.advertise<ros_sdr::hackrf_data>("hackrf_out",
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
  hackrf_init.sample_rate = 10000000;
  hackrf_init.lnaGain  = 16;
  hackrf_init.vgaGain  = 16;
  hackrf_init.txvgaGain  = 16;
  hackrf_init.ampEnable = 0;
  hackrf_init.antennaEnable = 0;

  hackrf_set_config(hackrfDev, &hackrf_current_state, &hackrf_init);


  msg.output = hackrf_current_state;

  //  std::vector<uint8> *buffer = new std::vector<uint8>(block_size);
  std_msgs::UInt8MultiArray &buffer = msg.iq;
  buffer.layout.dim.push_back(std_msgs::MultiArrayDimension());
  buffer.layout.dim[0].size = out_block_size;
  buffer.layout.dim[0].stride = 1;
  buffer.layout.dim[0].label = "IQ";
  buffer.data.resize(out_block_size);

  hackrf_start_rx(hackrfDev, hackrf_rx_callback, NULL);

  ros::Rate rate(200);
  while (ros::ok())
    {
      ros::spinOnce();
      rate.sleep();
    }


  ROS_INFO("ros_sdr hackrf_sdr exits\n");
  

  return 0;
}
