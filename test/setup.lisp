;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-lisp; Package: CL-USER -*-
;;; Copyright (c) 2025 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL

(uiop:define-package #:mkl-tests
  (:use #:cl
        #:alexandria
        #:clunit
        #:lla
        #:mkl
        #:vml)
  (:shadow
   ;; Shadow CL mathematical functions that conflict with VML exports
   #:log #:sin #:cos #:tan #:exp #:sqrt
   #:asin #:acos #:atan #:sinh #:cosh #:tanh
   #:asinh #:acosh #:atanh #:abs #:ceil #:floor
   #:round #:truncate)
  (:export #:mkl-tests #:run)
  (:documentation "Comprehensive test suite for Intel MKL Vector Math Library (VML) bindings.

This package contains unit tests that verify the Common Lisp interface to Intel OneAPI
MKL's Vector Math Library. Tests focus on interface correctness and callability rather
than mathematical accuracy, trusting Intel's implementation for numerical correctness.

Test coverage includes:
- All VML binary operations (add, sub, mul, div) across real and complex types
- Complete unary function set (transcendental, hyperbolic, inverse, rounding operations)
- Automatic type dispatch validation for single/double precision arrays
- Input array size validation and error handling
- Complex number support verification
- Convenience alias functionality (v+, v*, etc.)

The test framework uses shadowed mathematical symbols (sin, cos, exp, etc.) that resolve
to VML array operations, while scalar CL functions remain accessible via cl: qualification.
All tests validate that operations complete successfully and return appropriately-typed
results without asserting specific mathematical outcomes."))

(in-package :mkl-tests)

(defsuite mkl-tests ())

(defun run (&optional interactive?)
  "Run all the tests for MKL."
  (run-suite 'mkl-tests :use-debugger interactive?))

;; Support functions

(defun array= (array1 array2 &optional (tolerance 1e-6))
  "Test that arrays are equal within tolerance."
  (and (equal (array-dimensions array1)
              (array-dimensions array2))
       (let ((size (array-total-size array1)))
         (loop for i from 0 below size
               always (let ((val1 (row-major-aref array1 i))
                           (val2 (row-major-aref array2 i)))
                       (cond
                         ((and (complexp val1) (complexp val2))
                          (and (< (cl:abs (- (realpart val1) (realpart val2))) tolerance)
                               (< (cl:abs (- (imagpart val1) (imagpart val2))) tolerance)))
                         ((and (realp val1) (realp val2))
                          (< (cl:abs (- val1 val2)) tolerance))
                         (t nil)))))))

(defun make-test-array (type dimensions)
  "Create a test array of the given type and dimensions."
  (alexandria:eswitch (type)
    (lla::+single+ (make-array dimensions :element-type 'lla-single))
    (lla::+double+ (make-array dimensions :element-type 'lla-double))
    (lla::+complex-single+ (make-array dimensions :element-type 'lla-complex-single))
    (lla::+complex-double+ (make-array dimensions :element-type 'lla-complex-double))))
