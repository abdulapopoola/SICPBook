#lang planet neil/sicp

;;helpers
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (fringe items)
  (cond ((null? items) nil)
        ((pair? (car items))
         (append (fringe (car items)) 
                 (fringe (cdr items))))
        ((cons (car items) (fringe (cdr items))))))

(define x 
  (list (list 1 2) (list 3 4)))

(fringe x)

(fringe (list x x))
    