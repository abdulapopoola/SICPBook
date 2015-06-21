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
               (s1weight (weight s1pair))
               (s2weight (weight s2pair)))
           (cond ((< s1weight s2weight)
                  (stream-cons 
                   s1pair 
                   (merge-weighted (stream-rest s1) s2 weight)))
                 ((> s1weight s2weight)
                  (stream-cons 
                   s2pair 
                   (merge-weighted s1 (stream-rest s2) weight)))
                 (else
                  (stream-cons 
                   s1pair
                   (stream-cons s2pair
                                (merge-weighted (stream-rest s1) (stream-rest s2) weight)))))))))

(define (weighted-pairs s t weight)
  (stream-cons
   (list (stream-first s) (stream-first t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-first s) x))
                (stream-rest t))
    (weighted-pairs (stream-rest s) (stream-rest t) weight)
    weight)))

(define (cube x) (* x x x))
(define (sum-cube-pair pair) (+ (cube (car pair))
                                (cube (cadr pair))))

;; 1st task
(define cube-pairs-stream 
  (weighted-pairs integers integers sum-cube-pair))

(define (ramanujan-numbers s)
  (let* ((first-pair (stream-first s))
         (second-pair (stream-first (stream-rest s)))
         (w1 (sum-cube-pair first-pair))
         (w2 (sum-cube-pair second-pair)))
    (if (= w1 w2)
        (stream-cons 
         (list w1 first-pair second-pair)
         (ramanujan-numbers (stream-rest (stream-rest s))))
        (ramanujan-numbers (stream-rest s)))))

(define r-numbers (ramanujan-numbers cube-pairs-stream))
(print-n r-numbers 5)

;(1729 (1 12) (9 10))
;(4104 (2 16) (9 15))
;(13832 (2 24) (18 20))
;(20683 (10 27) (19 24))
;(32832 (4 32) (18 30))