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

(define (solve-2nd f dt y0 dy0)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (stream-map f dy y))
  y)

(stream-ref
 (solve-2nd (λ (dy y) (+ (* -2 dy) (* -1 y)))
            0.0001
            1
            -1)
 10000)