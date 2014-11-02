#lang planet neil/sicp

(define attempts 5)

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) 
         (fast-prime? n (- times 1)))
        (else false)))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random n))))

(define (fast-expt a b)
	(define (fast-expt-helper a b n)
		(cond ((= n 0) a)
			   ((even? n) (fast-expt-helper a (square b) (/ n 2)))
			   ((odd? n)  (fast-expt-helper (* a b) b (- n 1)))))
	(fast-expt-helper 1 a b))

(define (expmod base exp m)
  (remainder (fast-expt base exp) m))

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
;; avg runtime ~ 1000
(newline)
(search-for-primes 1000000 3) ;; 1000003, 1000033, 1000037
;; avg runtime ~ 104738000
(newline)

;; This is much slower because of the extra large values that have to be handled by the
;; fast-expt function call.
;; The original function uses a trick (mentioned in SICP as footnote #46) to ensure that
;; the number is never larger than m and this speeds up the calculation. However the hack
;; only calculates the remainder of the huge exponent when it is done and this takes a lot
;; of time multiplying huge numbers.
;; The modular arithmetic trick is explained thus:
;; a*b modulo m === ((a modulo m) * (b modulo m)) modulo m
