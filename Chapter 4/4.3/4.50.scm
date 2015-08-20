#lang racket

(define (analyze-ramb exp)
  (let ((cprocs
         (map analyze (amb-choices exp))))
    (lambda (env succeed fail)
      (define (try-next choices)
        (if (null? choices)
            (fail)
            ((random-item choices) 
             env
             succeed
             (lambda ()
               (try-next (cdr choices))))))
      (try-next cprocs))))

(define (random-item lst)
  (item-at (random (length lst)) lst))

(define (item-at index lst)
  (if (= index 0)
      (car lst)
      (item-at (- index 1) lst)))