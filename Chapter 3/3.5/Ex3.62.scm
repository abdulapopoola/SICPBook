#lang racket

(define (mul-series s1 s2)
  (cons-stream 
   (* (stream-first s1) (stream-first s2))
   (add-streams (scale-stream (stream-rest s2) (stream-first s1))
                (mul-series (stream-rest s1) s2))))

(define (invert-unit-series S)
  (cons-stream 1
               (mul-series 
                (scale-stream S -1)
                (invert-unit-series S))))

(define (div-series S1 S2)
  (define den-constant (stream-car S2))
  (if (= den-constant 0)
      (error "The constant term of the denominator series should not be zero")
      (scale-stream (mul-series 
                     S1
                     (invert-series (scale-stream S2 (/ 1 den-constant))))
                    (/ 1 den-constant))))      

(define (tangent-series)
  (div-series sine-series cosine-series))