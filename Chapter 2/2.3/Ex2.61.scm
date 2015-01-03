#lang planet neil/sicp

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define (adjoin-set2 x set)
  (cond ((null? set) (cons x set))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set2 x (cdr set))))))

(adjoin-set2 1 '())
(adjoin-set2 1 '(1 2))
(adjoin-set2 1 '(3 4 5))
(adjoin-set2 4 '(1 2 3))
