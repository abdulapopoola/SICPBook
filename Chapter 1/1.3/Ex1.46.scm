#lang planet neil/sicp

(define (square x) (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) 
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (iterative-improve good-enough? improve result)
  (define (try x)
    (if (good-enough? x result)
        x
        (try (improve x result))))
  (lambda (guess) (try guess)))
        
(define (sqrt x)
  ((iterative-improve good-enough? improve x) 1.0))

(sqrt 256)