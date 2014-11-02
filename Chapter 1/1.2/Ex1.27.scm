#lang planet neil/sicp

(define (congruent-modulo n)  
  (display n)
  (if (check 1 n)      
      (display " is a Carmicheal number\n")
      (display " is not a Carmicheal number\n")))
  
(define (check a n)    
  (cond ((= a n) true)
        ((= (expmod a n n) a)
         (check (+ 1 a) n))
        (else false)))

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

(congruent-modulo 10)

(congruent-modulo 561)
(congruent-modulo 1105)
(congruent-modulo 1729)
(congruent-modulo 2465)
(congruent-modulo 2821)