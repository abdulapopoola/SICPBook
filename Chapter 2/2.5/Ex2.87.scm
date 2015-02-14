#lang planet neil/sicp

;; INSTALLATION
(define (=zero-poly? poly)
  (define (=zero-all-coeffs coeff-list)
    (cond ((empty-termlist? coeff-list) true)
          ((not (=zero? (coeff (first-term coeff-list)))) false)
          (else (=zero-all-coeffs (rest-terms coeff-list)))))
  (=zero-all-coeffs (term-list poly)))

;; External interface for Integer package
(put '=zero? 'polynomial =zero-poly?)