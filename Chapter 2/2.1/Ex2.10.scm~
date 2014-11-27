#lang planet neil/sicp

;;helpers
(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) 
               (lower-bound y)))
        (p2 (* (lower-bound x) 
               (upper-bound y)))
        (p3 (* (upper-bound x) 
               (lower-bound y)))
        (p4 (* (upper-bound x) 
               (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (xor x y)
  (or (and x (not y))
	  (and y (not x))))

(define (spans-zero? interval)
  (xor (positive? (lower-bound interval))
       (positive? (upper-bound interval))))

(spans-zero? (make-interval  1   1)) ;#f
(spans-zero? (make-interval  1  -1)) ;#t
(spans-zero? (make-interval -1  1)) ;#t
(spans-zero? (make-interval -1 -1)) ;#f

(define (div-interval x y)
  (if (spans-zero? y)
      (display "Divisor interval spans zero; this is an undefined operation. Exiting...\n")
      (mul-interval x 
                (make-interval 
                 (/ 1.0 (upper-bound y)) 
                 (/ 1.0 (lower-bound y))))))


(div-interval (make-interval  1 2)
	      (make-interval -1 1)) ; Divisor error

(div-interval (make-interval  1  1)
	      (make-interval -1 -1)) ; => '(-7.55 . -5.64)
