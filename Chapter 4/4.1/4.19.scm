#lang racket

;; It is very difficult to implement Eva's approach. A scenario that 
;; might work for the exercise would require scanning the definitions
;; and then executing the pure assignments first (e.g. (define a 5) ) 
;; before executing more complex procedures.

;; While this might work for this exercise, it'll fail for mutual
;; recursion -> i.e. procedures defined in terms of each other.