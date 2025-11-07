;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-Lisp; Package: CL-USER -*-
;;; Copyright (c) 2025 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

(uiop:define-package "MKL"
  (:use #:cl #:cffi #:lla #:alexandria #:let-plus)
  (:documentation "Common Lisp interface to Intel Math Kernel Library with C calling conventions.")
  (:export
   ;; C calling infrastructure
   #:c-call-function-name
   #:c-call-binary
   #:c-call-unary
   #:define-c-binary-op
   #:define-c-unary-op))

(uiop:define-package "VML"
  (:use #:cl #:mkl #:lla)
  (:documentation "Intel MKL Vector Math Library (VML) interface with automatic type dispatch.")
  (:shadow
   ;; Shadow CL mathematical functions that conflict with VML exports
   #:exp #:log #:sqrt #:sin #:cos #:tan
   #:asin #:acos #:atan #:sinh #:cosh #:tanh
   #:asinh #:acosh #:atanh #:abs
   #:ceil #:floor #:round)
  (:export
   ;; Binary operations
   #:add
   #:sub
   #:mul
   #:div

   ;; Unary operations
   #:exp
   #:log
   #:sqrt
   #:sin
   #:cos
   #:tan
   #:asin
   #:acos
   #:atan
   #:sinh
   #:cosh
   #:tanh
   #:asinh
   #:acosh
   #:atanh
   #:abs
   #:sqr
   #:inv
   #:invsqrt
   #:cbrt
   #:invcbrt
   #:exp2
   #:exp10
   #:expm1
   #:log2
   #:log10
   #:log1p
   #:ceil
   #:floor
   #:trunc
   #:round

   ;; Convenience aliases for common operations
   #:v+
   #:v-
   #:v*
   #:v/))
