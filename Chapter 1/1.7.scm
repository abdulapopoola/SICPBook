(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (square x) ( * x x) )

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) 
  (/ (+ x y) 2))

;; The current good-enough? stops as soon as the difference between the
;; square of the guess and the actual number is less than 0.001.
;; For extremely small or large numbers; a close non-accurate guess will pass this test
;; even though it is not the accurate value.
;; Also this is the reason why (sqrt 9) is not an absolute 3.0 value.
;;
;; NEW implementation
(define (sqrt-iter guess x)
  (if (good-enough? guess (improve guess x))
      guess
      (sqrt-iter (improve guess x) x)))

(define (good-enough? prevGuess nextGuess)
  (< 	(/ (abs (- prevGuess nextGuess))
	   prevGuess	  	   
  	)
	1.0e-20	
  )
)

(sqrt 9) ; absolute 3 value

