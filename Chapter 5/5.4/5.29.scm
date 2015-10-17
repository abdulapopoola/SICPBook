#lang planet neil/sicp

;; The answers were gotten by running loader.scm using the 
;; and deducing the answers

(define (fib n)
  (if (< n 2)
      n
      (+ (fib (- n 1)) (fib (- n 2)))))

+-------+--------+-------+
|   n   | pushes | depth |
+-------+--------+-------+
|     2 |     72 |    13 |
|     3 |    128 |    18 |
|     4 |    240 |    23 |
|     5 |    408 |    28 |
|     6 |    688 |    33 |
|    10 |   4944 |    53 |
|    15 |  55232 |    78 |
|    20 | 612936 |   103 |
+-------+--------+-------+

;; depth ~ 5n + 3

;; Pushes
;; S(n) = S(n - 1) + S(n - 2) + 40

;; Formula
;; S(n) = 56 * Fib(n+1) - 40