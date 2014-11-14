#lang planet neil/sicp

;; helpers
(define (average x y) (/ (+ x y) 2))

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (make-segment point1 point2)
  (cons point1 point2))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

;; ASSUMING rectangle is defined using 2 line segments
;; ignoring error checks

(define (square x) (* x x))

(define (make-rect h-seg v-seg)
  (cons h-seg v-seg))

;; first rect line segment
(define (h-seg-rect rect)
  (car rect))

;; second rect line segment
(define (v-seg-rect rect)
  (cdr rect))

(define (length-side rect-seg)
  (let ((x0 (x-point (start-segment rect-seg)))
        (y0 (y-point (start-segment rect-seg)))
        (x1 (x-point (end-segment rect-seg)))
        (y1 (y-point (end-segment rect-seg))))
    (sqrt (+ (square (- x0 x1))
             (square (- y0 y1))))))

(define (length rect)
  (length-side (h-seg-rect rect)))
        
(define (breadth rect)
  (length-side (v-seg-rect rect)))
  
(define (area rect)
  (* (length rect) (breadth rect)))

(define (perimeter rect)
  (* 2 (+ (length rect) (breadth rect))))

(define rect 
  (make-rect 
   (make-segment (make-point 0 0) (make-point 4 0))
   (make-segment (make-point 4 0) (make-point 4 4))))

(area rect)
(perimeter rect)

;;ASSUMING RECT is defined using origin point (x,y) and
;; length and breadth
;;rough implementation, need new public methods to pick up
;; line segments but ignoring for now
(define (make-rect2 point length breadth)
  (cons point (cons length breadth)))

(define (length2 rect2)
  (car (cdr rect2)))

(define (breadth2 rect2)
  (cdr (cdr rect2)))

(define rect2
  (make-rect2 (make-point 0 0) 4 4))

(define (area2 rect)
  (* (length2 rect) (breadth2 rect)))

(define (perimeter2 rect)
  (* 2 (+ (length2 rect) (breadth2 rect))))

(area2 rect2)
(perimeter2 rect2)