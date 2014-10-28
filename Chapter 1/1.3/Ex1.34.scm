#lang planet neil/sicp

(define (f g) (g 2))

(f (lambda (z) (* z (+ z 1))))
;6

(f f)
;; This will resolve to (2 2) which will give
;; an error since 2 is not an operator
;; Execution channel is shown below
;; (f f)
;;   -> (f 2)
;;   -> (2 2)
;; This resembles partial application too and 
;; trying to partially-apply a non-function value fails.