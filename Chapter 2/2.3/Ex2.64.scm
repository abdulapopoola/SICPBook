#lang planet neil/sicp

;;helpers
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree 
        elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result 
                   (partial-tree (cdr non-left-elts) right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry 
                                 left-tree 
                                 right-tree)
                      remaining-elts))))))))

(list->tree '(1 3 5 7 9 11))

;; this method splits the array in half successively, the first half is 
;; processed to be the left branch while the other half is converted into the right tree.
;; Since the set is ordered, the smallest element is at the beginning and thus has no
;; tree to its left; the next element will be greater than the one before it and thus can be
;; its parent and the next element following that can be the right subtree of the prior one.
;; This still follows balanced tree structure.
;; A left half of the set will be smaller than its right half and this same pattern can be
;; recursively repeated.

;; Should be O(N)as the operation will be carried out on every item of a list of N items.