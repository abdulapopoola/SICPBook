#lang racket

(define (expand num den radix)
  (stream-cons
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) 
           den 
           radix)))

(define first (expand 1 7 10))
;1 4 2 - decimal half of pi?

(define second (expand 3 8 10))
; 3 7 5

(define (print-n stream n)
  (newline)
  (if (= n 0)
      (display "Done")
      (begin (display (stream-first stream))
             (print-n (stream-rest stream) (- n 1)))))

(print-n first 3)
(print-n second 3)
