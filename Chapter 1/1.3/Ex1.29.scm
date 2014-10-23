#lang planet neil/sicp
;; Simpson's rule
;; h = (b - a) /n
;; y(k) = f(a + kh)
;; NEED TO UNDERSTAND, still abstruse

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (simpsons-rule f a b n)
  (define h (/ (- b a) n))
  (define (inc x) (+ x 1))
  (define (y-k k) (f (+ a (* k h))))
  (define (term k)
    (* (cond ((odd? k) 4)
             ((or (= k 0) (= k n)) 1)
             ((even? k) 2))
       (y-k k)))
  (/ (* h (sum term 0 inc n)) 3))

(define (cube x) (* x x x))

(simpsons-rule cube 0 1 100)

(simpsons-rule cube 0 1 1000)