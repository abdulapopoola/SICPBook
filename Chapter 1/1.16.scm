(define (square n) (* n n))

(define (fast-expt2 a b)
	(define (fast-expt-helper a b n)
		(cond ((= n 0) a)
			   ((even? n) (fast-expt-helper a (square b) (/ n 2)))
			   ((odd? n)  (fast-expt-helper (* a b) b (- n 1)))))
	(fast-expt-helper 1 a b))

(fast-expt2 2 18)      
