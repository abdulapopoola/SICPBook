#lang planet neil/sicp

(define (timed-prime-test n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime n (- (runtime) start-time))
      false))

(define (report-prime n elapsed-time)
  (display n)
  (display " *** ")
  (display elapsed-time)
  (newline))

(define (next n)
  (cond ((= n 2) 3)
        (else (+ n 2))))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (next test-divisor)))))

(define (divides? x y)
  (= (remainder y x) 0))

(define (square n) (* n n))

(define (prime? n) (= (smallest-divisor n) n))

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

;;These are still too fast so using larger numbers
(search-for-primes 100000000 2); approximately 1000
(newline)
(search-for-primes 1000000000 2); approximately 2000
(newline)
(search-for-primes 10000000000 2); approximately 6000

;;For a factor of 10 increase, runtime increases by approx (sqrt 10) ~ 3.16...

;; Algorithm speeds up however the order of growth is same. The core algorithm 
;; works by comparing (sqrt n) numbers; using only odd numbers halves this
;; comparision but does not change the algorithm's scale of growth. However the runtime is improved
;; 