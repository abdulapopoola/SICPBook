#lang planet neil/sicp

(define (make-interval a b) (cons a b))

(define (lower-bound interval) (car interval))

(define (upper-bound interval) (cdr interval))


(define sample-interval (make-interval 1 3))

(lower-bound sample-interval)
;1

(upper-bound sample-interval)
;3