#lang planet neil/sicp

(define (simple-stream-flatmap proc s)
  (simple-flatten (stream-map proc s)))

(define (simple-flatten stream)
  (stream-map stream-car
              (stream-filter
               (lambda (val) (not (stream-null? val))) 
               stream)))

;; Should have no effect on the system.