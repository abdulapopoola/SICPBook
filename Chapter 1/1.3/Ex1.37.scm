#lang planet neil/sicp

;;Recursive style
(define (cont-frac n d k)
  (define (iter n d i)
    (if (= k i)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (iter n d (+ i 1))))))
  (iter n d 1))

;;Iterative style
(define (cont-frac2 n d k)  
  (define (iter i result)
    (if (= i 1)
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           12)

(cont-frac2 (lambda (i) 1.0)
           (lambda (i) 1.0)
           12)