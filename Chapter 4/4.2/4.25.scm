#lang racket

(define (unless condition 
                usual-value 
                exceptional-value)
  (if condition 
      exceptional-value 
      usual-value))

(define (factorial n)
  (unless (= n 1)
          (* n (factorial (- n 1)))
          1))

(factorial 5)

;; Applicative order
;; Never ending loop because both input conditions are always evaluated
;; thus there is no way it'll stop - it'll continue going to 0, -1, -2...

;; Normal order
;; This will stop since once the condition is true, there is no need to 
;; evaluate both halves.

