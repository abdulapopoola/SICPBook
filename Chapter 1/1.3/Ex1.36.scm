#lang planet neil/sicp

(define (average x y) (/ (+ x y) 2))
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? next guess)
          next
          (try next))))
  (try first-guess))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 3.0)
;;4.555532257016376 without damping - 33 steps

(fixed-point (lambda (x) (average x (/ (log 1000) (log x)))) 3.0)
;;4.55553609061889 with damping - 8 steps