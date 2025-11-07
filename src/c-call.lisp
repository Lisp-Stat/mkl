;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: MKL -*-
;;; Copyright (c) 2025 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

(in-package #:mkl)

;;; Generic C calling infrastructure for mathematical libraries
;;; 
;;; This provides a framework for wrapping C-style mathematical libraries
;;; (like Intel MKL VML) that use C calling conventions:
;;; - Scalars passed by value
;;; - Arrays passed by pointer
;;; - Return values via function return (not output parameters)

;;; Type mapping utilities using LLA's internal system
(defun c-call-function-name (base-name internal-type)
  "Generate C function name based on base name and LLA internal type."
  (check-type internal-type lla::internal-type)
  (concatenate 'string 
               "v" 
               (lla::eswitch (internal-type)
                 (lla::+single+ "s")
                 (lla::+double+ "d") 
                 (lla::+complex-single+ "c")
                 (lla::+complex-double+ "z"))
               base-name))

(defun cffi-type-for-internal-type (internal-type)
  "Return CFFI type for LLA internal type."
  (check-type internal-type lla::internal-type)
  (lla::eswitch (internal-type)
    (lla::+single+ :float)
    (lla::+double+ :double)
    (lla::+complex-single+ '(:struct complex-single))
    (lla::+complex-double+ '(:struct complex-double))))

;;; Complex number support
(defcstruct complex-single
  (real :float)
  (imag :float))

(defcstruct complex-double  
  (real :double)
  (imag :double))

;;; Array utilities using LLA's pinned array system
(defmacro with-c-array-input ((pointer array internal-type) &body body)
  "Pin ARRAY for C function input using LLA's array pinning system."
  `(lla::with-array-input ((,pointer) ,array ,internal-type nil nil)
     ,@body))

(defmacro with-c-array-output ((pointer array internal-type) &body body)
  "Pin ARRAY for C function output using LLA's array pinning system."
  `(lla::with-array-output ((,pointer) ,array ,internal-type nil)
     ,@body))

;;; Binary operations: z = op(x, y)
(defun c-call-binary (function-base-name x y z)
  "Call C binary function: z = op(x, y).
   
   Arguments:
   - FUNCTION-BASE-NAME: Base name of C function (e.g., \"Add\" for vsAdd)
   - X, Y: Input arrays or scalars
   - Z: Output array
   
   The function automatically determines the appropriate C function variant
   based on the common type of the inputs."
  (let* ((size-x (array-total-size x))
         (size-y (array-total-size y))
         (size-z (array-total-size z))
         (internal-type (lla::common-float-type x y z))
         (function-name (c-call-function-name function-base-name internal-type))
         (n size-z))
    
    ;; Validate that input arrays are at least as large as output array
    (when (< size-x size-z)
      (error "Input array X is too small: has ~D elements but needs at least ~D for output array size" 
             size-x size-z))
    (when (< size-y size-z)
      (error "Input array Y is too small: has ~D elements but needs at least ~D for output array size" 
             size-y size-z))
    
    (let ((function-ptr (foreign-symbol-pointer function-name)))
      (unless function-ptr
        (error "MKL function ~A not found. Is the MKL library properly loaded?" function-name))
      
      (with-c-array-input (x-ptr x internal-type)
        (with-c-array-input (y-ptr y internal-type)
          (with-c-array-output (z-ptr z internal-type)
            (foreign-funcall-pointer
             function-ptr
             ()
             :int n
             :pointer x-ptr
             :pointer y-ptr  
             :pointer z-ptr
             :void)))))
    z))

;;; Unary operations: y = op(x)
(defun c-call-unary (function-base-name x y)
  "Call C unary function: y = op(x).
   
   Arguments:
   - FUNCTION-BASE-NAME: Base name of C function (e.g., \"Exp\" for vsExp)
   - X: Input array or scalar
   - Y: Output array
   
   The function automatically determines the appropriate C function variant
   based on the type of the input."
  (let* ((size-x (array-total-size x))
         (size-y (array-total-size y))
         (internal-type (lla::common-float-type x y))
         (function-name (c-call-function-name function-base-name internal-type))
         (n size-y))
    
    ;; Validate that input array is at least as large as output array
    (when (< size-x size-y)
      (error "Input array X is too small: has ~D elements but needs at least ~D for output array size" 
             size-x size-y))
    
    (let ((function-ptr (foreign-symbol-pointer function-name)))
      (unless function-ptr
        (error "MKL function ~A not found. Is the MKL library properly loaded?" function-name))
      
      (with-c-array-input (x-ptr x internal-type)
        (with-c-array-output (y-ptr y internal-type)
          (foreign-funcall-pointer
           function-ptr
           ()
           :int n
           :pointer x-ptr
           :pointer y-ptr
           :void))))
    y))

;;; Convenience macros for defining operations
(defmacro define-c-binary-op (lisp-name c-base-name &optional documentation)
  "Define a binary operation wrapper.
   
   Creates a function LISP-NAME that calls C function with base name C-BASE-NAME.
   The function signature is (LISP-NAME X Y &OPTIONAL Z).
   
   If Z is not provided, a new array of appropriate type is allocated."
  `(defun ,lisp-name (x y &optional z)
     ,@(when documentation (list documentation))
     (let* ((common-type (lla::common-float-type x y))
            (lisp-type (lla::lisp-type common-type)))
       (unless z
         (setf z (make-array (array-dimensions x) :element-type lisp-type)))
       (c-call-binary ,c-base-name x y z))))

(defmacro define-c-unary-op (lisp-name c-base-name &optional documentation)
  "Define a unary operation wrapper.
   
   Creates a function LISP-NAME that calls C function with base name C-BASE-NAME.
   The function signature is (LISP-NAME X &OPTIONAL Y).
   
   If Y is not provided, a new array of appropriate type is allocated."
  `(defun ,lisp-name (x &optional y)
     ,@(when documentation (list documentation))
     (let* ((common-type (lla::common-float-type x))
            (lisp-type (lla::lisp-type common-type)))
       (unless y
         (setf y (make-array (array-dimensions x) :element-type lisp-type)))
       (c-call-unary ,c-base-name x y))))