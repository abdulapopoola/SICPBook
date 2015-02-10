#lang planet neil/sicp

(define (type-tag val) (car val))
(define (contents val) (cdr val))
(define (get-lower type other) #t)

(define type-tower '(integer rational real complex))

(define (project val)
  (let ((val-type-tower (memq (type-tag val) (reverse type-tower))))
    (cond ((not (val-type-tower))
           (error "Unknown type; not found in tower" (type-tag val)))
          ((null? (cdr val-type-tower)) val)
          (else 
           (let ((lower-operator
                  (get-lower (type-tag val) (cdr val-type-tower))))
                 (if lower-operator
                     (lower-operator (contents val))
                     (error "No lower operator exists for these types"
                            (list (type-tag val) (cdr val-type-tower)))))))))
  
