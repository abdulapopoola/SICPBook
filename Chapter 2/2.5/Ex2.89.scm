#lang planet neil/sicp

(define (dense-terms-list poly)
  (map (lambda (term) (coeff term))
       (term-list poly)))
