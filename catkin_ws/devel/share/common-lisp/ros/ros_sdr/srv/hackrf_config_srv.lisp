; Auto-generated. Do not edit!


(cl:in-package ros_sdr-srv)


;//! \htmlinclude hackrf_config_srv-request.msg.html

(cl:defclass <hackrf_config_srv-request> (roslisp-msg-protocol:ros-message)
  ((input
    :reader input
    :initarg :input
    :type ros_sdr-msg:hackrf_config
    :initform (cl:make-instance 'ros_sdr-msg:hackrf_config)))
)

(cl:defclass hackrf_config_srv-request (<hackrf_config_srv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <hackrf_config_srv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'hackrf_config_srv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-srv:<hackrf_config_srv-request> is deprecated: use ros_sdr-srv:hackrf_config_srv-request instead.")))

(cl:ensure-generic-function 'input-val :lambda-list '(m))
(cl:defmethod input-val ((m <hackrf_config_srv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-srv:input-val is deprecated.  Use ros_sdr-srv:input instead.")
  (input m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <hackrf_config_srv-request>) ostream)
  "Serializes a message object of type '<hackrf_config_srv-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'input) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <hackrf_config_srv-request>) istream)
  "Deserializes a message object of type '<hackrf_config_srv-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'input) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<hackrf_config_srv-request>)))
  "Returns string type for a service object of type '<hackrf_config_srv-request>"
  "ros_sdr/hackrf_config_srvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'hackrf_config_srv-request)))
  "Returns string type for a service object of type 'hackrf_config_srv-request"
  "ros_sdr/hackrf_config_srvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<hackrf_config_srv-request>)))
  "Returns md5sum for a message object of type '<hackrf_config_srv-request>"
  "8abe3cfb165ed96bd1b19e38938d04c7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'hackrf_config_srv-request)))
  "Returns md5sum for a message object of type 'hackrf_config_srv-request"
  "8abe3cfb165ed96bd1b19e38938d04c7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<hackrf_config_srv-request>)))
  "Returns full string definition for message of type '<hackrf_config_srv-request>"
  (cl:format cl:nil "ros_sdr/hackrf_config input~%~%================================================================================~%MSG: ros_sdr/hackrf_config~%uint64 frequency~%float64 sample_rate~%uint32 baseband_filter_bw_hz	~%uint32 lnaGain~%uint32 vgaGain~%uint32 txvgaGain~%int8 ampEnable~%int8 antennaEnable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'hackrf_config_srv-request)))
  "Returns full string definition for message of type 'hackrf_config_srv-request"
  (cl:format cl:nil "ros_sdr/hackrf_config input~%~%================================================================================~%MSG: ros_sdr/hackrf_config~%uint64 frequency~%float64 sample_rate~%uint32 baseband_filter_bw_hz	~%uint32 lnaGain~%uint32 vgaGain~%uint32 txvgaGain~%int8 ampEnable~%int8 antennaEnable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <hackrf_config_srv-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'input))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <hackrf_config_srv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'hackrf_config_srv-request
    (cl:cons ':input (input msg))
))
;//! \htmlinclude hackrf_config_srv-response.msg.html

(cl:defclass <hackrf_config_srv-response> (roslisp-msg-protocol:ros-message)
  ((output
    :reader output
    :initarg :output
    :type ros_sdr-msg:hackrf_config
    :initform (cl:make-instance 'ros_sdr-msg:hackrf_config)))
)

(cl:defclass hackrf_config_srv-response (<hackrf_config_srv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <hackrf_config_srv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'hackrf_config_srv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-srv:<hackrf_config_srv-response> is deprecated: use ros_sdr-srv:hackrf_config_srv-response instead.")))

(cl:ensure-generic-function 'output-val :lambda-list '(m))
(cl:defmethod output-val ((m <hackrf_config_srv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-srv:output-val is deprecated.  Use ros_sdr-srv:output instead.")
  (output m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <hackrf_config_srv-response>) ostream)
  "Serializes a message object of type '<hackrf_config_srv-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'output) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <hackrf_config_srv-response>) istream)
  "Deserializes a message object of type '<hackrf_config_srv-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'output) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<hackrf_config_srv-response>)))
  "Returns string type for a service object of type '<hackrf_config_srv-response>"
  "ros_sdr/hackrf_config_srvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'hackrf_config_srv-response)))
  "Returns string type for a service object of type 'hackrf_config_srv-response"
  "ros_sdr/hackrf_config_srvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<hackrf_config_srv-response>)))
  "Returns md5sum for a message object of type '<hackrf_config_srv-response>"
  "8abe3cfb165ed96bd1b19e38938d04c7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'hackrf_config_srv-response)))
  "Returns md5sum for a message object of type 'hackrf_config_srv-response"
  "8abe3cfb165ed96bd1b19e38938d04c7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<hackrf_config_srv-response>)))
  "Returns full string definition for message of type '<hackrf_config_srv-response>"
  (cl:format cl:nil "ros_sdr/hackrf_config output~%~%~%~%================================================================================~%MSG: ros_sdr/hackrf_config~%uint64 frequency~%float64 sample_rate~%uint32 baseband_filter_bw_hz	~%uint32 lnaGain~%uint32 vgaGain~%uint32 txvgaGain~%int8 ampEnable~%int8 antennaEnable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'hackrf_config_srv-response)))
  "Returns full string definition for message of type 'hackrf_config_srv-response"
  (cl:format cl:nil "ros_sdr/hackrf_config output~%~%~%~%================================================================================~%MSG: ros_sdr/hackrf_config~%uint64 frequency~%float64 sample_rate~%uint32 baseband_filter_bw_hz	~%uint32 lnaGain~%uint32 vgaGain~%uint32 txvgaGain~%int8 ampEnable~%int8 antennaEnable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <hackrf_config_srv-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'output))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <hackrf_config_srv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'hackrf_config_srv-response
    (cl:cons ':output (output msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'hackrf_config_srv)))
  'hackrf_config_srv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'hackrf_config_srv)))
  'hackrf_config_srv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'hackrf_config_srv)))
  "Returns string type for a service object of type '<hackrf_config_srv>"
  "ros_sdr/hackrf_config_srv")