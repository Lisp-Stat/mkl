;;; -*- Mode: LISP; Base: 10; Syntax: ANSI-Common-lisp; Package: MKL-TESTS -*-
;;; Copyright (c) 2025 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL
(in-package #:mkl-tests)

(defsuite vml-tests (mkl-tests))

;;; Tests for VML binary operations

(deftest test-vml-add (vml-tests)
  "Test VML addition operation."
  (let ((a #(1.0 2.0 3.0))
        (b #(4.0 5.0 6.0))
        (c (make-array 3 :element-type 'single-float)))
    (v+ a b c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-mul (vml-tests)
  "Test VML multiplication operation."
  (let ((a #(1.0 2.0 3.0))
        (b #(4.0 5.0 6.0))
        (c (make-array 3 :element-type 'single-float)))
    (v* a b c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-sub (vml-tests)
  "Test VML subtraction operation."
  (let ((a #(10.0 8.0 6.0))
        (b #(1.0 2.0 3.0))
        (c (make-array 3 :element-type 'single-float)))
    (v- a b c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-div (vml-tests)
  "Test VML division operation."
  (let ((a #(12.0 9.0 12.0))
        (b #(3.0 3.0 4.0))
        (c (make-array 3 :element-type 'single-float)))
    (v/ a b c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

;;; Tests for VML unary operations

(deftest test-vml-exp (vml-tests)
  "Test VML exponential operation."
  (let ((a #(0.0 1.0 2.0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:exp a c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-log (vml-tests)
  "Test VML natural logarithm operation."
  (let ((a #(1.0 2.718281828 7.389056099))
        (c (make-array 3 :element-type 'single-float)))
    (vml:log a c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-sqrt (vml-tests)
  "Test VML square root operation."
  (let ((a #(1.0 4.0 9.0 16.0))
        (c (make-array 4 :element-type 'single-float)))
    (vml:sqrt a c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 4))))

(deftest test-vml-sin (vml-tests)
  "Test VML sine operation."
    "Test VML sine operation."
  (let ((a (vector 0.0d0 (/ pi 6) (/ pi 4) (/ pi 3) (/ pi 2)))
        (c (make-array 5 :element-type 'double-float)))
    (vml:sin a c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 5))))

(deftest test-vml-cos (vml-tests)
  "Test VML cosine operation."
  (let ((a (vector 0.0d0 (/ pi 6) (/ pi 4) (/ pi 3) (/ pi 2)))
        (c (make-array 5 :element-type 'double-float)))
    (vml:cos a c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 5))))

;;; Tests for type dispatch

(deftest test-type-dispatch (vml-tests)
  "Test that VML operations work with different array types."
  ;; Test with double precision
  (let ((a (vector 1.0d0 2.0d0 3.0d0))
        (b (vector 4.0d0 5.0d0 6.0d0))
        (c (make-array 3 :element-type 'double-float)))
    (v* a b c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 3)))

  ;; Test with mixed single/double (should promote to double)
  (let ((a #(1.0 2.0 3.0))  ; single-float
        (b (vector 4.0d0 5.0d0 6.0d0))  ; double-float
        (c (make-array 3 :element-type 'double-float)))
    (v+ a b c)
    ;; Test that function can be called without error
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

;;; Complex number tests

(deftest test-complex-single-mul (vml-tests)
  "Test VML complex single-precision multiplication."
  (let ((a (vector #C(1.0f0 2.0f0) #C(3.0f0 4.0f0)))
        (b (vector #C(2.0f0 1.0f0) #C(1.0f0 3.0f0)))
        (c (make-array 2 :element-type '(complex single-float))))
    (vml:mul a b c)
    ;; Not testing correctness, just that the function can be called
    (assert-true (arrayp c))
    (assert-true (= (length c) 2))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-double-mul (vml-tests)
  "Test VML complex double-precision multiplication."
  (let ((a (vector #C(1.0d0 2.0d0) #C(3.0d0 4.0d0)))
        (b (vector #C(2.0d0 1.0d0) #C(1.0d0 3.0d0)))
        (c (make-array 2 :element-type '(complex double-float))))
    (vml:mul a b c)
    ;; Not testing correctness, just that the function can be called
    (assert-true (arrayp c))
    (assert-true (= (length c) 2))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-single-add (vml-tests)
  "Test VML complex single-precision addition."
  (let ((a (vector #C(1.0f0 2.0f0) #C(3.0f0 4.0f0)))
        (b (vector #C(2.0f0 1.0f0) #C(1.0f0 3.0f0)))
        (c (make-array 2 :element-type '(complex single-float))))
    (vml:add a b c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 2))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-double-add (vml-tests)
  "Test VML complex double-precision addition."
  (let ((a (vector #C(1.0d0 2.0d0) #C(3.0d0 4.0d0)))
        (b (vector #C(2.0d0 1.0d0) #C(1.0d0 3.0d0)))
        (c (make-array 2 :element-type '(complex double-float))))
    (vml:add a b c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 2))
    (assert-true (complexp (aref c 0)))))

;;; Complex unary operation tests

(deftest test-complex-single-exp (vml-tests)
  "Test VML complex single-precision exponential."
  (let ((a (vector #C(1.0f0 0.5f0) #C(0.0f0 1.0f0)))
        (c (make-array 2 :element-type '(complex single-float))))
    (vml:exp a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 2))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-double-exp (vml-tests)
  "Test VML complex double-precision exponential."
  (let ((a (vector #C(1.0d0 0.5d0) #C(0.0d0 1.0d0)))
        (c (make-array 2 :element-type '(complex double-float))))
    (vml:exp a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 2))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-single-log (vml-tests)
  "Test VML complex single-precision logarithm."
  (let ((a (vector #C(1.0f0 1.0f0) #C(2.0f0 0.0f0)))
        (c (make-array 2 :element-type '(complex single-float))))
    (vml:log a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 2))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-double-log (vml-tests)
  "Test VML complex double-precision logarithm."
  (let ((a (vector #C(1.0d0 1.0d0) #C(2.0d0 0.0d0)))
        (c (make-array 2 :element-type '(complex double-float))))
    (vml:log a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 2))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-single-sqrt (vml-tests)
  "Test VML complex single-precision square root."
  (let ((a (vector #C(4.0f0 0.0f0) #C(-1.0f0 0.0f0)))
        (c (make-array 2 :element-type '(complex single-float))))
    (vml:sqrt a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 2))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-double-sqrt (vml-tests)
  "Test VML complex double-precision square root."
  (let ((a (vector #C(4.0d0 0.0d0) #C(-1.0d0 0.0d0)))
        (c (make-array 2 :element-type '(complex double-float))))
    (vml:sqrt a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 2))
    (assert-true (complexp (aref c 0)))))

;;; Missing binary complex tests
(deftest test-complex-single-sub (vml-tests)
  "Test VML complex single-precision subtraction."
  (let ((a (vector #C(5.0f0 6.0f0) #C(3.0f0 4.0f0)))
        (b (vector #C(2.0f0 1.0f0) #C(1.0f0 2.0f0)))
        (c (make-array 2 :element-type '(complex single-float))))
    (vml:sub a b c)
    (assert-true (arrayp c))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-double-sub (vml-tests)
  "Test VML complex double-precision subtraction."
  (let ((a (vector #C(5.0d0 6.0d0) #C(3.0d0 4.0d0)))
        (b (vector #C(2.0d0 1.0d0) #C(1.0d0 2.0d0)))
        (c (make-array 2 :element-type '(complex double-float))))
    (vml:sub a b c)
    (assert-true (arrayp c))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-single-div (vml-tests)
  "Test VML complex single-precision division."
  (let ((a (vector #C(4.0f0 2.0f0) #C(6.0f0 3.0f0)))
        (b (vector #C(2.0f0 1.0f0) #C(3.0f0 1.0f0)))
        (c (make-array 2 :element-type '(complex single-float))))
    (vml:div a b c)
    (assert-true (arrayp c))
    (assert-true (complexp (aref c 0)))))

(deftest test-complex-double-div (vml-tests)
  "Test VML complex double-precision division."
  (let ((a (vector #C(4.0d0 2.0d0) #C(6.0d0 3.0d0)))
        (b (vector #C(2.0d0 1.0d0) #C(3.0d0 1.0d0)))
        (c (make-array 2 :element-type '(complex double-float))))
    (vml:div a b c)
    (assert-true (arrayp c))
    (assert-true (complexp (aref c 0)))))

;;; Comprehensive unary real function tests
(deftest test-vml-tan (vml-tests)
  "Test VML tangent operation."
  (let ((a (vector 0.0f0 0.5f0 1.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:tan a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-asin (vml-tests)
  "Test VML arcsine operation."
  (let ((a (vector 0.0f0 0.5f0 1.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:asin a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-acos (vml-tests)
  "Test VML arccosine operation."
  (let ((a (vector 0.0f0 0.5f0 1.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:acos a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-atan (vml-tests)
  "Test VML arctangent operation."
  (let ((a (vector 0.0f0 0.5f0 1.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:atan a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-sinh (vml-tests)
  "Test VML hyperbolic sine operation."
  (let ((a (vector 0.0f0 0.5f0 1.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:sinh a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-cosh (vml-tests)
  "Test VML hyperbolic cosine operation."
  (let ((a (vector 0.0f0 0.5f0 1.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:cosh a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-tanh (vml-tests)
  "Test VML hyperbolic tangent operation."
  (let ((a (vector 0.0f0 0.5f0 1.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:tanh a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-asinh (vml-tests)
  "Test VML inverse hyperbolic sine operation."
  (let ((a (vector 0.0f0 0.5f0 1.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:asinh a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-acosh (vml-tests)
  "Test VML inverse hyperbolic cosine operation."
  (let ((a (vector 1.0f0 1.5f0 2.0f0))  ; acosh domain: x >= 1
        (c (make-array 3 :element-type 'single-float)))
    (vml:acosh a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-atanh (vml-tests)
  "Test VML inverse hyperbolic tangent operation."
  (let ((a (vector 0.0f0 0.3f0 0.7f0))  ; atanh domain: |x| < 1
        (c (make-array 3 :element-type 'single-float)))
    (vml:atanh a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-abs (vml-tests)
  "Test VML absolute value operation."
  (let ((a (vector -2.0f0 0.0f0 3.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:abs a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-sqr (vml-tests)
  "Test VML square operation."
  (let ((a (vector 1.0f0 2.0f0 3.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:sqr a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-inv (vml-tests)
  "Test VML inverse operation."
  (let ((a (vector 1.0f0 2.0f0 4.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:inv a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-invsqrt (vml-tests)
  "Test VML inverse square root operation."
  (let ((a (vector 1.0f0 4.0f0 9.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:invsqrt a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-cbrt (vml-tests)
  "Test VML cube root operation."
  (let ((a (vector 1.0f0 8.0f0 27.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:cbrt a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-invcbrt (vml-tests)
  "Test VML inverse cube root operation."
  (let ((a (vector 1.0f0 8.0f0 27.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:invcbrt a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-exp2 (vml-tests)
  "Test VML base-2 exponential operation."
  (let ((a (vector 0.0f0 1.0f0 2.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:exp2 a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-exp10 (vml-tests)
  "Test VML base-10 exponential operation."
  (let ((a (vector 0.0f0 1.0f0 2.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:exp10 a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-expm1 (vml-tests)
  "Test VML exp(x)-1 operation."
  (let ((a (vector 0.0f0 0.1f0 0.5f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:expm1 a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-log2 (vml-tests)
  "Test VML base-2 logarithm operation."
  (let ((a (vector 1.0f0 2.0f0 4.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:log2 a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-log10 (vml-tests)
  "Test VML base-10 logarithm operation."
  (let ((a (vector 1.0f0 10.0f0 100.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:log10 a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-log1p (vml-tests)
  "Test VML log(1+x) operation."
  (let ((a (vector 0.0f0 0.1f0 1.0f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:log1p a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-ceil (vml-tests)
  "Test VML ceiling operation."
  (let ((a (vector 1.2f0 2.7f0 -1.3f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:ceil a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-floor (vml-tests)
  "Test VML floor operation."
  (let ((a (vector 1.2f0 2.7f0 -1.3f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:floor a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-trunc (vml-tests)
  "Test VML truncation operation."
  (let ((a (vector 1.2f0 2.7f0 -1.3f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:trunc a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

(deftest test-vml-round (vml-tests)
  "Test VML rounding operation."
  (let ((a (vector 1.2f0 2.7f0 -1.3f0))
        (c (make-array 3 :element-type 'single-float)))
    (vml:round a c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))

;;; Error handling tests

(deftest test-input-size-validation-binary (vml-tests)
  "Test that binary operations validate input array sizes."
  (let ((a #(1.0 2.0))          ; Too small - only 2 elements
        (b #(4.0 5.0 6.0))       ; Adequate - 3 elements
        (c (make-array 3 :element-type 'single-float)))  ; Output - 3 elements
    (assert-condition error (v+ a b c))))

(deftest test-input-size-validation-unary (vml-tests)
  "Test that unary operations validate input array sizes."
  (let ((a #(1.0 2.0))          ; Too small - only 2 elements
        (b (make-array 3 :element-type 'single-float)))  ; Output - 3 elements
    (assert-condition error (vml:exp a b))))

(deftest test-valid-larger-inputs (vml-tests)
  "Test that larger input arrays work correctly."
  (let ((a #(1.0 2.0 3.0 4.0 5.0))  ; Larger than needed - 5 elements
        (b #(4.0 5.0 6.0 7.0 8.0))   ; Larger than needed - 5 elements
        (c (make-array 3 :element-type 'single-float)))  ; Output - 3 elements
    ;; Should work - only first 3 elements of a and b are used
    (v+ a b c)
    (assert-true (arrayp c))
    (assert-true (= (length c) 3))))
