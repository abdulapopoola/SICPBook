#lang racket

(define (make-zero-crossings 
         input-stream last-value last-avg)
  (let ((avpt 
         (/ (+ (stream-first input-stream) 
               last-value) 
            2)))
    (stream-cons 
     (sign-change-detector avpt last-avg)
     (make-zero-crossings 
      (stream-rest input-stream)
      (stream-first input-stream)
      avpt))))