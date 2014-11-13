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

;; rectangle, start point, length and breadth
;; rectangle, 4 segments

(define (square x) (* x x))

(define (make-rect h-seg v-seg)
  (cons h-seg v-seg))

;; first rect line segment
(define (h-seg-rect rect)
  (car rect))

;; second rect line segment
(define (v-seg-rect rect)
  (cdr rect))

(define (length-rect rect)
  (let ((p0 (start-segment (h-seg-rect rect)))
        (p1 (end-segment (v-seg-rect rect)))        
        (x0 (x-point p0))
        (y0 (y-point p0))
        (x1 (x-point p1))
        (y1 (y-point p1)))
    (sqrt (+ (square (- x0 x1))
             (square (- y0 y1))))))
        
  