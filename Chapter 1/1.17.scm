(define (double x) (* 2 x))

(define (halve x) (/ x 2))

;;XOR -> Exclusive OR can be used for determing the sign
;;of the result after multiplication.
;;
;;	x	y	x XOR Y
;;	0	0		0
;;	0	1		1
;;	1	0		1
;;	1	1		0

(define (xor x y)
  (or (and x (not y))
	  (and y (not x))))

(define (mult a b)
	(define (fast-mult x n)
		(cond ((or (zero? x) (zero? n)) 0)
			((= 1 n) x)
			((even? n) (fast-mult (double x) (halve n)))
			((odd? n) (+ x (fast-mult x (- n 1))))))
   	((if (xor (negative? a) (negative? b))
   	   -
   	   +)
   	 (fast-mult (abs a) (abs b))))

(mult +9 +8)
(mult +9 -8)
(mult -9 +8)
(mult -9 -8)
