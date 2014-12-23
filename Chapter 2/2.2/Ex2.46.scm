#lang planet neil/sicp

(define (make-vector v-x v-y)
  (cons v-x v-y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cdr v))

(define (add-vect v1 v2)
  (make-vector (+ (xcor-vect v1) (xcor-vect v2))
               (+ (ycor-vect v1) (ycor-vect v2))))

(define (sub-vect v1 v2)
  (make-vector (- (xcor-vect v1) (xcor-vect v2))
               (- (ycor-vect v1) (ycor-vect v2))))

(define (scale-vect v s)
  (make-vector (* s (xcor-vect v))
               (* s (ycor-vect v))))

(define v (make-vector 1 2))
(xcor-vect v); 1
(ycor-vect v); 2

(add-vect v v); (2 4)
(sub-vect v v); (0 0)
(scale-vect v 2); (2 4) 
