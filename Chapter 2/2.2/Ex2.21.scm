#lang planet neil/sicp

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (square x) (* x x))

(define (square-list items)
  (if (null? items)
      nil
      (cons (square (car items))
            (square-list (cdr items)))))

(define (square-list2 items)
  (map square items))

(square-list (list 1 2 3 4))
(square-list2 (list 1 2 3 4))
;;Using inbuilt map - (map square items)