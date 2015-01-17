#lang planet neil/sicp

(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) 
           (if (same-variable? exp var) 
               1 
               0))
         (else ((get 'deriv (operator exp)) 
                (operands exp) 
                var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;; 1. 
;;    a. The deriv function now 'looks up' the right derivator 
;;       to use in the table. This is based on the operator value.
;;       Once retrieved, the deriv method is called on the operands
;;       and the var is also passed in.
;;    

;;    b.  
;;    The number? and variable? predicates are part of the problem domain
;;    and have nothing to do with the data representation format of the problem

;; 2.
(define deriv-sum
  (make-sum (deriv (addend exp) var)
            (deriv (augend exp) var)))

(define deriv-prod
  (make-sum
   (make-product (multiplier exp)
                 (deriv (multiplicand exp) var))
   (make-product (deriv (multiplier exp) var)
                 (multiplicand exp))))

(put 'deriv '+ deriv-sum)
(put 'deriv '* deriv-prod)

;; 3. 

(define deriv-expt
  (make-product (exponent exp)
                (make-product (make-exponentiation (base exp)
                                                   (make-sum (exponent exp) -1))
                              (deriv (base exp) var))))
(put 'deriv '** deriv-expt)

;; 4.
;; Only the put operation will have to change and it will look like the below
(put '+ 'deriv deriv-sum)
(put '* 'deriv deriv-prod)
     