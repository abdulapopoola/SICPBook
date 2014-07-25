(define (inc x) (+ x 1))

(define (dec x) (- x 1))

(define (sumMethod1 a b)
  (if (= a 0) 
      b 
      (inc (sumMethod1 (dec a) b))))

(+ 4 5)

;; Recursive process generated by the recursive sumMethod1 shown using substitution method
;; (sumMethod1 4 5)
;; (inc (sumMethod1 3 5))
;; (inc (inc (sumMethod1 2 5)))
;; (inc (inc (inc (sumMethod1 1 5))))
;; (inc (inc (inc (inc (sumMethod1 0 5)))))
;; (inc (inc (inc (inc 5))))
;; (inc (inc (inc 6)))
;; (inc (inc 7))
;; (inc 8)
;; 9

(define (sumMethod2 a b)
  (if (= a 0)
    b
    (sumMethod2 (dec a) (inc b))))

;; Iterative process generated by recursive sumMethod2 shown using the substitution method
;; (sumMethod2 4 5)
;; (sumMethod2 3 6)
;; (sumMethod2 2 7)
;; (sumMethod2 1 8)
;; (sumMethod2 0 9)
;; 9

;; Note that each integer value 5 would be expanded recursively in terms of itself until it gets to 0, same for 6, 7, 8 until the result 9 is achieved.
;; (inc (+ (dec 4) 5))
;; (inc (+ 3 5))
;; (+ (+ 3 5) 1)
;; ;; (+ (inc (+ (dec 3) 5)) 1)
;; (+ (inc (+ 2 5)) 1)
;; (+ (+ (+ 2 5) 1) 1)
;; (+ (+ (inc (+ (dec 2) 5)) 1) 1 )
;; (+ (+ (inc (+ 1 5)) 1) 1)
;; (+ (+ (+ (+ 1 5) 1) 1) 1)
;; (+ (+ (+ (inc (+ (dec 1) 5)) 1) 1) 1)
;; (+ (+ (+ (inc (+ 0 5)) 1) 1) 1)
;; (+ (+ (+ (+ (+ 0 5) 1) 1) 1) 1)
;; (+ (+ (+ (+ 5 1) 1) 1) 1)



