#lang planet neil/sicp

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

;; The answers were gotten by running loader.scm and deducing the answers

;; 1. Max depth 10