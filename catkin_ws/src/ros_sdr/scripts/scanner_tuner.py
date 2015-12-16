#!/usr/bin/env python
import rospy
import ros_sdr.msg
import ros_sdr.srv

hackrfState = None

def mhz(x):
    return x * 1000000

MinFreqMhz = mhz(10)
MaxFreqMhz = mhz(7000)
StepFreqMhz = mhz(10)
StepsTotal = (MaxFreqMhz - MinFreqMhz)/StepFreqMhz
DwellTime = 0.25 # seconds
TotalScanTime = StepsTotal * DwellTime
InterScanSleep = 120 # two minutes
DataPerScanMB = (TotalScanTime * StepFreqMhz * 2) / (1024 * 1024.)
DataAvailableMB = 100 * 1024
DataAvailableScans = DataAvailableMB / DataPerScanMB
DataRecordingTimeSec = DataAvailableScans * (TotalScanTime + InterScanSleep)
DataRecordingTimeHr = DataRecordingTimeSec / (60. * 60.)

print "Scanning from ", MinFreqMhz, "to", MaxFreqMhz, "in", StepFreqMhz, "hz steps"
print "Total of ", StepsTotal, "steps taking a total of ", TotalScanTime, "seconds"
print "with an inter-scan delay of ", InterScanSleep, "seconds, taking ", (InterScanSleep + TotalScanTime)/(60.), "minutes per scan"

print "Each scan generates", DataPerScanMB, "MB for a total of ", DataAvailableScans, "scans over", DataRecordingTimeHr, "hours"

def fmt_output(output):
    return "(%f MHz, %f MS/s, sample bw %f, lnaGain %d, vgaGain %d)" % (output.frequency/1000000.0,
                                                          output.sample_rate/1000000.0,
                                                          output.baseband_filter_bw_hz/1000000.0,
                                                          output.lnaGain,
                                                          output.vgaGain)

def listener():
    rospy.init_node('scanner', anonymous=True)

    #
    # get current state
    #

    sdr_recorder_config_srv = rospy.ServiceProxy('sdr_recorder_config_srv',
                                           ros_sdr.srv.sdr_recorder_config_srv)

    sdr_recorder_config_current = rospy.ServiceProxy('sdr_recorder_config_current',
                                               ros_sdr.srv.sdr_recorder_config_current)

    sdr_recorderState = sdr_recorder_config_current()
    sdr_recorderState.config.output_prefix="scanner"
    sdr_recorder_config_srv(sdr_recorderState.config)


    hackrf_config_srv = rospy.ServiceProxy('hackrf_config_srv',
                                           ros_sdr.srv.hackrf_config_srv)

    hackrf_config_current = rospy.ServiceProxy('hackrf_config_current',
                                               ros_sdr.srv.hackrf_config_current)

    hackrfState = hackrf_config_current()

    print("hackrfState is " + fmt_output(hackrfState.output) )

    while not rospy.is_shutdown():
        freq = MinFreqMhz
        while freq < MaxFreqMhz:
            hackrfState.output.frequency = freq
            hackrfState.output.sample_rate = StepFreqMhz
            hackrfState.output.lnaGain=32
            hackrfState.output.vgaGain=16
            hackrfState.store.output_prefix="scanner"
            hackrfState.store.recording = 1
            hackrfState = hackrf_config_srv(hackrfState.output, hackrfState.store);
            rospy.loginfo("updated hackrfState is now " + fmt_output(hackrfState.output) )
            rospy.sleep( DwellTime )
            freq = freq + StepFreqMhz
        if InterScanSleep > 0:
                hackrfState.store.recording = 0
                hackrfState = hackrf_config_srv(hackrfState.output, hackrfState.store)
                rospy.sleep( InterScanSleep )
            
if __name__ == '__main__':
    listener()
