; Auto-generated. Do not edit!


(cl:in-package ros_sdr-msg)


;//! \htmlinclude hackrf_config.msg.html

(cl:defclass <hackrf_config> (roslisp-msg-protocol:ros-message)
  ((frequency
    :reader frequency
    :initarg :frequency
    :type cl:integer
    :initform 0)
   (sample_rate
    :reader sample_rate
    :initarg :sample_rate
    :type cl:float
    :initform 0.0)
   (baseband_filter_bw_hz
    :reader baseband_filter_bw_hz
    :initarg :baseband_filter_bw_hz
    :type cl:integer
    :initform 0)
   (lnaGain
    :reader lnaGain
    :initarg :lnaGain
    :type cl:integer
    :initform 0)
   (vgaGain
    :reader vgaGain
    :initarg :vgaGain
    :type cl:integer
    :initform 0)
   (txvgaGain
    :reader txvgaGain
    :initarg :txvgaGain
    :type cl:integer
    :initform 0)
   (ampEnable
    :reader ampEnable
    :initarg :ampEnable
    :type cl:fixnum
    :initform 0)
   (antennaEnable
    :reader antennaEnable
    :initarg :antennaEnable
    :type cl:fixnum
    :initform 0))
)

(cl:defclass hackrf_config (<hackrf_config>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <hackrf_config>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'hackrf_config)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ros_sdr-msg:<hackrf_config> is deprecated: use ros_sdr-msg:hackrf_config instead.")))

(cl:ensure-generic-function 'frequency-val :lambda-list '(m))
(cl:defmethod frequency-val ((m <hackrf_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:frequency-val is deprecated.  Use ros_sdr-msg:frequency instead.")
  (frequency m))

(cl:ensure-generic-function 'sample_rate-val :lambda-list '(m))
(cl:defmethod sample_rate-val ((m <hackrf_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:sample_rate-val is deprecated.  Use ros_sdr-msg:sample_rate instead.")
  (sample_rate m))

(cl:ensure-generic-function 'baseband_filter_bw_hz-val :lambda-list '(m))
(cl:defmethod baseband_filter_bw_hz-val ((m <hackrf_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:baseband_filter_bw_hz-val is deprecated.  Use ros_sdr-msg:baseband_filter_bw_hz instead.")
  (baseband_filter_bw_hz m))

(cl:ensure-generic-function 'lnaGain-val :lambda-list '(m))
(cl:defmethod lnaGain-val ((m <hackrf_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:lnaGain-val is deprecated.  Use ros_sdr-msg:lnaGain instead.")
  (lnaGain m))

(cl:ensure-generic-function 'vgaGain-val :lambda-list '(m))
(cl:defmethod vgaGain-val ((m <hackrf_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:vgaGain-val is deprecated.  Use ros_sdr-msg:vgaGain instead.")
  (vgaGain m))

(cl:ensure-generic-function 'txvgaGain-val :lambda-list '(m))
(cl:defmethod txvgaGain-val ((m <hackrf_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:txvgaGain-val is deprecated.  Use ros_sdr-msg:txvgaGain instead.")
  (txvgaGain m))

(cl:ensure-generic-function 'ampEnable-val :lambda-list '(m))
(cl:defmethod ampEnable-val ((m <hackrf_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:ampEnable-val is deprecated.  Use ros_sdr-msg:ampEnable instead.")
  (ampEnable m))

(cl:ensure-generic-function 'antennaEnable-val :lambda-list '(m))
(cl:defmethod antennaEnable-val ((m <hackrf_config>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ros_sdr-msg:antennaEnable-val is deprecated.  Use ros_sdr-msg:antennaEnable instead.")
  (antennaEnable m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <hackrf_config>) ostream)
  "Serializes a message object of type '<hackrf_config>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'frequency)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'frequency)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'sample_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'baseband_filter_bw_hz)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'baseband_filter_bw_hz)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'baseband_filter_bw_hz)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'baseband_filter_bw_hz)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'lnaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'lnaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'lnaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'lnaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'vgaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'vgaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'vgaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'vgaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'txvgaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'txvgaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'txvgaGain)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'txvgaGain)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'ampEnable)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'antennaEnable)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <hackrf_config>) istream)
  "Deserializes a message object of type '<hackrf_config>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 32) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 40) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 48) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 56) (cl:slot-value msg 'frequency)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'sample_rate) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'baseband_filter_bw_hz)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'baseband_filter_bw_hz)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'baseband_filter_bw_hz)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'baseband_filter_bw_hz)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'lnaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'lnaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'lnaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'lnaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'vgaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'vgaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'vgaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'vgaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'txvgaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'txvgaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'txvgaGain)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'txvgaGain)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ampEnable) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'antennaEnable) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<hackrf_config>)))
  "Returns string type for a message object of type '<hackrf_config>"
  "ros_sdr/hackrf_config")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'hackrf_config)))
  "Returns string type for a message object of type 'hackrf_config"
  "ros_sdr/hackrf_config")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<hackrf_config>)))
  "Returns md5sum for a message object of type '<hackrf_config>"
  "5df33ff59a52574b6d910ea12bc909fe")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'hackrf_config)))
  "Returns md5sum for a message object of type 'hackrf_config"
  "5df33ff59a52574b6d910ea12bc909fe")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<hackrf_config>)))
  "Returns full string definition for message of type '<hackrf_config>"
  (cl:format cl:nil "uint64 frequency~%float64 sample_rate~%uint32 baseband_filter_bw_hz	~%uint32 lnaGain~%uint32 vgaGain~%uint32 txvgaGain~%int8 ampEnable~%int8 antennaEnable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'hackrf_config)))
  "Returns full string definition for message of type 'hackrf_config"
  (cl:format cl:nil "uint64 frequency~%float64 sample_rate~%uint32 baseband_filter_bw_hz	~%uint32 lnaGain~%uint32 vgaGain~%uint32 txvgaGain~%int8 ampEnable~%int8 antennaEnable~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <hackrf_config>))
  (cl:+ 0
     8
     8
     4
     4
     4
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <hackrf_config>))
  "Converts a ROS message object to a list"
  (cl:list 'hackrf_config
    (cl:cons ':frequency (frequency msg))
    (cl:cons ':sample_rate (sample_rate msg))
    (cl:cons ':baseband_filter_bw_hz (baseband_filter_bw_hz msg))
    (cl:cons ':lnaGain (lnaGain msg))
    (cl:cons ':vgaGain (vgaGain msg))
    (cl:cons ':txvgaGain (txvgaGain msg))
    (cl:cons ':ampEnable (ampEnable msg))
    (cl:cons ':antennaEnable (antennaEnable msg))
))
