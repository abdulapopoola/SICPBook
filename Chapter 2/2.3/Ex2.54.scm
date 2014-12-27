#lang planet neil/sicp

(define (equal? a b)
  (cond ((eq? a b) true)
        ((and (pair? a) (pair? b) (equal? (car a) (car b)))
         (equal? (cdr a) (cdr b)))
        (else false)))

(equal? '(1 2 3) '(1 2 3))    ; true
(equal? '() '())              ; true
(equal? '() 'a)               ; false
(equal? '((x1 x2) (y1 y2)) '((x1 x2) (y1 y2)))    ; true
(equal? '((x1 x2) (y1 y2)) '((x1 x2 x3) (y1 y2))) ; false
(equal? '(x1 x2) 'y1)         ; false
(equal? 'abc 'abc)            ; true
(equal? 123 123)              ; true

(newline)

(equal? '(this is a list) '(this is a list))   ; true
(equal? '(this is a list) '(this (is a) list)) ; false

(equal? 'e 'r) ; false
(equal? 'w 'w) ; true

(equal? 7 12)  ; false
(equal? 3 +3)  ; true

(equal? '(23 4 (5 (72)) (14)) '(23 4 (5 (72)) (14))) ; true
(equal? '(23 4 (5 (70)) (14)) '(23 4 (5 (72)) (14))) ; false