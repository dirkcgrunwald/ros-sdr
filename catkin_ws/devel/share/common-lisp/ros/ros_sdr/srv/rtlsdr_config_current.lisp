; Auto-generated. Do not edit!


(cl:in-package ros_sdr-srv)


;//! \htmlinclude rtlsdr_config_current-request.msg.html

(cl:defclass <rtlsdr_config_current-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass rtlsdr_config_current-request (<rtlsdr_config_current-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <rtlsdr_config_current-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'rtlsdr_config_current-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-srv:<rtlsdr_config_current-request> is deprecated: use ros_sdr-srv:rtlsdr_config_current-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <rtlsdr_config_current-request>) ostream)
  "Serializes a message object of type '<rtlsdr_config_current-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <rtlsdr_config_current-request>) istream)
  "Deserializes a message object of type '<rtlsdr_config_current-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<rtlsdr_config_current-request>)))
  "Returns string type for a service object of type '<rtlsdr_config_current-request>"
  "ros_sdr/rtlsdr_config_currentRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'rtlsdr_config_current-request)))
  "Returns string type for a service object of type 'rtlsdr_config_current-request"
  "ros_sdr/rtlsdr_config_currentRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<rtlsdr_config_current-request>)))
  "Returns md5sum for a message object of type '<rtlsdr_config_current-request>"
  "daa827d21c973de634da209411f7e279")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'rtlsdr_config_current-request)))
  "Returns md5sum for a message object of type 'rtlsdr_config_current-request"
  "daa827d21c973de634da209411f7e279")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<rtlsdr_config_current-request>)))
  "Returns full string definition for message of type '<rtlsdr_config_current-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'rtlsdr_config_current-request)))
  "Returns full string definition for message of type 'rtlsdr_config_current-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <rtlsdr_config_current-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <rtlsdr_config_current-request>))
  "Converts a ROS message object to a list"
  (cl:list 'rtlsdr_config_current-request
))
;//! \htmlinclude rtlsdr_config_current-response.msg.html

(cl:defclass <rtlsdr_config_current-response> (roslisp-msg-protocol:ros-message)
  ((output
    :reader output
    :initarg :output
    :type ros_sdr-msg:rtlsdr_config
    :initform (cl:make-instance 'ros_sdr-msg:rtlsdr_config)))
)

(cl:defclass rtlsdr_config_current-response (<rtlsdr_config_current-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <rtlsdr_config_current-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'rtlsdr_config_current-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-srv:<rtlsdr_config_current-response> is deprecated: use ros_sdr-srv:rtlsdr_config_current-response instead.")))

(cl:ensure-generic-function 'output-val :lambda-list '(m))
(cl:defmethod output-val ((m <rtlsdr_config_current-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-srv:output-val is deprecated.  Use ros_sdr-srv:output instead.")
  (output m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <rtlsdr_config_current-response>) ostream)
  "Serializes a message object of type '<rtlsdr_config_current-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'output) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <rtlsdr_config_current-response>) istream)
  "Deserializes a message object of type '<rtlsdr_config_current-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'output) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<rtlsdr_config_current-response>)))
  "Returns string type for a service object of type '<rtlsdr_config_current-response>"
  "ros_sdr/rtlsdr_config_currentResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'rtlsdr_config_current-response)))
  "Returns string type for a service object of type 'rtlsdr_config_current-response"
  "ros_sdr/rtlsdr_config_currentResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<rtlsdr_config_current-response>)))
  "Returns md5sum for a message object of type '<rtlsdr_config_current-response>"
  "daa827d21c973de634da209411f7e279")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'rtlsdr_config_current-response)))
  "Returns md5sum for a message object of type 'rtlsdr_config_current-response"
  "daa827d21c973de634da209411f7e279")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<rtlsdr_config_current-response>)))
  "Returns full string definition for message of type '<rtlsdr_config_current-response>"
  (cl:format cl:nil "ros_sdr/rtlsdr_config output~%~%~%~%================================================================================~%MSG: ros_sdr/rtlsdr_config~%uint32 frequency~%uint32 sample_rate~%int32 gain~%int32 ppm_error~%int8 gainmode~%int8 dithering~%int8 direct_sampling~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'rtlsdr_config_current-response)))
  "Returns full string definition for message of type 'rtlsdr_config_current-response"
  (cl:format cl:nil "ros_sdr/rtlsdr_config output~%~%~%~%================================================================================~%MSG: ros_sdr/rtlsdr_config~%uint32 frequency~%uint32 sample_rate~%int32 gain~%int32 ppm_error~%int8 gainmode~%int8 dithering~%int8 direct_sampling~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <rtlsdr_config_current-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'output))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <rtlsdr_config_current-response>))
  "Converts a ROS message object to a list"
  (cl:list 'rtlsdr_config_current-response
    (cl:cons ':output (output msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'rtlsdr_config_current)))
  'rtlsdr_config_current-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'rtlsdr_config_current)))
  'rtlsdr_config_current-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'rtlsdr_config_current)))
  "Returns string type for a service object of type '<rtlsdr_config_current>"
  "ros_sdr/rtlsdr_config_current")