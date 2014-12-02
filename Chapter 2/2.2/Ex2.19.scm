#lang planet neil/sicp

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))
(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define (no-more? items)
  (null? items))

(define (first-denomination items)
  (car items))

(define (except-first-denomination items)
  (cdr items))

(cc 100 us-coins) ; 292
(cc 100 uk-coins) ; 104561

(define reversed-us-coins (list 1 5 10 25 50))
(define reversed-uk-coins (list 0.5 1 2 5 10 20 50 100))

(cc 100 reversed-us-coins) ; 292
(cc 100 reversed-uk-coins) ;104561

;;Order does not matter as all combinations are evaluated recursively

