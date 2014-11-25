#lang planet neil/sicp

;;helpers
(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) 
                    (lower-bound y))
                 (- (upper-bound x) 
                    (upper-bound y))))