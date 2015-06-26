#lang racket

(define (smooth s)
  (let* ((first-element (stream-first s))
         (second-element (stream-first (stream-rest s)))
         (avg (/ (+ first-element second-element) 2)))
    (stream-cons
     avg
     (smooth (stream-rest s)))))
    
(define zero-crossings
  (stream-map sign-change-detector 
              (smooth sense-data )
              (stream-cons 0 (smooth sense-data))))