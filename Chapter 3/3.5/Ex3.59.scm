#lang racket

(define (integrate-series S)
  (define (iter divisor)
    (cons-stream 
     (/ (stream-first S) divisor)
     (update-coeff (+ divisor 1))))
  (iter 1))

;; cleaner way
(define (integrate-series2 S)
  (map-stream / S integers))

(define exp-series
  (cons-stream 
   1 (integrate-series exp-series)))

(define cosine-series 
  (cons-stream 1 (scale-stream (integrate-series sine-series) -1)))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))