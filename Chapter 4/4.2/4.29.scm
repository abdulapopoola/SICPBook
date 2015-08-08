#lang planet neil/sicp

;; A program with a very expensive operation that needs to be thunked.
(define (slow-for-un-memoized x) (* x x))

;;Memoized version
square -> 100
count -> 1

; Unmemoized version
square -> 100
count -> 2

;; This happens because the id function is evaluated two times - 
;; first in the id call and secondly in the square call