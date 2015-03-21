#lang planet neil/sicp

(define (count-pairs x)
  (let ((pairs '()))
    (define (count-unique lst)
      (cond ((not (pair? lst)) 0)
            ((memq lst pairs) 0)   
            (else (set! pairs (append pairs lst))
                  (+ (count-unique (car lst))
                     (count-unique (cdr lst))
                     1))))
    (count-unique x)))

(define (cyclic? lst)
  (let ((pair-count (count-pairs lst)))
    (define (walk-list count pairs-list) 
      (cond ((and (zero? count) (null? pairs-list)) false)
            ((zero? count) true)
            (else (walk-list (- count 1) (cdr pairs-list)))))
    (walk-list pair-count lst)))

(define p1 1)
(define p2 2)
(define p3 3)

(define three (list p1 p2 p3)); (cons 1 2) (cons 3 4) (cons 5 6)))
(count-pairs three)
(cyclic? three)


(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c 'd)))
(define w (append '(g h j) z))

(count-pairs z)