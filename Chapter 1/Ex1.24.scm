#lang planet neil/sicp

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
  (if (fast-prime? n 5)
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
(newline)
(search-for-primes 10000 3) ;;10007, 10009, 10037
(newline)
(search-for-primes 100000 3) ;; 100003, 100019, 100043
(newline)
(search-for-primes 1000000 3) ;; 1000003, 1000033, 1000037
(newline)
(search-for-primes 10000000 3) ;; 1000003, 1000033, 1000037
(newline)
(search-for-primes 100000000 3) ;; 1000003, 1000033, 1000037
(newline)
(search-for-primes 1000000000 3) ;; 1000003, 1000033, 1000037
(newline)
(search-for-primes 10000000000 3) ;; 1000003, 1000033, 1000037
(newline)
(search-for-primes 10000000000 3) ;; 1000003, 1000033, 1000037
(newline)
