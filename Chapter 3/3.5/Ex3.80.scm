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

(define (RLC R L C dt)
  (lambda (vC0 iL0)
    (define vC (integral (delay dv) vC0 dt))
    (define iL (integral (delay di) iL0 dt))
    (define dv (scale-stream iL (/ -1 C)))
    (define di (add-streams (scale-stream iL (- (/ R L)))
                            (scale-stream vC (/ 1 L))))
    (stream-map (lambda (x1 x2)
                  (cons x1 x2))
                vC iL)))

(define (print-n stream n)
  (newline)
  (if (= n 0)
      (display "Done")
      (begin (display (stream-first stream))
             (print-n (stream-rest stream) (- n 1)))))

(print-n ((RLC 1 1 0.2 0.1) 10 0) 36)
