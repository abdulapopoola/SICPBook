#lang planet neil/sicp

;;HELPER methods
(define (cube x) (* x x x))
(define (inc x) (+ x 1))
(define (identity x) x)

;;This is the reduce/accumulate concept from func programming
;;ITERATIVE Version
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (accumulate combiner (combiner (term a) null-value) 
                  term (next a) next b)))

;;RECURSIVE Version of accumulate
(define (accumulate2 combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate2 combiner null-value 
                                      term (next a) next b))))

;;Sum of cubes
;;Beauty of this involves passing in the cube function to the sum function
;; which in turn relies on the accumulate function to succeed

;; Sum using iterative accumulate
(define (sum term a next b)  
  (accumulate + 0 term a next b))

;;Sum using recursive accumulate
(define (sum2 term a next b)  
  (accumulate2 + 0 term a next b))

;;Examples
(define (sum-cubes a b)
  (sum cube a inc b))

(sum-cubes 1 10)

(define (sum-cubes2 a b)
  (sum2 cube a inc b))

(sum-cubes2 1 10)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;PRODUCT using iterative accumulate
(define (product term a next b)  
  (accumulate * 1 term a next b))

;PRODUCT using recursive accumulate
(define (product2 term a next b)  
  (accumulate2 * 1 term a next b))

;; EXAMPLES
(define (factorial n)  
  (product identity 1 inc n))

(factorial 5)

(define (factorial2 n)  
  (product2 identity 1 inc n))

(factorial 5)