#lang racket

(define (print-n stream n)
  (newline)
  (if (= n 0)
      (display "Done")
      (begin (display (stream-first stream))
             (print-n (stream-rest stream) (- n 1)))))

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

(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)

(print-n (solve (lambda (y) y) 1 0.001) 1000)