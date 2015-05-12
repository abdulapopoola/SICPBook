#lang planet neil/sicp

(define (averager a b c)
  (let ((sum-value (make-connector))
        (halver (make-connector)))
    (adder a b sum-value)
    (multiplier sum-value halver c)
    (constant (/ 1 2) halver)
    'ok))