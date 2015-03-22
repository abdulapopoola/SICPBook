#lang planet neil/sicp

; if cdr x and 

(define (cyclic? lst)
  (define (iter move-slow-pointer slow-pointer fast-pointer)
    (cond ((null? fast-pointer) false)
          ((eq? fast-pointer slow-pointer) true)
          (else (iter (not move-slow-pointer)
                      (if move-slow-pointer
                          (cdr slow-pointer)
                          slow-pointer)
                      (cdr fast-pointer)))))
  (iter true lst (cdr lst))) 

(define three (list 1 2 3))
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

(cyclic? z)
