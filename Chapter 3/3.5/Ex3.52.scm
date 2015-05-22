#lang planet neil/sicp

(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

(define seq 
  (stream-map 
   accum 
   (stream-enumerate-interval 1 20)))

(define y (stream-filter even? seq))

(define z 
  (stream-filter 
   (lambda (x) 
     (= (remainder x 5) 0)) seq))

(stream-ref y 7)
; 6 10 28 36 66 78 120

(display-stream z)
; 190 210

; Memoization causes already evaluated expressions not to be run anymore
; thus it continues from 120
; Without memoization, it'll print out the full list of numbers in the 
; sum series that are divisible by 5.
; i.e. 10 15 45 55 105 120 190 210