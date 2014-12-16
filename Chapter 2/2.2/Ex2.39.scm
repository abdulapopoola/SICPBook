#lang planet neil/sicp

;;helpers
(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (if (null? sequence)
      initial
      (op (fold-left op initial (cdr sequence))
          (car sequence))))

(define (reverse sequence)
  (fold-right 
   (lambda (x y) (cons y x)) nil sequence))

(define (reverse2 sequence)
  (fold-left 
   (lambda (x y) (cons x y)) nil sequence))

(reverse (list 1 4 9 16 25))
(reverse2 (list 1 4 9 16 25))