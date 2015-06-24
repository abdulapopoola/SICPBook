#lang racket

(define (integral integrand initial-value dt)
  (define int
    (stream-cons 
     initial-value
     (add-streams (scale-stream integrand dt)
                  int)))
  int)

(define (RC R C dt)
  (define (proc current initial-voltage)
    (define integral-stream
      (integral s initial-voltage dt))
     (add-streams (scale-stream current R)
                  (scale-stream integral-stream (/ 1 C))))
  proc)
     
    