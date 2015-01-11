#lang planet neil/sicp

;;Requires code from earlier exercises

(define (successive-merge pairs)
  (if (= (length pairs) 1)
      pairs
      (successive-merge
       (adjoin-set (make-code-tree (car pairs)
                                   (cadr pairs)) 
                   (cddr pairs)))))

