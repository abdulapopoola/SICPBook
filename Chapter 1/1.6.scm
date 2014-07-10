(define (sqrt x)
  (sqrt-iter 1.0 x))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))

(define (new-if predicate 
                then-clause 
                else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) 
  (/ (+ x y) 2))

;; Runs into an infinite loop
(sqrt 9)

;(define (new-if predicate 
;                then-clause 
;                else-clause)
;  (cond (predicate then-clause)
;        (else else-clause))) 
;;;;
;;;;
;;; The problem with the new-if method arises because
;;; the new-if construct will ALWAYS evaluate BOTH clause parameters
;;; (i.e. then-clause and else-clause); this occurs even when both of them are not needed.
;;; The default Scheme if operator will only evaluate the second
;;; parameter if the first is not true and hence avoids the infinite 
;;; loop issue.

;;; Valid Sqrt-iter function
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
