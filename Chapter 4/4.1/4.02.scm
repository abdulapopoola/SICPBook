#lang racket

;; Louis solution will not work as explained below:


(define (eval exp env)
  (cond ((self-evaluating? exp) 
         exp)
        ((variable? exp) 
         (lookup-variable-value exp env))
        ((quoted? exp) 
         (text-of-quotation exp))        
        ((application? exp) ;; after move
         (apply (eval (operator exp) env)
                (list-of-values 
                 (operands exp) 
                 env)))
        ((assignment? exp) 
         (eval-assignment exp env))
        ((definition? exp) 
         (eval-definition exp env))
        ((if? exp) 
         (eval-if exp env))
        ((lambda? exp)
         (make-procedure 
          (lambda-parameters exp)
          (lambda-body exp)
          env))
        ((begin? exp)
         (eval-sequence 
          (begin-actions exp) 
          env))
        ((cond? exp) 
         (eval (cond->if exp) env))
        (else
         (error "Unknown expression 
                 type: EVAL" exp))))

;; The application cond will catch the (define x 3) call and then 
;; it'll attempt to execute the (eval (operator exp) env) segment of the apply
;; (operator exp) gives define and the expression is thus simplified as
;; (eval define env).
;; However eval has no define function so this throws an error


;; 2ND HALF; redefined interfaces
(define (application? exp) 
  (tagged-list exp 'call))
(define (operator exp) (cadr exp))
(define (operands exp) (caddr exp))