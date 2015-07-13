#lang racket

(define (while? exp)
  (tagged-list? exp 'while))

(define (while-cond exp)
  (cadr exp))

(define (while-body exp)
  (caddr exp))

(define (eval-while exp)  
  (sequence->exp
   (list (list 'define
               (list 'while) 
               (make-if (while-cond exp)
                        (sequence->exp (list (while-body)
                                             (list 'while)))
                        'done))
         (list 'while))))