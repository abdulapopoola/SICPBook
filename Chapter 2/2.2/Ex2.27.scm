#lang planet neil/sicp

(define (deep-reverse list1)
  (define (iter items acc)
    (cond ((null? items) acc)
          ((list? items) 
           (iter (cdr items) (cons (deep-reverse (car items)) acc)))
          (else
           (iter '() (cons items acc)))))
  (iter list1 '()))

;;(reverse (list 1 4 9 16 25))

(define x 
  (list (list 1 2) (list 3 4)))

(deep-reverse x)
