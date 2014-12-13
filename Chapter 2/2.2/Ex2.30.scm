#lang planet neil/sicp

(define (square x) (* x x))

(define (square-tree tree)
  (cond ((null? tree) nil)
        ((pair? tree)
         (cons (square-tree (car tree))
               (square-tree (cdr tree))))
        (else (square tree))))

(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))

;;Using map and recursion
(define (square-tree2 tree)
  (map (lambda (subtree)
         (if (pair? subtree)
             (square-tree subtree)
             (square subtree)))
       tree))

(square-tree2
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))      
