#lang planet neil/sicp

(define (numer x) (car x))

(define (denom x) (cdr x))

(define (make-rat n d) 
  (let ((abs-n (abs n))
        (abs-d (abs d)))
    (if (or (and (> n 0) (> d 0))
            (and (< n 0) (< d 0)))
        (cons abs-n abs-d)
        (cons (- abs-n) abs-d))))

(make-rat 2 3)
(make-rat 2 -3)
(make-rat -2 3)
(make-rat -2 -3)
