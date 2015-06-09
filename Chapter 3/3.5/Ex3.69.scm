#lang racket

(define (print-n stream n)
  (newline)
  (if (= n 0)
      (display "Done")
      (begin (display (stream-first stream))
             (print-n (stream-rest stream) (- n 1)))))

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define (interleave s1 s2)
  (if (stream-empty? s1)
      s2
      (stream-cons 
       (stream-first s1)
       (interleave s2 (stream-rest s1)))))

(print-n (triples integers integers integers) 50)