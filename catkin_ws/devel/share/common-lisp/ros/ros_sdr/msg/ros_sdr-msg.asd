
(cl:in-package :asdf)

(defsystem "ros_sdr-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "hackrf_config" :depends-on ("_package_hackrf_config"))
    (:file "_package_hackrf_config" :depends-on ("_package"))
    (:file "hackrf_data" :depends-on ("_package_hackrf_data"))
    (:file "_package_hackrf_data" :depends-on ("_package"))
    (:file "rtlsdr_data" :depends-on ("_package_rtlsdr_data"))
    (:file "_package_rtlsdr_data" :depends-on ("_package"))
    (:file "rtlsdr_config" :depends-on ("_package_rtlsdr_config"))
    (:file "_package_rtlsdr_config" :depends-on ("_package"))
    (:file "hackrf_config" :depends-on ("_package_hackrf_config"))
    (:file "_package_hackrf_config" :depends-on ("_package"))
    (:file "hackrf_data" :depends-on ("_package_hackrf_data"))
    (:file "_package_hackrf_data" :depends-on ("_package"))
    (:file "rtlsdr_data" :depends-on ("_package_rtlsdr_data"))
    (:file "_package_rtlsdr_data" :depends-on ("_package"))
    (:file "rtlsdr_config" :depends-on ("_package_rtlsdr_config"))
    (:file "_package_rtlsdr_config" :depends-on ("_package"))
  ))