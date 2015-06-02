#lang racket

(define (integrate-series S)
  (define (update-coeff divisor)
    (cons-stream 
     (/ (stream-first S) divisor)
     (stream-rest S)))
  (stream-cons 