#lang planet neil/sicp

(define (square x) (* x x))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))

(square-list (list 1 2 3 4))
;;(mcons 16 (mcons 9 (mcons 4 (mcons 1 '()))))
;; This produces the wrong order because the first value is gotten first
;; and put in the innermost cons; successive cons wrap around this value.

(define (square-list2 items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square 
                     (car things))))))
  (iter items nil))
(square-list2 (list 1 2 3 4))
;; The order is right here but it does not work too because the result is 
;; getting updated and successive values wrap around it.

;; A fix would be to do the cons operation outside and put the results of 
;; the iter call as the second value.