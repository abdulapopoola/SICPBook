#lang planet neil/sicp

(define (deep-reverse list1)
  (define (iter items acc)
    (cond ((null? items) acc)
          ((pair? (car items))
           (iter (cdr items) (cons (deep-reverse (car items)) acc)))
          (else
           (iter (cdr items) (cons (car items) acc)))))
  (iter list1 '()))

(define x 
  (list (list 1 2) (list 3 4)))

(deep-reverse x)
