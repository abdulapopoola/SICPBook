#lang planet neil/sicp

(define (reverse list1)
  (define (iter items acc)
    (if (null? items)
      acc
      (iter (cdr items)
            (cons (car items) acc))))
  (iter list1 '()))

(reverse (list 1 4 9 16 25))

;;Second approach
;;Reversing is appending the car of a list to its cdr

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) 
            (append (cdr list1) 
                    list2))))

(define (reverse2 list1)
  (if (null? (cdr list1))
      list1
      (append (reverse2 (cdr list1))
              (list (car list1)))))

(reverse2 (list 1 4 9 16 25))