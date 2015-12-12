#!/usr/bin/env python
import rospy
import ros_sdr.msg
import ros_sdr.srv

hackrfState = None

def mhz(x):
    return x * 1000000


atscScan = [
	  { 'freq' : mhz(533), 'dwell' : 2.0, 'rate' : mhz(6), 'sleepAfter': 1.0 },
	  { 'freq' : mhz(617), 'dwell' : 2.0, 'rate' : mhz(6), 'sleepAfter': 1.0 }
]

sleepBetweenScans = 10


def fmt_output(output):
    return "(%f MHz, %f MS/s, sample bw %f, lnaGain %d, vgaGain %d)" % (output.frequency/1000000.0,
                                                          output.sample_rate/1000000.0,
                                                          output.baseband_filter_bw_hz/1000000.0,
                                                          output.lnaGain,
                                                          output.vgaGain)



def listener():
    rospy.init_node('listener', anonymous=True)

    #
    # get current state
    #

    sdr_recorder_config_srv = rospy.ServiceProxy('sdr_recorder_config_srv',
                                           ros_sdr.srv.sdr_recorder_config_srv)

    sdr_recorder_config_current = rospy.ServiceProxy('sdr_recorder_config_current',
                                               ros_sdr.srv.sdr_recorder_config_current)

    sdr_recorderState = sdr_recorder_config_current()
    sdr_recorderState.config.output_prefix="atsc"
    sdr_recorder_config_srv(sdr_recorderState.config)


    hackrf_config_srv = rospy.ServiceProxy('hackrf_config_srv',
                                           ros_sdr.srv.hackrf_config_srv)

    hackrf_config_current = rospy.ServiceProxy('hackrf_config_current',
                                               ros_sdr.srv.hackrf_config_current)

    hackrfState = hackrf_config_current()

    print("hackrfState is " + fmt_output(hackrfState.output) )

    while not rospy.is_shutdown():
        for scan in atscScan:
            hackrfState.output.frequency = scan['freq']
            hackrfState.output.sample_rate = scan['rate']
            hackrfState.output.lnaGain=16
            hackrfState.output.vgaGain=40
            hackrfState.store.output_prefix="atsc"
            hackrfState.store.recording = 1
            hackrfState = hackrf_config_srv(hackrfState.output, hackrfState.store);
            rospy.loginfo("updated hackrfState is now " + fmt_output(hackrfState.output) )
            rospy.sleep( scan['dwell'] )

            if (scan['sleepAfter'] > 0):
                hackrfState.store.recording = 0
                hackrfState = hackrf_config_srv(hackrfState.output, hackrfState.store)
                rospy.sleep( scan['sleepAfter'] )
        if sleepBetweenScans > 0:
                hackrfState.store.recording = 0
                hackrfState = hackrf_config_srv(hackrfState.output, hackrfState.store)
                rospy.sleep( sleepBetweenScans )
            

if __name__ == '__main__':
    listener()
