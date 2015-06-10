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

(define (pairs s t)
  (stream-cons
   (list (stream-first s) (stream-first t))
   (interleave
    (stream-map (lambda (x) 
                  (list (stream-first t) x))
                (stream-rest s))
    (interleave
     (stream-map (lambda (x) 
                  (list (stream-first s) x))
                (stream-rest t))
     (pairs (stream-rest s) (stream-rest t))))))

(define (triples s t u)
  (stream-cons
   (list (stream-first s) (stream-first t) (stream-first u))
   (interleave
    (stream-map (lambda (x)
                  (list (stream-first u) x))
                (pairs (stream-rest s) (stream-rest t)))
    (triples (stream-rest s) (stream-rest t) (stream-rest u)))))

(define integer-triples (triples integer integer integer))
(define (square x) (* x x))
(define (is-pythagorean-triple? x y z)
  (= (square z)
     (+ (square x) (sqaure y))))

(define pythagorean-triple
  (stream-filter (lambda (triple)
                   (is-pythagorean-triple? (car triple)
                                           (cadr triple)
                                           (caddr triple)))
                 integer-triples))
                  

(print-n (pairs integers integers) 50)