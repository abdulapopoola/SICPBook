#lang planet neil/sicp

(define (numer x) (car x))

(define (denom x) (cdr x))

;; XNOR is true when x and y have the same sign
(define (xnor x y) 
  (or (and x y)
      (and (not x) (not y))))

(define (make-rat n d) 
  (let ((abs-n (abs n))
        (abs-d (abs d)))
    (if (xnor 
       (positive? n)
       (positive? d))
      (cons abs-n abs-d)
      (cons (- abs-n) abs-d))))

(make-rat 2 3)
(make-rat 2 -3)
(make-rat -2 3)
(make-rat -2 -3)
