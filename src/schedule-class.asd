;;;; schedule-class.asd

(asdf:defsystem #:schedule-class
  :description "Describe schedule-class here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:postmodern #:cl-postgres+local-time)
  :components ((:file "package")
               (:file "schedule-class")))