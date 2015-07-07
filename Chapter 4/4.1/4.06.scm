#lang racket

(define (let? exp) (tagged-list? exp 'let))
(define (let-expressions exp) (cadr exp))
(define (let-variables exp) (map car (let-expressions exp)))
(define (let-params exp) (map cadr (let-expressions exp)))
(define (let-body exp) (caddr exp))

(define (let->combination exp)
  (make-procedure 
          (let-variables exp)
          (let-body exp)
         (let-params exp)))