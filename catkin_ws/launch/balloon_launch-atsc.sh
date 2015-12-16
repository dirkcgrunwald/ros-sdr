#!/bin/bash
source ../devel/setup.bash
roslaunch mavros px4.launch &
sleep 10s
rosrun temp_mon temp_mon_node &
sleep 2s
rosrun ros_sdr hackrf_sdr &
sleep 5s
roslaunch ros_sdr sdr_rec.launch & 
sleep 5s
rosrun ros_sdr atsc_tuner.py &
