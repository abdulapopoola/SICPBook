#lang planet neil/sicp

(define (congruent-modulo n)  
  (define (try-it a)
    (if (= a 0)
        (display "Carmicheal number")
        (= (expmod a n n) a)))
  (if (try-it (- n 1))
      (try-it (- n 1))
      (display "Not a Carmicheal number")))


;; start from 1 - n -1
;; check if it is congruent modulo,
;; else return false

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (square (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

(define (square n) (* n n))