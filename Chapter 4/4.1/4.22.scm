#lang racket

;; Simpler approach
((let? expr) (analyze (let->combination expr))) 



;; Trying to rewrite let-combination to use analyze... not needed
(define (let? exp) (tagged-list? exp 'let))
(define (let-expressions exp) (cadr exp))
(define (let-variables exp) (map car (let-expressions exp)))
(define (let-params exp) (map cadr (let-expressions exp)))
(define (let-body exp) (caddr exp))

(define (let->combination exp)
  (let ((vars (let-variables exp))
        (bproc (analyze-sequence (let-body exp)))
        (params (map (λ (param) (analyze-variable param)))))
    ((λ (env)
       (make-procedure vars bproc env))
     params)))