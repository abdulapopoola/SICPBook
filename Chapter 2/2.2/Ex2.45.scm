#lang planet neil/sicp

(define (split placement1 placement2)
  (define (splitter painter n)
    (if (= n 0)
      painter
      (let ((smaller (splitter painter (- n 1))))
        (placement1 painter 
                (placement2 smaller smaller)))))
  (lambda (painter n) (splitter painter n)))

(define right-split (split beside below))
