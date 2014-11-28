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
(define (div-interval x y)
  (mul-interval x 
                (make-interval 
                 (/ 1.0 (upper-bound y)) 
                 (/ 1.0 (lower-bound y)))))
(define (add-interval x y)
  (make-interval (+ (lower-bound x) 
                    (lower-bound y))
                 (+ (upper-bound x) 
                    (upper-bound y))))
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))
(define (center i)
  (/ (+ (lower-bound i) 
        (upper-bound i)) 
     2))
(define (width i)
  (/ (- (upper-bound i) 
        (lower-bound i)) 
     2))
(define (percent interval)
  (* (/ (width interval) 
        (center interval))
     100))

(define (par1 r1 r2)
  (div-interval 
   (mul-interval r1 r2)
   (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval 
     one
     (add-interval 
      (div-interval one r1) 
      (div-interval one r2)))))

(define int1 (make-center-width 2 0.05)) 
(define int2 (make-center-width 4 0.05)) 

(center (par1 int1 int2)) ;;1.3349541539316476
(percent (par1 int1 int2)) ;;5.412113643459231

(center (par2 int1 int2)) ;;1.3332870241733814
(percent (par2 int1 int2)) ;;083463582369477

;;Different results