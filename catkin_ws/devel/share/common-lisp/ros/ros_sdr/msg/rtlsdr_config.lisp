; Auto-generated. Do not edit!


(cl:in-package ros_sdr-msg)


;//! \htmlinclude rtlsdr_config.msg.html

(cl:defclass <rtlsdr_config> (roslisp-msg-protocol:ros-message)
  ((frequency
    :reader frequency
    :initarg :frequency
    :type cl:integer
    :initform 0)
   (sample_rate
    :reader sample_rate
    :initarg :sample_rate
    :type cl:integer
    :initform 0)
   (gain
    :reader gain
    :initarg :gain
    :type cl:integer
    :initform 0)
   (ppm_error
    :reader ppm_error
    :initarg :ppm_error
    :type cl:integer
    :initform 0)
   (gainmode
    :reader gainmode
    :initarg :gainmode
    :type cl:fixnum
    :initform 0)
   (dithering
    :reader dithering
    :initarg :dithering
    :type cl:fixnum
    :initform 0)
   (direct_sampling
    :reader direct_sampling
    :initarg :direct_sampling
    :type cl:fixnum
    :initform 0))
)

(cl:defclass rtlsdr_config (<rtlsdr_config>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <rtlsdr_config>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'rtlsdr_config)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-msg:<rtlsdr_config> is deprecated: use ros_sdr-msg:rtlsdr_config instead.")))

(cl:ensure-generic-function 'frequency-val :lambda-list '(m))
(cl:defmethod frequency-val ((m <rtlsdr_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:frequency-val is deprecated.  Use ros_sdr-msg:frequency instead.")
  (frequency m))

(cl:ensure-generic-function 'sample_rate-val :lambda-list '(m))
(cl:defmethod sample_rate-val ((m <rtlsdr_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:sample_rate-val is deprecated.  Use ros_sdr-msg:sample_rate instead.")
  (sample_rate m))

(cl:ensure-generic-function 'gain-val :lambda-list '(m))
(cl:defmethod gain-val ((m <rtlsdr_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:gain-val is deprecated.  Use ros_sdr-msg:gain instead.")
  (gain m))

(cl:ensure-generic-function 'ppm_error-val :lambda-list '(m))
(cl:defmethod ppm_error-val ((m <rtlsdr_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:ppm_error-val is deprecated.  Use ros_sdr-msg:ppm_error instead.")
  (ppm_error m))

(cl:ensure-generic-function 'gainmode-val :lambda-list '(m))
(cl:defmethod gainmode-val ((m <rtlsdr_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:gainmode-val is deprecated.  Use ros_sdr-msg:gainmode instead.")
  (gainmode m))

(cl:ensure-generic-function 'dithering-val :lambda-list '(m))
(cl:defmethod dithering-val ((m <rtlsdr_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:dithering-val is deprecated.  Use ros_sdr-msg:dithering instead.")
  (dithering m))

(cl:ensure-generic-function 'direct_sampling-val :lambda-list '(m))
(cl:defmethod direct_sampling-val ((m <rtlsdr_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:direct_sampling-val is deprecated.  Use ros_sdr-msg:direct_sampling instead.")
  (direct_sampling m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <rtlsdr_config>) ostream)
  "Serializes a message object of type '<rtlsdr_config>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'sample_rate)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'sample_rate)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'sample_rate)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'sample_rate)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'gain)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ppm_error)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'gainmode)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'dithering)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'direct_sampling)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <rtlsdr_config>) istream)
  "Deserializes a message object of type '<rtlsdr_config>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'sample_rate)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'sample_rate)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'sample_rate)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'sample_rate)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gain) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ppm_error) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gainmode) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'dithering) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'direct_sampling) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<rtlsdr_config>)))
  "Returns string type for a message object of type '<rtlsdr_config>"
  "ros_sdr/rtlsdr_config")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'rtlsdr_config)))
  "Returns string type for a message object of type 'rtlsdr_config"
  "ros_sdr/rtlsdr_config")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<rtlsdr_config>)))
  "Returns md5sum for a message object of type '<rtlsdr_config>"
  "188b8912642464c74a1ab30117856134")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'rtlsdr_config)))
  "Returns md5sum for a message object of type 'rtlsdr_config"
  "188b8912642464c74a1ab30117856134")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<rtlsdr_config>)))
  "Returns full string definition for message of type '<rtlsdr_config>"
  (cl:format cl:nil "uint32 frequency~%uint32 sample_rate~%int32 gain~%int32 ppm_error~%int8 gainmode~%int8 dithering~%int8 direct_sampling~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'rtlsdr_config)))
  "Returns full string definition for message of type 'rtlsdr_config"
  (cl:format cl:nil "uint32 frequency~%uint32 sample_rate~%int32 gain~%int32 ppm_error~%int8 gainmode~%int8 dithering~%int8 direct_sampling~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <rtlsdr_config>))
  (cl:+ 0
     4
     4
     4
     4
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <rtlsdr_config>))
  "Converts a ROS message object to a list"
  (cl:list 'rtlsdr_config
    (cl:cons ':frequency (frequency msg))
    (cl:cons ':sample_rate (sample_rate msg))
    (cl:cons ':gain (gain msg))
    (cl:cons ':ppm_error (ppm_error msg))
    (cl:cons ':gainmode (gainmode msg))
    (cl:cons ':dithering (dithering msg))
    (cl:cons ':direct_sampling (direct_sampling msg))
))
