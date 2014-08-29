(define (double x) (* 2 x))

(define (halve x) (/ x 2))

(define (fast-mult x n)
  (cond ((= 1 n) x)
	((even? n) (double x) (halve n))
	((odd? n) (+ x (fast-mult x (- n 1))))))

(fast-mult 2 10)
