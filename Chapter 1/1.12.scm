;; Prints the Pascal's triangle coefficient for a location.
;; x represents the row index
;; y represents the column index
(define (pascal x y)
  (cond ((= y 1) 1)
  	((= y x) 1)
  	(else (+ (pascal (- x 1) y)
		 (pascal (- x 1) (- y 1)))))

