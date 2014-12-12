#lang planet neil/sicp

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile) (car mobile))
(define (right-branch mobile) (car (cdr mobile)))
(define (branch-length branch) (car branch))
(define (branch-structure branch) (car (cdr branch)))

(define (branch-weight branch)
  (let ((branch-struct (branch-structure branch)))
    (if (pair? branch-struct)
        (total-weight branch-struct)
        branch-struct)))

(define (total-weight mobile)  
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (torque branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (balanced-branch branch)
  (let ((branch-struct (branch-structure branch)))
    (if (pair? branch-struct)
        (balanced? branch-struct)
        true)))

(define (balanced? mobile)
  (and (= (torque (left-branch mobile))
          (torque (right-branch mobile)))
       (balanced-branch (left-branch mobile))
       (balanced-branch (right-branch mobile))))
  

(define b1 (make-mobile (make-branch 1 2) (make-branch 1 2)))
(define b2 (make-mobile (make-branch 3 2) (make-branch 7 8)))

(total-weight b1)
(balanced? b1)
(total-weight b2)
(balanced? b2)

;; New interface definitions
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (right-branch mobile) (cdr mobile))
(define (branch-structure branch) (cdr branch))