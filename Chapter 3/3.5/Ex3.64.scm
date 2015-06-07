#lang racket

(define (stream-limit s tolerance)
  (let ((s0 (stream-ref s 0))
        (s1 (stream-ref s 1)))
    (if (< (abs (- s0 s1)) tolerance)
        s1
        (stream-limit (stream-rest s) tolerance))))