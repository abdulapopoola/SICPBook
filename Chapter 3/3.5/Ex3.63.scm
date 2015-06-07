#lang racket

(define (sqrt-stream x)
  (cons-stream 
   1.0
   (stream-map (lambda (guess)
                 (sqrt-improve guess x))
               (sqrt-stream x))))

;;versus the one below, every iteration of the loop
;; builds a new stream while in the example below
;; the stream is only created once.

;;Without memoization, it'll be same for both parties as
;; there is no 'remembering' already seen calculations but the
;; old version only generates one stream while the sqrt-stream 
;; version will keep creating streams


(define (sqrt-stream x)
  (define guesses
    (cons-stream 
     1.0 (stream-map
          (lambda (guess)
            (sqrt-improve guess x))
          guesses)))
  guesses)