#lang racket
(require racket/include)
(include "../4.1.helpers.rkt")

(define (letrec? exp) (tagged-list exp? 'letrec))
(define (letrec-expressions exp) (car exp))
(define (letrec-body exp) (cdr exp))

(define (letrec->let exp) (process-letrec (cdr exp)))

(define (process-letrec letrec-expressions-and-body)
  (list 'let
        (map (λ (var-and-exp)
               (list (car var-and-exp) ''*unassigned))
             (letrec-expressions letrec-expressions-and-body))
        (map (λ (var-and-exp)
               (list 'set! (car var-and-exp) (cadr var-and-exp)))
             (letrec-expressions letrec-expressions-and-body))
        (letrec-body letrec-expressions-and-body)))


;; Louis Reasoner is wrong because let replaces the execution with
;; a lambda

;; (let ((var expr))
;;    <body>)

;; This gets converted into
;; ((lambda (var)
;;      <body>)
;;   expr)

;; But for mutual recursion, this would break since the definitions
;; of the mutually-recursive halfs would still not be defined yet
;; Notice that let-rec avoids this by 'setting' the variables inside
;; the expression itself

;; Further example
;; Copied from https://wqzhang.wordpress.com/2009/11/25/sicp-exercise-4-20/
;;  (let ((even?
;;       (lambda (n)
;;         <body of even? including call to odd?>)
;;      (odd?
;;       (lambda (n)
;;         <body of odd? including call to even?>)))
;;      <rest of body of f>))

;; ((lambda (even? odd?)
;;      <rest of body of f>)
;;    (lambda (n) <body of even? including call to odd?>)
;;    (lambda (n) <body of odd? including call to even?>))
;; fails since even and odd references are not valid