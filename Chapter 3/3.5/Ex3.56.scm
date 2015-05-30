#lang racket

(define (stream-map proc . argstreams)
  (if (stream-empty? (stream-first argstreams))
      empty-stream
      (stream-cons
       (apply proc (map stream-first argstreams))
       (apply stream-map
              (cons proc (map stream-rest argstreams)))))) 

(define (scale-stream stream factor)
  (stream-map
   (lambda (x) (* x factor))
   stream))

(define (merge s1 s2)
  (cond ((stream-empty? s1) s2)
        ((stream-empty? s2) s1)
        (else
         (let ((s1car (stream-first s1))
               (s2car (stream-first s2)))
           (cond ((< s1car s2car)
                  (stream-cons 
                   s1car 
                   (merge (stream-rest s1) 
                          s2)))
                 ((> s1car s2car)
                  (stream-cons 
                   s2car 
                   (merge s1 
                          (stream-rest s2))))
                 (else
                  (stream-cons 
                   s1car
                   (merge 
                    (stream-rest s1)
                    (stream-rest s2)))))))))

(define S (stream-cons 1 (merge (scale-stream S 2)
                                (merge (scale-stream S 3)
                                       (scale-stream S 5)))))

(define (print-n stream n)
  (newline)
  (if (= n 0)
      (display "Done")
      (begin (display (stream-first stream))
             (print-n (stream-rest stream) (- n 1)))))

(print-n S 15000000000); very fast and almost instantenous!