#lang planet neil/sicp

;; Looks like a spy function

(define (make-monitored proc)
  (let ((counter 0))
        (define (dispatch m)
          (cond ((eq? m 'how-many-calls?) counter)
                ((eq? m 'reset) 
                 (set! counter 0))
                (else (set! counter (+ counter 1))
                      (proc m))))
        dispatch))

(define s (make-monitored sqrt))

(s 100)
;10

(s 9)
;3 

(s 'how-many-calls?)
;2

(s 'reset)

(s 'how-many-calls?)
; 0