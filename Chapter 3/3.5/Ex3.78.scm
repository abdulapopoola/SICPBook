#lang racket

(define (stream-map proc . argstreams)
  (if (stream-empty? (car argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply stream-map
              (cons proc 
                    (map stream-rest 
                         argstreams))))))

(define (add-streams s1 s2)
  (stream-map + s1 s2))

(define (scale-stream stream factor)
  (stream-map
   (lambda (x) (* x factor))
   stream))

(define (integral delayed-integrand initial-value dt)
  (stream-cons 
   initial-value
   (let ((integrand 
            (force delayed-integrand)))
     (if (stream-empty? integrand)
         empty-stream
         (integral 
          (stream-rest integrand)
          (+ (* dt (stream-first integrand))
             initial-value)
          dt)))))

(define (solve-2nd a b dt y0 dy0)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral 
              (delay (add-streams (scale-stream dy a)
                           (scale-stream y b)))
              dy0 dt))
  y)

(stream-ref (solve-2nd -2 -1 0.0001 1 -1) 10000)