SRC_DIR=.
CPP_DST=../catkin_ws/src/ros_sdr/src
PYTHON_DST=../catkin_ws/src/ros_sdr/scripts

all:
	protoc -I=$(SRC_DIR) --cpp_out=$(CPP_DST) --python_out=$(PYTHON_DST) $(SRC_DIR)/sdr_data.proto
	cp $(PYTHON_DST)/sdr_data_pb2.py .
