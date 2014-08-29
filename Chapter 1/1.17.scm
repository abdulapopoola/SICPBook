(define (double x) (* 2 x))

(define (halve x) (/ x 2))

(define (fast-mult x n)
  (cond ((or (zero? x) (zero? n)) 0)
    	((= 1 n) x)
	((even? n) (fast-mult (double x) (halve n)))
	((odd? n) (+ x (fast-mult x (- n 1))))))

(fast-mult 2 10)
