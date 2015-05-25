#lang racket

(define (stream-map proc . argstreams)
  (if (stream-empty? (stream-first argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply stream-map
              (cons proc (map stream-rest argstreams)))))) 

(define (integers-starting-from n)
  (stream-cons n (integers-starting-from (+ n 1))))

(define (mul-streams s1 s2)
  (stream-map * s1 s2))

(define factorials 
  (stream-cons 1 (mul-streams factorials (integers-starting-from 2))))

(define integers (integers-starting-from 1))

(stream-first factorials)
(stream-first (stream-rest factorials))
(stream-first (stream-rest (stream-rest factorials)))
(stream-first (stream-rest (stream-rest (stream-rest factorials))))
