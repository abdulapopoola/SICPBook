;;Influenced by solution at https://github.com/ivanjovanovic/sicp/blob/master/4.1/e-4.3.scm

#lang racket

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((not (null? (get (car exp))))
         ((get (car exp)) exp env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values 
                 (operands exp) 
                 env)))
        (else
         (error "Unknown expression 
                 type: EVAL" exp))))

(put 'quoted
     (lambda (exp env) (text-of-quotation exp)))

(put 'set!  eval-assignment)
(put 'define eval-definition)
(put 'if eval-if)
(put 'lambda (lambda (exp env)
               (make-procedure (lambda-parameters exp)
                               (lambda-body exp)
                               env)))
(put 'begin (lambda (exp env) (eval-sequence (begin-actions exp) env)))
(put 'cond (lambda (exp env) (eval (cond->if exp) env)))

