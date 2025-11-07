;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-lisp; Package: CL-USER -*-
;;; Copyright (c) 2025 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

(defsystem "mkl"
  :description "Common Lisp interface to Intel Math Kernel Library"
  :long-description  #.(uiop:read-file-string
			(uiop:subpathname *load-pathname* "description.text"))
  :version "0.1.0"
  :author "Steve Nunez <steve@symbolics.tech>"
  :license :MS-PL
  :depends-on (#:cffi
               #:lla
               #:alexandria)
  :in-order-to ((test-op (test-op "mkl/tests")))
  :pathname #P"src/"
  :serial t
  :components ((:file "pkgdcl")
	       (:file "c-call")))

(defsystem "mkl/vml"
  :description "Intel MKL Vector Math Library (VML) interface"
  :author "Steve Nunez <steve@symbolics.tech>"
  :license :MS-PL
  :depends-on (#:mkl)
  :pathname #P"src/"
  :serial t
  :components ((:file "vml")))

(defsystem "mkl/tests"
  :description "Unit tests for MKL."
  :author "Steve Nunez <steve@symbolics.tech>"
  :license :MS-PL
  :depends-on (#:mkl
               #:mkl/vml
               #:clunit2
               #:lla)
  :pathname #P"test/"
  :serial t
  :components ((:file "setup")
	       (:file "vml"))
  :perform (test-op (o s)
	     (symbol-call :clunit :run-suite
			  (find-symbol* :mkl-tests :mkl-tests))))

;; Push :VML feature when VML subsystem loads
(defmethod perform :after
  ((operation load-op) (system (eql (find-system :mkl/vml))))
  "Update *FEATURES* when MKL VML subsystem loads successfully."
  (pushnew :vml common-lisp:*features*))
