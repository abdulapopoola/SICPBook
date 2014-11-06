#lang planet neil/sicp

(define (average x y) (/ (+ x y) 2))

(define (average-damp f)
  (lambda (x) 
    (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1)
      f
      (compose f (repeated f (- n 1)))))

(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) 
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))
   
;;function calling functions be here; looks simple but deep
(define (nth-root x root)
  (fixed-point 
   ((repeated average-damp (- root 1))
    (lambda (y) (/ x (expt y (- root 1)))))
    1.0))

(nth-root 9 2)
(nth-root 27 3)
(nth-root 81 4)
(nth-root 243 5)
(nth-root 729 6)