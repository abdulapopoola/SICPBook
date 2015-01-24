#lang planet neil/sicp

;; Generic predicate
(define (equ? x y) (apply-generic 'equ? x y))

;; Scheme number package
(put 'equ? ('scheme-number 'scheme-number) =)

;; Rational number package
;; Internal procedure
(define (equ? x y)
  (and (eq? (numer x) (numer y))
       (eq? (denom x) (denom y))))

;; External interface
(put 'equ? ('rational 'rational) equ?)

;; Complex number package
;; Internal procedure
(define (equ? x y)
  (and (eq? (real-part x) (real-part y))
       (eq? (imag-part x) (imag-part y))))
;; External interface
(put 'equ? ('complex 'complex) equ?)
    


