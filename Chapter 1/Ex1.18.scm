(define (double x) (* 2 x))

(define (halve x) (/ x 2))

(define (fast-mult a x n)
  (cond ((= 0 n) a)
	((even? n) (fast-mult a (double x) (halve n)))
	((odd? n) (fast-mult (+ a x) x (- n 1)))))

(fast-mult 0 2 10)
