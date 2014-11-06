#lang planet neil/sicp

(define tolerance 0.00001)
(define (square x) (* x x))
(define (average x y) 
  (/ (+ x y) 2))

(define (iterative-improve good-enough? improve)
  (define (iter-imp guess)
    (if (good-enough? guess)
        guess
        (iter-imp (improve guess))))
  iter-imp)
        
(define (sqrt x)
  ((iterative-improve 
    (lambda (guess) (< (abs (- (square guess) x)) tolerance))
    (lambda (guess) (average guess (/ x guess))))
    1.0))

(sqrt 9)

(define (fixed-point f initial-guess)
  ((iterative-improve
    (lambda (guess) (< (abs (- guess (f guess))) tolerance))
    (lambda (guess) (f guess)))
   initial-guess))

(fixed-point cos 1)
  