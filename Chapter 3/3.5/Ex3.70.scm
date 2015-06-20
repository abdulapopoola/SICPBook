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

(define (merge-weighted s1 s2 weight)
  (cond ((stream-empty? s1) s2)
        ((stream-empty? s2) s1)
        (else
         (let* ((s1pair (stream-first s1))
               (s2pair (stream-first s2))
               (s1weight (weight (car s1pair) (cadr s1pair)))
               (s2weight (weight (car s2pair) (cadr s2pair))))
           (cond ((< s1weight s2weight)
                  (stream-cons 
                   s1pair 
                   (merge-weighted (stream-rest s1) s2 weight)))
                 ((> s1weight s2weight)
                  (stream-cons 
                   s2pair 
                   (merge-weighted s1 (stream-rest s2 weight))))
                 (else
                  (stream-cons 
                   s1pair
                   (merge-weighted (stream-rest s1) (stream-rest s2) weight))))))))

(define (weighted-pairs s t w)
  (stream-cons
   (list (stream-first s) (stream-first t))
   (merge-weighted
    (stream-map (lambda (x) 
                  (list (stream-first s) x))
                (stream-rest t))
    (weighted-pairs (stream-rest s) (stream-rest t) w)
    w)))

;; 1st task
(define first-task 
  (weighted-pairs integers integers (lambda (x y) (+ x y))))
(print-n first-task 10)

;; 2nd task
(define (divisible? dividend divisor)
  (= 0 (remainder dividend divisor)))

(define filtered-stream
  (stream-filter (lambda (i) 
                   (not (or (divisible? i 2)
                            (divisible? i 3)
                            (divisible? i 5))))))

(define second-task 
  (weighted-pairs filtered-stream filtered-stream 
                  (lambda (x y) (+ (* 2 x) (* 3 y) (* 5 x y)))))
(print-n second-task 10)
