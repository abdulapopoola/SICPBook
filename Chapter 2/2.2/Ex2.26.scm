#lang planet neil/sicp

;;helpers
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) 
            (append (cdr list1) 
                    list2))))

(define x (list 1 2 3))
(define y (list 4 5 6))

(append x y)
;; '(1 2 3 4 5 6)

(cons x y)
;; '((1 2 3) 4 5 6)

(list x y)
;; equivalent to (cons x (cons y nil))
;; '((1 2 3) (4 5 6))