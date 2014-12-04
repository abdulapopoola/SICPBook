#lang planet neil/sicp

; Pick 7 from lists
(define list1 '(1 3 (5 7) 9))
(car (cdr (car (cdr (cdr list1)))))
;; Also works
(car (cdaddr list1))
(newline)

(define list2 '((7)))
(car (car list2))
(caar list2)
(newline)

(define list3 '(1 (2 (3 (4 (5 (6 7)))))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr list3))))))))))))
(cadadadr (cadadadr (cadadr list3)))
