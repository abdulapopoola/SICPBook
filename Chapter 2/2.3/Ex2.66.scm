#lang planet neil/sicp

(define (lookup key records)
  (cond ((null? records) false)
        ((= key (entry records))
         (entry records))
        ((< key (entry records))
         (lookup key (left-branch records)))
        (else 
         (lookup key (right-branch records)))))