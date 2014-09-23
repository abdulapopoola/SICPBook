#lang planet neil/sicp

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) 
                       start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
	((divides? test-divisor n) test-divisor)
	(else (find-divisor n (+ test-divisor 1)))))

(define (divides? x y)
  (= (remainder y x) 0))

(define (square n) (* n n))

(define (prime? n) (= (smallest-divisor n) n))

(define (search-for-primes start end)
  (#t))
;;start number
;;how many needed
;;check if even, if even, +1 with same function
;;else, call timed-prime-test with start number
;;; continue calling with odd+2 until found gets to zero