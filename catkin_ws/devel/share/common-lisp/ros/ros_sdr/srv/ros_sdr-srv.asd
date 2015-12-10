
(cl:in-package :asdf)

(defsystem "ros_sdr-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :ros_sdr-msg
)
  :components ((:file "_package")
    (:file "rtlsdr_config_current" :depends-on ("_package_rtlsdr_config_current"))
    (:file "_package_rtlsdr_config_current" :depends-on ("_package"))
    (:file "rtlsdr_config_srv" :depends-on ("_package_rtlsdr_config_srv"))
    (:file "_package_rtlsdr_config_srv" :depends-on ("_package"))
    (:file "hackrf_config_srv" :depends-on ("_package_hackrf_config_srv"))
    (:file "_package_hackrf_config_srv" :depends-on ("_package"))
    (:file "hackrf_config_current" :depends-on ("_package_hackrf_config_current"))
    (:file "_package_hackrf_config_current" :depends-on ("_package"))
  ))