#lang planet neil/sicp

;;helpers
(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (width interval)
  (/ (- (upper-bound interval)
        (lower-bound interval))
     2))

;; Assuming intervals a (w x) and b (y z)
;; (width a) -> (x - w) / 2
;; (width b) -> (z - y) / 2

;; sum a and b -> (w+y x+z)
;; (width of the sum) -> (x+z-w-y)/2
;;   -> (x - w)/2 + (z-y)/2
;;   -> width a + width b

;; Same applies for subtraction

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

;;multiplication can be proved by showing an example 
;; where the result varies
(define multiplier (make-interval 4 3))
(define eqWidth1 (make-interval 2 4))
(define eqWidth2 (make-interval 6 8))
(mul-interval multiplier eqWidth1)
(mul-interval multiplier eqWidth1)