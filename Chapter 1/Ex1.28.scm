#lang planet neil/sicp

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (checksquare (expmod base (/ exp 2) m) m)
          m))
        (else
         (remainder 
          (* base (expmod base (- exp 1) m))
          m))))

(define (checksquare n m)
  (if (and (not (or (= n 1) (= n (- m 1))))
           (= (remainder (* n n) m) 1))
      0
      (remainder (* n n) m)))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin-test n) 
         (fast-prime? n (- times 1)))
        (else false)))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 2)))))

(miller-rabin-test 561)

(fast-prime? 239 5)