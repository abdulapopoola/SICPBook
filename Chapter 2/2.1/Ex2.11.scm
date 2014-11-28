#lang planet neil/sicp

;;helpers
(define (make-interval a b) (cons a b))
(define (lower-bound interval) (car interval))
(define (upper-bound interval) (cdr interval))

(define (mul-interval x y)
  (let ((x1 (lower-bound x))
         (x2 (upper-bound x))
         (y1 (lower-bound y))
         (y2 (upper-bound y)))
    (cond ((and (positive? x1) (positive? x2)
                (positive? y1) (positive? y2))
           ;[+ +] * [+ +]
           (make-interval (* x1 y1) (* x2 y2)))
          ((and (positive? x1) (positive? x2)
                (negative? y1) (positive? y2))
           ;[+ +] * [- +]
           (make-interval (* x2 y1) (* x2 y2)))
          ((and (positive? x1) (positive? x2)
                (negative? y1) (negative? y2))
           ;[+ +] * [- -]
           (make-interval (* x2 y1) (* x1 y2)))
          ((and (negative? x1) (positive? x2)
                (positive? y1) (positive? y2))
           ;[- +] * [+ +]
           (make-interval (* x1 y2) (* x2 y2)))
          ((and (negative? x1) (positive? x2)
                (negative? y1) (positive? y2))
           ;[- +] * [- +]
           (make-interval (min (* x2 y1) (* x1 y2)) 
                          (max (* x2 y2) (* x1 y1))))
          ((and (negative? x1) (positive? x2)
                (negative? y1) (negative? y2))
           ;[- +] * [- -]
           (make-interval (* x2 y1) (* x1 y1)))
          ((and (negative? x1) (negative? x2)
                (positive? y1) (positive? y2))
           ;[- -] * [+ +]
           (make-interval (* x1 y2) (* x2 y1)))
          ((and (negative? x1) (negative? x2)
                (negative? y1) (positive? y2))
           ;[- -] * [- +]
           (make-interval (* x1 y2) (* x1 y1)))
           ((and (negative? x1) (negative? x2)
                (negative? y1) (negative? y2))
           ;[- -] * [- -]
           (make-interval (* x2 y2) (* x1 y1))))))
(define a (make-interval 1 2))
(define b (make-interval -2 2))
(define c (make-interval -4 -1))

(mul-interval a a) ;; (1 4)
(mul-interval a b) ;; (-4 4)
(mul-interval a c) ;; (-8 -1)
(mul-interval b a) ;; (-4 4)
(mul-interval b b) ;; (-4 4)
(mul-interval b c) ;; (-8 8)
(mul-interval c a) ;; (-8 -1)
(mul-interval c b) ;; (-8 8)
(mul-interval c c) ;; (1 16)
  
  
          
          
