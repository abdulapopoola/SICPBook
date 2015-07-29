#lang racket


;; There is an extra frame because the let generates a new frame however
;; this does not make any difference since the original environment can
;; still be accessed.

;; Fix for simultaneous definition is to ensure all defines in the body
;; come first, hence there is no need to use 'let to define them first.

(define (re-order-defines body)
  (append (filter (λ (entry) (definition? (car entry))) defines-body) 
          (filter (λ (entry) (not (definition? (car entry)))) defines-body))) 