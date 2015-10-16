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

;; 2. 

+-------+--------+
|   n   | pushes |
+-------+--------+
|     1 |     64 |
|    10 |    379 |
|   100 |   3529 |
|  1000 |  35029 |
| 10000 | 350029 |
+-------+--------+

;; Formula for pushes is ~ 35n + 29