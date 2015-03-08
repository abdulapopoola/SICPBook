#lang planet neil/sicp

(define (identity x) x)

(define f
  (let ((first-call-eval false)
        (call-count 0))
    (lambda (arg)
      (set! call-count (+ call-count 1))
      (cond ((= call-count 2) 
             (set! call-count 0)
             (set! first-call-eval false)))
      (cond (first-call-eval 0)
            ((set! first-call-eval true)
             arg)))))
      

(+ (f 0) (f 1)) ; 1
(+ (f 1) (f 0)) ; 0
(+ (f 0) (f 1)) ; 1