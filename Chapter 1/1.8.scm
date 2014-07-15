;; Newton's method for cube roots

(define (cube-root x) (
    (cube-root-iter 1.0 x)))

(define (cube-root-iter guess x)
  (if good-enough? guess (improve guess x))
  guess
  (cube-root-iter (improve guess x) x)
)

(define (good-enough? guess next-guess)
  (< (abs (- guess next-guess))
     (* 0.001 guess)))

(define cube (lambda (x) (* x x x)))

(define (square x) (* x x))

(define (improve guess x)
  (/ (+ (/ x (square guess))
	(* guess 2))
     3))

;; use methods
(cube-root 1.0)
