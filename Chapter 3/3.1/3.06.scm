#lang planet neil/sicp

(define (rand)
  (let ((x random-init))
    (define (generate) 
      (set! x (rand-update x))
      x)
    (define (reset new-value)
      (set! x new-value))
    (define (dispatch m)
      (cond ((eq? m 'generate) generate)
            ((eq? m 'reset) reset)
            (else (error "Unknown request: random" m))))
      dispatch))