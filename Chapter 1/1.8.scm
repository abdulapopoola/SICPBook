;; Newton's method for cube roots

(define (square x) (* x x))

(define (good-enough? guess next-guess)
  (< (abs (- next-guess guess))
     (* 1.0e-20 guess)))

(define (improve guess x)
  (/ (+ (/ x (square guess))
     (* 2 guess))
     3))

(define (cube-root-iter guess x)
  (if (good-enough? guess (improve guess x))
  guess
  (cube-root-iter (improve guess x) x)))

(define (cube x) (* x x x))

(define (cube-root x) (cube-root-iter 1.0 x))

;; use methods
(cube-root 1.0)
(cube-root 27.0)
(cube-root 64.0)
