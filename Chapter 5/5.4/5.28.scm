#lang planet neil/sicp

;; The answers were gotten by running loader.scm using the 
;; non-recursive eceval machine and deducing the answers

;; TABLE
+---------------------+---------------+------------------+
|                     | Maximum depth | Number of pushes |
+---------------------+---------------+------------------+
| Recursive factorial | 8n + 3        | 34n – 16         |
| Iterative factorial | 3n + 14       | 37n + 33         |
+---------------------+---------------+------------------+ 

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

+-------+--------+-------+
|   n   | pushes | depth |
+-------+--------+-------+
|     1 |     70 |    17 |
|    10 |    403 |    44 |
|   100 |   3733 |   314 |
|  1000 |  37033 |  3014 |
| 10000 | 370033 | 30014 |
+-------+--------+-------+

;; pushes ~ 37n + 33
;; depth ~ 3n + 14

(define (factorial n)
  (if (= n 1)
      1
      (* (factorial (- n 1)) n)))


;; Results for recursive factorial
+-------+--------+-------+
|   n   | pushes | depth |
+-------+--------+-------+
|     1 |     18 |    11 |
|    10 |    324 |    83 |
|   100 |   3384 |   803 |
|  1000 |  33984 |  8003 |
| 10000 | 339984 | 80003 |
+-------+--------+-------+

;; pushes ~ 34n - 16
;; depth ~ 8n + 3



