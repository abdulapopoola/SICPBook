#lang planet neil/sicp

(define (cons x y)
  (* (expt 2 x)
     (expt 3 y)))

(define (divide-by-n n divisor)
  (define (iter n count)
    (if (zero? (remainder n divisor))
        (iter (/ n divisor) (+ count 1))
        count))
  (iter n 0))

(define (car x)
  (divide-by-n x 2))
  
(define (cdr x)
  (divide-by-n x 3))

(car (cons 1 17))
(cdr (cons 1 1))