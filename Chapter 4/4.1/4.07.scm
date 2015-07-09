#lang racket

(define (let*? exp) (tagged-list? exp '*let))
(define (let*-expressions exp) (cadr exp))
(define (let*-variables exp) (map car (let*-expressions exp)))
(define (let*-params exp) (map cadr (let*-expressions exp)))
(define (let*-body exp) (caddr exp))

(define (let*->combination exp)
  (if (null? (cdr (let*-expressions exp)))
      (cons 'let (cons (let*-expressions exp) (let*-body exp)))
      (list 'let (list (car (let*-expressions exp)))
            (let*->combination (cdr (let*-expressions exp))))))
                       