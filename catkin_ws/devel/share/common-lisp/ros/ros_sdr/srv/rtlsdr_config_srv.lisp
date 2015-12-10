; Auto-generated. Do not edit!


(cl:in-package ros_sdr-srv)


;//! \htmlinclude rtlsdr_config_srv-request.msg.html

(cl:defclass <rtlsdr_config_srv-request> (roslisp-msg-protocol:ros-message)
  ((input
    :reader input
    :initarg :input
    :type ros_sdr-msg:rtlsdr_config
    :initform (cl:make-instance 'ros_sdr-msg:rtlsdr_config)))
)

(cl:defclass rtlsdr_config_srv-request (<rtlsdr_config_srv-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <rtlsdr_config_srv-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'rtlsdr_config_srv-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-srv:<rtlsdr_config_srv-request> is deprecated: use ros_sdr-srv:rtlsdr_config_srv-request instead.")))

(cl:ensure-generic-function 'input-val :lambda-list '(m))
(cl:defmethod input-val ((m <rtlsdr_config_srv-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-srv:input-val is deprecated.  Use ros_sdr-srv:input instead.")
  (input m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <rtlsdr_config_srv-request>) ostream)
  "Serializes a message object of type '<rtlsdr_config_srv-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'input) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <rtlsdr_config_srv-request>) istream)
  "Deserializes a message object of type '<rtlsdr_config_srv-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'input) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<rtlsdr_config_srv-request>)))
  "Returns string type for a service object of type '<rtlsdr_config_srv-request>"
  "ros_sdr/rtlsdr_config_srvRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'rtlsdr_config_srv-request)))
  "Returns string type for a service object of type 'rtlsdr_config_srv-request"
  "ros_sdr/rtlsdr_config_srvRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<rtlsdr_config_srv-request>)))
  "Returns md5sum for a message object of type '<rtlsdr_config_srv-request>"
  "890ecb4c989c644f8aa7973610d1e673")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'rtlsdr_config_srv-request)))
  "Returns md5sum for a message object of type 'rtlsdr_config_srv-request"
  "890ecb4c989c644f8aa7973610d1e673")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<rtlsdr_config_srv-request>)))
  "Returns full string definition for message of type '<rtlsdr_config_srv-request>"
  (cl:format cl:nil "ros_sdr/rtlsdr_config input~%~%================================================================================~%MSG: ros_sdr/rtlsdr_config~%uint32 frequency~%uint32 sample_rate~%int32 gain~%int32 ppm_error~%int8 gainmode~%int8 dithering~%int8 direct_sampling~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'rtlsdr_config_srv-request)))
  "Returns full string definition for message of type 'rtlsdr_config_srv-request"
  (cl:format cl:nil "ros_sdr/rtlsdr_config input~%~%================================================================================~%MSG: ros_sdr/rtlsdr_config~%uint32 frequency~%uint32 sample_rate~%int32 gain~%int32 ppm_error~%int8 gainmode~%int8 dithering~%int8 direct_sampling~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <rtlsdr_config_srv-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'input))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <rtlsdr_config_srv-request>))
  "Converts a ROS message object to a list"
  (cl:list 'rtlsdr_config_srv-request
    (cl:cons ':input (input msg))
))
;//! \htmlinclude rtlsdr_config_srv-response.msg.html

(cl:defclass <rtlsdr_config_srv-response> (roslisp-msg-protocol:ros-message)
  ((output
    :reader output
    :initarg :output
    :type ros_sdr-msg:rtlsdr_config
    :initform (cl:make-instance 'ros_sdr-msg:rtlsdr_config)))
)

(cl:defclass rtlsdr_config_srv-response (<rtlsdr_config_srv-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <rtlsdr_config_srv-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'rtlsdr_config_srv-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-srv:<rtlsdr_config_srv-response> is deprecated: use ros_sdr-srv:rtlsdr_config_srv-response instead.")))

(cl:ensure-generic-function 'output-val :lambda-list '(m))
(cl:defmethod output-val ((m <rtlsdr_config_srv-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-srv:output-val is deprecated.  Use ros_sdr-srv:output instead.")
  (output m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <rtlsdr_config_srv-response>) ostream)
  "Serializes a message object of type '<rtlsdr_config_srv-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'output) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <rtlsdr_config_srv-response>) istream)
  "Deserializes a message object of type '<rtlsdr_config_srv-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'output) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<rtlsdr_config_srv-response>)))
  "Returns string type for a service object of type '<rtlsdr_config_srv-response>"
  "ros_sdr/rtlsdr_config_srvResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'rtlsdr_config_srv-response)))
  "Returns string type for a service object of type 'rtlsdr_config_srv-response"
  "ros_sdr/rtlsdr_config_srvResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<rtlsdr_config_srv-response>)))
  "Returns md5sum for a message object of type '<rtlsdr_config_srv-response>"
  "890ecb4c989c644f8aa7973610d1e673")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'rtlsdr_config_srv-response)))
  "Returns md5sum for a message object of type 'rtlsdr_config_srv-response"
  "890ecb4c989c644f8aa7973610d1e673")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<rtlsdr_config_srv-response>)))
  "Returns full string definition for message of type '<rtlsdr_config_srv-response>"
  (cl:format cl:nil "ros_sdr/rtlsdr_config output~%~%~%~%================================================================================~%MSG: ros_sdr/rtlsdr_config~%uint32 frequency~%uint32 sample_rate~%int32 gain~%int32 ppm_error~%int8 gainmode~%int8 dithering~%int8 direct_sampling~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'rtlsdr_config_srv-response)))
  "Returns full string definition for message of type 'rtlsdr_config_srv-response"
  (cl:format cl:nil "ros_sdr/rtlsdr_config output~%~%~%~%================================================================================~%MSG: ros_sdr/rtlsdr_config~%uint32 frequency~%uint32 sample_rate~%int32 gain~%int32 ppm_error~%int8 gainmode~%int8 dithering~%int8 direct_sampling~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <rtlsdr_config_srv-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'output))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <rtlsdr_config_srv-response>))
  "Converts a ROS message object to a list"
  (cl:list 'rtlsdr_config_srv-response
    (cl:cons ':output (output msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'rtlsdr_config_srv)))
  'rtlsdr_config_srv-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'rtlsdr_config_srv)))
  'rtlsdr_config_srv-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'rtlsdr_config_srv)))
  "Returns string type for a service object of type '<rtlsdr_config_srv>"
  "ros_sdr/rtlsdr_config_srv")