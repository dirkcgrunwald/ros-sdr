; Auto-generated. Do not edit!


(cl:in-package ros_sdr-srv)


;//! \htmlinclude hackrf_config_current-request.msg.html

(cl:defclass <hackrf_config_current-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass hackrf_config_current-request (<hackrf_config_current-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <hackrf_config_current-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'hackrf_config_current-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-srv:<hackrf_config_current-request> is deprecated: use ros_sdr-srv:hackrf_config_current-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <hackrf_config_current-request>) ostream)
  "Serializes a message object of type '<hackrf_config_current-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <hackrf_config_current-request>) istream)
  "Deserializes a message object of type '<hackrf_config_current-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<hackrf_config_current-request>)))
  "Returns string type for a service object of type '<hackrf_config_current-request>"
  "ros_sdr/hackrf_config_currentRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'hackrf_config_current-request)))
  "Returns string type for a service object of type 'hackrf_config_current-request"
  "ros_sdr/hackrf_config_currentRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<hackrf_config_current-request>)))
  "Returns md5sum for a message object of type '<hackrf_config_current-request>"
  "22e53c6482b45d72b0680a1186e76397")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'hackrf_config_current-request)))
  "Returns md5sum for a message object of type 'hackrf_config_current-request"
  "22e53c6482b45d72b0680a1186e76397")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<hackrf_config_current-request>)))
  "Returns full string definition for message of type '<hackrf_config_current-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'hackrf_config_current-request)))
  "Returns full string definition for message of type 'hackrf_config_current-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <hackrf_config_current-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <hackrf_config_current-request>))
  "Converts a ROS message object to a list"
  (cl:list 'hackrf_config_current-request
))
;//! \htmlinclude hackrf_config_current-response.msg.html

(cl:defclass <hackrf_config_current-response> (roslisp-msg-protocol:ros-message)
  ((output
    :reader output
    :initarg :output
    :type ros_sdr-msg:hackrf_config
    :initform (cl:make-instance 'ros_sdr-msg:hackrf_config)))
)

(cl:defclass hackrf_config_current-response (<hackrf_config_current-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <hackrf_config_current-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'hackrf_config_current-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-srv:<hackrf_config_current-response> is deprecated: use ros_sdr-srv:hackrf_config_current-response instead.")))

(cl:ensure-generic-function 'output-val :lambda-list '(m))
(cl:defmethod output-val ((m <hackrf_config_current-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-srv:output-val is deprecated.  Use ros_sdr-srv:output instead.")
  (output m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <hackrf_config_current-response>) ostream)
  "Serializes a message object of type '<hackrf_config_current-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'output) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <hackrf_config_current-response>) istream)
  "Deserializes a message object of type '<hackrf_config_current-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'output) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<hackrf_config_current-response>)))
  "Returns string type for a service object of type '<hackrf_config_current-response>"
  "ros_sdr/hackrf_config_currentResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'hackrf_config_current-response)))
  "Returns string type for a service object of type 'hackrf_config_current-response"
  "ros_sdr/hackrf_config_currentResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<hackrf_config_current-response>)))
  "Returns md5sum for a message object of type '<hackrf_config_current-response>"
  "22e53c6482b45d72b0680a1186e76397")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'hackrf_config_current-response)))
  "Returns md5sum for a message object of type 'hackrf_config_current-response"
  "22e53c6482b45d72b0680a1186e76397")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<hackrf_config_current-response>)))
  "Returns full string definition for message of type '<hackrf_config_current-response>"
  (cl:format cl:nil "ros_sdr/hackrf_config output~%~%~%~%================================================================================~%MSG: ros_sdr/hackrf_config~%uint64 frequency~%float64 sample_rate~%uint32 baseband_filter_bw_hz	~%uint32 lnaGain~%uint32 vgaGain~%uint32 txvgaGain~%int8 ampEnable~%int8 antennaEnable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'hackrf_config_current-response)))
  "Returns full string definition for message of type 'hackrf_config_current-response"
  (cl:format cl:nil "ros_sdr/hackrf_config output~%~%~%~%================================================================================~%MSG: ros_sdr/hackrf_config~%uint64 frequency~%float64 sample_rate~%uint32 baseband_filter_bw_hz	~%uint32 lnaGain~%uint32 vgaGain~%uint32 txvgaGain~%int8 ampEnable~%int8 antennaEnable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <hackrf_config_current-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'output))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <hackrf_config_current-response>))
  "Converts a ROS message object to a list"
  (cl:list 'hackrf_config_current-response
    (cl:cons ':output (output msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'hackrf_config_current)))
  'hackrf_config_current-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'hackrf_config_current)))
  'hackrf_config_current-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'hackrf_config_current)))
  "Returns string type for a service object of type '<hackrf_config_current>"
  "ros_sdr/hackrf_config_current")