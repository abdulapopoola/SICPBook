#lang planet neil/sicp

(define (inc x) (+ x 1))

(define (double fn)
  (lambda (x) (fn (fn x))))

((double inc) 2)
;; 4


(((double (double double)) inc) 5)
;; 21