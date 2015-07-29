#lang racket

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

;; This will be transformed into the form below

(define (solve f y0 dt)
  (lambda ⟨vars⟩
    (let ((y '*unassigned*)
          (dy '*unassigned*))
      (let ((a (integral (delay dy) y0 dt))
            (b (stream-map f y)))
        (set! u a)
        (set! v b))
      y)))

;; Lambda execution translation will in turn transform the let expression
;; to the following:
(define (solve f y0 dt)
  (lambda ⟨vars⟩
    (let ((y '*unassigned*)
          (dy '*unassigned*))
      ((lambda (a b)
        (set! u a)
        (set! v b))
       (a (integral (delay dy) y0 dt))
       (b (stream-map f y)))
      y)))

;; But this fails because the y value is still '*unassigned when it is passed
;; into the lambda
