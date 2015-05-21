#lang planet neil/sicp

(define (show x)
  (display-line x)
  x)

(define x 
  (stream-map 
   show 
   (stream-enumerate-interval 0 10)))

(stream-ref x 5)
; 1 2 3 4 5

(stream-ref x 7)
; 6 7
