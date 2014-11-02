#lang planet neil/sicp

(define attempts 50000)

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) 
         (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (ceiling (/ n 100))))))

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

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n attempts)
      (report-prime n (- (runtime) start-time))
      false))

(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (square n) (* n n))

(define (search-for-primes startNum primesCount)
  (cond ((= primesCount 0) (values))
        ((even? startNum) (search-for-primes (+ startNum 1) primesCount))
        (else (if (timed-prime-test startNum) 
                  (search-for-primes (+ startNum 2) (- primesCount 1))
                  (search-for-primes (+ startNum 2) primesCount)))))

(search-for-primes 1000 3) ;;1009, 1013, 1019
;; avg runtime ~ 108000
(newline)
(search-for-primes 1000000 3) ;; 1000003, 1000033, 1000037
;; avg runtime ~ 197000
(newline)

(/ 197 108)
;; approximately 2 which is close to 

(/ (log 1000000) (log 1000))
;; 2.0
