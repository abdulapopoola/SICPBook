#lang planet neil/sicp

;; helpers
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
;;O(N) no difference from version in 2.59

(define (adjoin-set x set)
  (cons x set))  
;;O(1) different from version in 2.59 which is O(N)

(define (union-set set1 set2)
  (define (iter s1 result)
    (if (null? s1)
        result
        (iter (cdr s1)
              (adjoin-set (car s1) result))))
  (iter set1 set2))
;;O(N) different version in 2.59 which is O(N**2)

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) 
         '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) 
                                 set2)))
        (else (intersection-set (cdr set1) 
                                set2))))
;;O(N) different version in 2.59 which is O(N**2)

;;This version might be preferred for operations on large datasets
;; which require speed. The flipside is that lookups might take more
;; time as N grows larger due to replication of the same values and more
;; memory usage too.

(union-set '(1 2 3) '(4 5 6))
(union-set '() '(4 5 6 6))
(union-set '(1 2 3) '(1 2 3))
(intersection-set '(1 2 2 3) '(1 2 4 6))