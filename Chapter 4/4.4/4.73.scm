#lang planet neil/sicp

(define (flatten-stream stream)
  (if (stream-null? stream)
      the-empty-stream
      (interleave (stream-car stream)
                  (flatten-stream 
                   (stream-cdr stream)))))

;; If one of the streams is an infinite stream then this
;; will never stop.