#lang planet neil/sicp

;; Generic predicate
(define (=zero? x) (apply-generic '=zero? x))

;; Scheme number package
(put '=zero? ('scheme-number) zero?)

;; Rational number package
;; Internal procedure
(define (zero? x)
  (zero? (numer x)))

;; External interface
(put '=zero? ('rational) zero?)

;; Complex number package
;; Internal procedure
(define (zero? x y)
  (and (zero? (real-part x))
       (zero? (imag-part x))))

;; External interface
(put '=zero? ('complex) zero?)
    


