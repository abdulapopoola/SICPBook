#lang planet neil/sicp
;;Needs code from 2.67

(define sample-message 
  '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(define (encode message tree)
  (if (null? message)
      '()
      (append 
       (encode-symbol (car message) 
                      tree)
       (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((member symbol (symbols (left-branch tree)))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((member symbol (symbols (right-branch tree)))
         (cons 1 (encode-symbol symbol (right-branch tree))))
        (else (error "Symbol not found in tree" symbol))))

(equal? (encode (decode sample-message sample-tree) sample-tree) sample-message)

        