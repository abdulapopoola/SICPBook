#lang planet neil/sicp

(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((= (car set1) (car set2))
         (cons (car set1) (union-set (cdr set1) (cdr set2))))
        ((< (car set1) (car set2))
         (cons (car set1) (union-set (cdr set1) set2)))
        (else (cons (car set2) (union-set set1 (cdr set2))))))

(union-set '(1 2 3) '(1 2 3))
(union-set '(1 2 3) '(4 5 6))
(union-set '(4 5 6) '(1 2 3))
(union-set '(1 2 3) '(4 5 6))
