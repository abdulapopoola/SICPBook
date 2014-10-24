#lang racket
(define (inc n) (+ n 1))
(define (identity x) x)

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (factorial n)  
  (product identity 1 inc n))

(factorial 5)

;; ITERATIVE Version - factorial function is same and can be simplified by passing in function (iter vs recursive)
;; to use
(define (factorial-iter n)
  (product-iter identity 1 inc n))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

(factorial-iter 5)