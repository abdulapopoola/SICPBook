#lang planet neil/sicp

(define (cont-frac n d k)
  (define (iter n d i)
    (if (= k i)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (iter n d (+ i 1))))))
  (iter n d 1))

(define (d i)
  (- (* 2 i) 1))

(define (tan-cf x k)
  (cont-frac (lambda (i) 
               (if (= i 1)
                   x
                   (- (* x x))))
             d k))

(- (tan 1.0) (tan-cf 1.0 1200))
;; 2.220446049250313e-16 very small difference