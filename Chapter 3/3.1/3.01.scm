#lang planet neil/sicp

(define (make-accumulator value)
  (lambda (new-value)
    (begin (set! value (+ value new-value))
           value)))

(define A (make-accumulator 5))

(A 10)

(A 10)

(A -20)

(define x (A 0))
