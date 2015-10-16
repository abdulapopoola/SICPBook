#lang planet neil/sicp

(define (factorial n)
  (if (= n 1)
      1
      (* (factorial (- n 1)) n)))


;; Results for recursive factorial
+-------+--------+-------+
|   n   | pushes | depth |
+-------+--------+-------+
|     1 |     16 |     8 |
|    10 |    304 |    53 |
|   100 |   3184 |   503 |
|  1000 |  31984 |  5003 |
| 10000 | 319984 | 50003 |
+-------+--------+-------+

;; pushes ~ 32n - 16
;; depth ~ 5n + 3

;; TABLE
+---------------------+---------------+------------------+
|                     | Maximum depth | Number of pushes |
+---------------------+---------------+------------------+
| Recursive factorial | 5n + 3        | 32n – 16         |
| Iterative factorial | 10            | 35n + 29         |
+---------------------+---------------+------------------+

;; The recursive factorial is only slightly better in terms of pushes 
;; but the iterative factorial wins in terms of depth
