;;;; -*- Mode: LISP -*-

(in-package :cl-user)

(defpackage :quickhoney.system
  (:use :cl :asdf))

(in-package :quickhoney.system)

(defsystem :quickhoney
  :name "QUICKHONEY website"
  :author "Hans Huebner <hans@huebner.org>"
  :version "0"
  :maintainer "Hans Huebner <hans@huebner.org>"
  :maintainer "Manuel Odendahl <wesen@ruinwesen.com>"
  :licence "BSD"
  :description "QUICKHONEY website"
  :long-description ""
  
  :depends-on (:cl-interpol
               :cl-ppcre
               :cxml
               :cl-mime
               :drakma
               :bknr.web
               :bknr.datastore
               :bknr.modules
               :cl-gd
               :unit-test
               :yason
               :cl-paypal
               :cl-pdf)

  :components ((:file "packages")
               (:file "config" :depends-on ("packages"))
	       (:file "paypal-config" :depends-on ("packages"))
               (:file "image" :depends-on ("config"))

               (:file "quickhoney-shop" :depends-on ("image"))
               (:file "news" :depends-on ("image"))
               (:file "layout" :depends-on ("config"))
               (:file "imageproc" :depends-on ("config"))
               (:file "twitter" :depends-on ("packages"))
               (:file "handlers" :depends-on ("layout" "config" "image" "news" "quickhoney-shop"))
               (:file "tags" :depends-on ("image"))
               (:file "paypal-handlers" :depends-on ("config" "handlers" "paypal-config"))
               (:file "webserver" :depends-on ("handlers" "paypal-handlers"))

               (:file "daily" :depends-on ("config"))


               (:file "turtle" :depends-on ("packages"))
               (:file "pixel-pdf" :depends-on ("turtle"))
               
               (:file "init" :depends-on ("webserver" "daily"))))
