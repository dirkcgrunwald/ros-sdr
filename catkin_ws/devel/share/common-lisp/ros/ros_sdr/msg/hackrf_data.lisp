; Auto-generated. Do not edit!


(cl:in-package ros_sdr-msg)


;//! \htmlinclude hackrf_data.msg.html

(cl:defclass <hackrf_data> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (output
    :reader output
    :initarg :output
    :type ros_sdr-msg:hackrf_config
    :initform (cl:make-instance 'ros_sdr-msg:hackrf_config))
   (iq
    :reader iq
    :initarg :iq
    :type std_msgs-msg:UInt8MultiArray
    :initform (cl:make-instance 'std_msgs-msg:UInt8MultiArray)))
)

(cl:defclass hackrf_data (<hackrf_data>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <hackrf_data>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'hackrf_data)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-msg:<hackrf_data> is deprecated: use ros_sdr-msg:hackrf_data instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <hackrf_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:header-val is deprecated.  Use ros_sdr-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'output-val :lambda-list '(m))
(cl:defmethod output-val ((m <hackrf_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:output-val is deprecated.  Use ros_sdr-msg:output instead.")
  (output m))

(cl:ensure-generic-function 'iq-val :lambda-list '(m))
(cl:defmethod iq-val ((m <hackrf_data>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:iq-val is deprecated.  Use ros_sdr-msg:iq instead.")
  (iq m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <hackrf_data>) ostream)
  "Serializes a message object of type '<hackrf_data>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'output) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'iq) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <hackrf_data>) istream)
  "Deserializes a message object of type '<hackrf_data>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'output) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'iq) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<hackrf_data>)))
  "Returns string type for a message object of type '<hackrf_data>"
  "ros_sdr/hackrf_data")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'hackrf_data)))
  "Returns string type for a message object of type 'hackrf_data"
  "ros_sdr/hackrf_data")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<hackrf_data>)))
  "Returns md5sum for a message object of type '<hackrf_data>"
  "b13a3c54ef330b7d60be7e6a63d03378")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'hackrf_data)))
  "Returns md5sum for a message object of type 'hackrf_data"
  "b13a3c54ef330b7d60be7e6a63d03378")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<hackrf_data>)))
  "Returns full string definition for message of type '<hackrf_data>"
  (cl:format cl:nil "Header header~%ros_sdr/hackrf_config output~%std_msgs/UInt8MultiArray iq~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: ros_sdr/hackrf_config~%uint64 frequency~%float64 sample_rate~%uint32 baseband_filter_bw_hz	~%uint32 lnaGain~%uint32 vgaGain~%uint32 txvgaGain~%int8 ampEnable~%int8 antennaEnable~%~%================================================================================~%MSG: std_msgs/UInt8MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%uint8[]           data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding bytes at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'hackrf_data)))
  "Returns full string definition for message of type 'hackrf_data"
  (cl:format cl:nil "Header header~%ros_sdr/hackrf_config output~%std_msgs/UInt8MultiArray iq~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%# 0: no frame~%# 1: global frame~%string frame_id~%~%================================================================================~%MSG: ros_sdr/hackrf_config~%uint64 frequency~%float64 sample_rate~%uint32 baseband_filter_bw_hz	~%uint32 lnaGain~%uint32 vgaGain~%uint32 txvgaGain~%int8 ampEnable~%int8 antennaEnable~%~%================================================================================~%MSG: std_msgs/UInt8MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%uint8[]           data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding bytes at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <hackrf_data>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'output))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'iq))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <hackrf_data>))
  "Converts a ROS message object to a list"
  (cl:list 'hackrf_data
    (cl:cons ':header (header msg))
    (cl:cons ':output (output msg))
    (cl:cons ':iq (iq msg))
))
