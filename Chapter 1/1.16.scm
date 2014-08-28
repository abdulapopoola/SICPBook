(define (square n) (* n n))

(define (fast-expt a b n)
  (cond ((= n 0) a)
        ((even? n) (fast-expt a (square b) (/ n 2)))
        ((odd? n)  (fast-expt (* a b) b (- n 1)))))

(fast-expt 1 2 18)
