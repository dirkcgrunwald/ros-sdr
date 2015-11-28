#!/usr/bin/env python
import rospy
import ros_sdr.msg
import ros_sdr.srv

hackrfState = None

def fmt_output(output):
    return "(%f MHz, %f MS/s, sample bw %f, lnaGain %d, vgaGain %d)" % (output.frequency/1000000.0,
                                                          output.sample_rate/1000000.0,
                                                          output.baseband_filter_bw_hz/1000000.0,
                                                          output.lnaGain,
                                                          output.vgaGain)

def hackrfOutCallback(data):
    rospy.loginfo(rospy.get_caller_id() + "Configuration %s", fmt_output(data.output))
    rospy.loginfo("output " + data.iq.layout.dim[0].label + " has " + str(data.iq.layout.dim[0].size) + " samples")
    rospy.loginfo("First two samples are (%d, %d)" % ( ord(data.iq.data[0]) , ord(data.iq.data[1]) ) )
    rospy.loginfo("Length of data array is %d" % len(data.iq.data))

def listener():
    rospy.init_node('listener', anonymous=True)

    #
    # get current state
    #

    hackrf_config_srv = rospy.ServiceProxy('hackrf_config_srv', ros_sdr.srv.hackrf_config_srv)

    hackrf_config_current = rospy.ServiceProxy('hackrf_config_current', ros_sdr.srv.hackrf_config_current)

    hackrfState = hackrf_config_current()

    print("hackrfState is " + fmt_output(hackrfState.output) )

    ##
    ## Set frequency to 90.1 MHz
    ##

    hackrfState.output.frequency = 90.1 * 100000;
    hackrfState.output.sample_rate = 100000 # 100Hhz
    hackrfState.output.lnaGain=16
    hackrfState.output.vgaGain=62
    hackrfState = hackrf_config_srv(hackrfState.output);

    print("updated hackrfState is now " + fmt_output(hackrfState.output) )

    rospy.Subscriber("hackrf_out", ros_sdr.msg.hackrf_data, hackrfOutCallback)

    # spin() simply keeps python from exiting until this node is stopped
    rospy.spin()

if __name__ == '__main__':
    listener()
