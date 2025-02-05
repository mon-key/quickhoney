
(in-package :quickhoney)

(enable-interpol-syntax)

(defclass admin-handler (admin-only-handler page-handler)
  ())

(defmethod handle ((handler admin-handler))
  (with-bknr-page (:title "CMS")
    "Please choose an administration activity from the menu above"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun publish-quickhoney ()
  (setf bknr.web::*upload-file-size-limit* (* 30 1024 1024))
  (unpublish)
  (make-instance 'website
		 :name "Quickhoney CMS"
		 :handler-definitions
     `(("/random-image" random-image-handler)
       ("/animation" animation-handler)
       ("/digg-image" digg-image-handler)

       ("/json-image-query" json-image-query-handler)
       ("/json-image-info" json-image-info-handler)
       ("/json-login" json-login-handler)
       ("/json-logout" json-logout-handler)
       ("/json-clients" json-clients-handler)
       ("/json-buttons" json-buttons-handler)
       ("/json-edit-image" json-edit-image-handler)
       ("/json-edit-news" json-edit-news-item-handler)
       ("/json-news-archive" json-news-archive-handler)
       ("/json-news" json-news-handler)
       ("/json-paypal-checkout" json-paypal-checkout-handler)
       ("/json-paypal-txn" json-paypal-transaction-info-handler)
       ("/json-paypal-admin" json-paypal-admin-handler)

       ("/upload-image" upload-image-handler)
       ("/upload-animation" upload-animation-handler)
       ("/upload-button" upload-button-handler)
       ("/upload-news" upload-news-handler)
       ("/upload-shop" upload-shop-handler)

       ("/paypal-success" paypal-success-handler)
       ("/paypal-cancel" paypal-cancel-handler)

       ("/pdf-admin" quickhoney-admin-pdf-handler)
       ("/pdf-client" quickhoney-client-pdf-handler)

       ("/rss" rss-handler)
       ("/admin" admin-handler)
       ("/shutdown" shutdown-handler)

       user
       images
       
       ("/static" directory-handler
                  :destination ,(merge-pathnames #p"static/" *website-directory*)
                  :filename-separator #\,)
       ("/favicon.ico" file-handler
                       :destination ,(merge-pathnames #p"static/favicon.ico" *website-directory*)
                       :content-type "application/x-icon")
       ("/" template-handler
            :default-template "index"
            :catch-all t
            :destination ,(namestring (merge-pathnames "templates/" *website-directory*))
            :command-packages (("http://quickhoney.com/" . :quickhoney.tags)
                               ("http://bknr.net/" . :bknr.web))))

		 :admin-navigation
     '(("user" . "/user/")
       ("images" . "/edit-images")
       ("import" . "/import-images")
       ("logout" . "/logout"))
     
     :authorizer (make-instance 'bknr-authorizer)
     :site-logo-url "/image/quickhoney/color,000000,33ff00"
     :login-logo-url "/image/quickhoney/color,000000,33ff00/double,3"
     :import-spool-directory (merge-pathnames "spool/" *root-directory*)
     :style-sheet-urls '("/static/yui/reset-fonts/reset-fonts.css" "/static/quickhoney.css" "/static/cms.css")
     :javascript-urls '("/MochiKit/MochiKit.js" "/static/javascript.js")))
