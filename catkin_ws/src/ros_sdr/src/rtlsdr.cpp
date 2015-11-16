#include "ros/ros.h"
#include "std_msgs/String.h"

#include <sstream>

#include "ros/ros.h"
#include "ros_sdr/rtlsdr_config.h"
#include "rtsl-sdr.h"

#define DEFAULT_SAMPLE_RATE	2048000
#define DEFAULT_BUF_LENGTH	(16 * 16384)
#define MINIMAL_BUF_LENGTH	512
#define MAXIMAL_BUF_LENGTH	(256 * 16384)

static rtlsdr_dev_t *dev = NULL;


bool add(dirk_tutorial::AddTwoInts::Request  &req,
         dirk_tutorial::AddTwoInts::Response &res)
{
  res.sum = req.a + req.b;
  ROS_INFO("COMBO request: x=%ld, y=%ld", (long int)req.a, (long int)req.b);
  ROS_INFO("COMBO sending back response: [%ld]", (long int)res.sum);
  return true;
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "rtl_sdr");
  ros::NodeHandle n;

  ros::ServiceServer service = n.advertiseService("rtl_sdr_config",
						  rtl_sdr_config);
  ROS_INFO("Ready to configure rtl_sdr.");
  ros::Publisher chatter_pub = n.advertise<std_msgs::String>("rtl_sdr_out",
							     1000);
  ros::Rate loop_rate(10);

  
  int out_block_size = DEFAULT_BUF_LENGTH;
  uint32_t dev_index = 0;

  uint8_t *buffer = malloc( out_block_size * sizeof(uint8_t) );

  int r = rtlsdr_open(&dev, (uint32_t) dev_index);
  if ( r < 0 ) {
    ROS_INFO("Failed to open rtlsdr device #%d.\n", dev);
    return;
  }

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
