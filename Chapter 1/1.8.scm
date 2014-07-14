;; Newton's method for cube roots

(define (cubeRoot x) (
    (cube-root-iter 1.0 x)    		      
))

(define (cube-root-iter guess x)
  (if good-enough? guess x)
  guess
  (cube-root-iter (improve guess x) x)
)
