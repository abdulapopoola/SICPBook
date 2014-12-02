#lang planet neil/sicp

(define (for-each proc items)
  (cond ((null? items) true)
        (else (proc (car items))
              (for-each proc (cdr items)))))
      
(for-each (lambda (x) (newline) (display x))
         (list 57 321 88))
