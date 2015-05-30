#lang racket

(define (print-n stream n)
  (newline)
  (if (= n 0)
      (display "Done")
      (begin (display (stream-first stream))
             (print-n (stream-rest stream) (- n 1)))))

(define (stream-map proc . argstreams)
  (if (stream-empty? (stream-first argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply stream-map
              (cons proc (map stream-rest argstreams)))))) 

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (partial-sums S)
  (stream-cons (stream-first S)
               (add-streams (stream-rest S)
                            (partial-sums S))))

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

(define sample (partial-sums integers))
(print-n sample 5)