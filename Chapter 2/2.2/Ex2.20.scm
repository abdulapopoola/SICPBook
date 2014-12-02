#lang planet neil/sicp

(define (xor x y)
  (or (and x (not y))
	  (and y (not x))))

(define (item-same-parity item1 item2)
  (not (xor (even? item1) (even? item2))))

(define (same-parity . items)
  (define (iter values)
    (cond ((null? values) nil)
          ((item-same-parity (car values) (car items))
           (cons (car values) (iter (cdr values))))          
          (else (iter (cdr values)))))
  (iter items))

(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)