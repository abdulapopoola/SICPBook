;; Recursive process

(define (f n) 
  (if (< n 3) 
    n
    (+ (f (- n 1)) 
       (* 2 (f (- n 2)))
       (* 3 (f (- n 3))))))

;; Iterative process
(define (f-iter a b c n)
  (if (= n 0)
    c
    (f-iter (+ a (* 2 b) (* 3 c))
	    a
	    b
	    (- n 1))))

(define (f n) 
  (if (< n 3) 
    n
    (f-iter 2 1 0 n)

;; Better iterative process; doesn't do redundant calculations
(define (f-iter a b c n)
  (if (= n 0)
    a
    (f-iter (+ a (* 2 b) (* 3 c))
	    a
	    b
	    (- n 1))))

(define (f n) 
  (if (< n 3) 
    n
    (f-iter 2 1 0 (- n 2))
