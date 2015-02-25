#lang planet neil/sicp

(define p1 (make-polynomial-from-coeffs
            'x
            (list (make-integer 1)
                  (make-integer -2)
                  (make-integer 1))))

(define p2 (make-polynomial-from-coeffs
            'x
            (list (make-integer 11)
                  zero
                  (make-integer 7))))

(define p3 (make-polynomial-from-coeffs
            'x
            (list (make-integer 13)
                  (make-integer 5))))

(define q1 (mul p1 p2))
(define q2 (mul p1 p3))

(greatest-common-divisor q1 q2)