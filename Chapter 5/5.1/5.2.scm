#lang planet neil/sicp

(define (factorial n)
  (define (iter product counter)
    (if (> counter n)
        product
        (iter (* counter product)
              (+ counter 1))))
  (iter 1 1))

(controller
 test-n
   (test (op >) (reg counter) (reg n))
   (branch (label fact-done))
   (assign product (op *) (reg product) (reg counter))
   (assign counter (op +) (reg counter) (const 1))
   (goto (label test-n))
 fact-done)