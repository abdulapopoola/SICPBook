#lang planet neil/sicp

(define x 10)
(parallel-execute 
 (lambda () (set! x (* x x)))
 (lambda () (set! x (* x x x))))

; 100 ^ 3
; 1000 ^ 2
; 10 * 1000
; 10 * 100 * 100
; 10 * 10 * 100
; 100
; 1000

(define x 10)
(define s (make-serializer))
(parallel-execute 
 (s (lambda () (set! x (* x x))))
 (s (lambda () (set! x (* x x x)))))

; 100 ^ 3
; 1000 ^ 2