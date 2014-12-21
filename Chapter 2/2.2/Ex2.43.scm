#lang planet neil/sicp

(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position 
           new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))

;; With this approach, the queen positions are calculated for every row in  
;; the columns and this will be slow. The original calculated it for every
;; column once.

;; It is exponential in terms of T