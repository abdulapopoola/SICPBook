#lang planet neil/sicp

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (cdr mobile))
(define (branch-length branch) (car branch))
(define (branch-structure branch) (cdr branch))

(define (total-weight mobile)
  (define (branch-weight branch)
    (let ((branch-struct (branch-structure branch)))
      (if (pair? branch-struct)
        (total-weight branch-struct)
        branch-struct)))
  (+ branch-weight 
     (left-branch mobile)
     (right-branch mobile)))

(define (balanced? mobile)
  
     