;;; -*- Mode: LISP; Syntax: Ansi-Common-Lisp; Base: 10; Package: VML -*-
;;; Copyright (c) 2025 by Symbolics Pte. Ltd. All rights reserved.
;;; SPDX-License-identifier: MS-PL
(in-package #:vml)

;;; Intel MKL Vector Mathematical Library (VML) interface
;;; VML provides vectorized mathematical functions optimized for Intel processors

;;; Binary arithmetic operations
(define-c-binary-op add "Add")
(define-c-binary-op sub "Sub")
(define-c-binary-op mul "Mul")
(define-c-binary-op div "Div")

;;; Unary mathematical functions
(define-c-unary-op exp "Exp")
(define-c-unary-op log "Ln")
(define-c-unary-op sqrt "Sqrt")
(define-c-unary-op sin "Sin")
(define-c-unary-op cos "Cos")
(define-c-unary-op tan "Tan")
(define-c-unary-op asin "Asin")
(define-c-unary-op acos "Acos")
(define-c-unary-op atan "Atan")
(define-c-unary-op sinh "Sinh")
(define-c-unary-op cosh "Cosh")
(define-c-unary-op tanh "Tanh")
(define-c-unary-op asinh "Asinh")
(define-c-unary-op acosh "Acosh")
(define-c-unary-op atanh "Atanh")
(define-c-unary-op abs "Abs")
(define-c-unary-op sqr "Sqr")
(define-c-unary-op inv "Inv")
(define-c-unary-op invsqrt "InvSqrt")
(define-c-unary-op cbrt "Cbrt")
(define-c-unary-op invcbrt "InvCbrt")
(define-c-unary-op exp2 "Exp2")
(define-c-unary-op exp10 "Exp10")
(define-c-unary-op expm1 "Expm1")
(define-c-unary-op log2 "Log2")
(define-c-unary-op log10 "Log10")
(define-c-unary-op log1p "Log1p")
(define-c-unary-op ceil "Ceil")
(define-c-unary-op floor "Floor")
(define-c-unary-op trunc "Trunc")
(define-c-unary-op round "Round")

;;; Convenience aliases for common operations
(defun v+ (a b c)
  "Elementwise addition using MKL VML. C ← A + B

A and B are input arrays that must be at least as large as C.
C is the output array (modified in place) that determines the number of elements processed.

Returns C."
  (add a b c))

(defun v- (a b c)
  "Elementwise subtraction using MKL VML. C ← A - B

A and B are input arrays that must be at least as large as C.
C is the output array (modified in place) that determines the number of elements processed.

Returns C."
  (sub a b c))

(defun v* (a b c)
  "Elementwise multiplication using MKL VML. C ← A * B

A and B are input arrays that must be at least as large as C.
C is the output array (modified in place) that determines the number of elements processed.

Returns C."
  (mul a b c))

(defun v/ (a b c)
  "Elementwise division using MKL VML. C ← A / B

A and B are input arrays that must be at least as large as C.
C is the output array (modified in place) that determines the number of elements processed.

Returns C."
  (div a b c))
