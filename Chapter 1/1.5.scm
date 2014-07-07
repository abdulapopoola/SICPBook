;; Exercise 1.5

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

(test 0 (p))

;Applicative order - this always evaluates the arguments first
;and generates results (i.e. primitives) to be passed into other expressions.
;As such, the evaluation of the p parameter will lead to an infinite loop.
;;
;;
;Normal order - evaluation of arguments only occurs when they are needed
;As such, the evaluation of the p parameter (which causes an infinite loop) 
;never occurs because of the comparision with 0 and thus the result will be a 0.
