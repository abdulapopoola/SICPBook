#lang planet neil/sicp

;; helpers
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (union-set set1 set2)
  (define (iter s1 result)
    (if (null? s1)
        result
        (iter (cdr s1)
              (adjoin-set (car s1) result))))
  (iter set1 set2))

(union-set '(1 2 3) '(4 5 6))