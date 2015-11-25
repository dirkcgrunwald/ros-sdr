#!/usr/bin/env python
import rospy
import ros_sdr.msg
import ros_sdr.srv

rtlsdrState = None

def fmt_output(output):
    return "(%f MHz, %f MS/s, gainmode %d, gain %d, ppm %d)" % (output.frequency/1000000.0,
                                              output.sample_rate/1000000.0,
                                              output.gainmode,
                                              output.gain,
                                              output.ppm_error)

def rtlsdrOutCallback(data):
    rospy.loginfo(rospy.get_caller_id() + "Configuration %s", fmt_output(data.output))
    rospy.loginfo("output " + data.iq.layout.dim[0].label + " has " + str(data.iq.layout.dim[0].size) + " samples")
    rospy.loginfo("First two samples are (%d, %d)" % ( ord(data.iq.data[0]) , ord(data.iq.data[1]) ) )
    rospy.loginfo("Length of data array is %d" % len(data.iq.data))

def listener():
    # In ROS, nodes are uniquely named. If two nodes with the same
    # node are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    rospy.init_node('listener', anonymous=True)

    #
    # get current state
    #

    rtlsdr_config_srv = rospy.ServiceProxy('rtlsdr_config_srv', ros_sdr.srv.rtlsdr_config_srv)

    rtlsdr_config_current = rospy.ServiceProxy('rtlsdr_config_current', ros_sdr.srv.rtlsdr_config_current)

    rtlsdrState = rtlsdr_config_current()

    print("rtlsdrState is " + fmt_output(rtlsdrState.output) )

    ##
    ## Set frequency to 915 MHz
    ##

    rtlsdrState.output.frequency = 915 * 1000000;
    rtlsdrState = rtlsdr_config_srv(rtlsdrState.output);

    print("updated rtlsdrState is now " + fmt_output(rtlsdrState.output) )

    rospy.Subscriber("rtlsdr_out", ros_sdr.msg.rtlsdr_data, rtlsdrOutCallback)

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    listener()
