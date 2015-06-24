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

(define (square x) (* x x))
(define (sum-square-pair pair) (+ (square (car pair))
                                (square (cadr pair))))

(define square-pairs-stream 
  (weighted-pairs integers integers sum-square-pair))

(define (sum-two-squares s)
  (let* ((first-pair (stream-first s))
         (second-pair (stream-first (stream-rest s)))
         (third-pair (stream-first (stream-rest (stream-rest s))))
         (w1 (sum-square-pair first-pair))
         (w2 (sum-square-pair second-pair))
         (w3 (sum-square-pair third-pair)))
    (if (= w1 w2 w3)
        (stream-cons 
         (list w1 first-pair second-pair third-pair)
         (sum-two-squares (stream-rest (stream-rest (stream-rest s)))))
        (sum-two-squares (stream-rest s)))))

(define numbers (sum-two-squares square-pairs-stream))
(print-n numbers 5)

;(325 (1 18) (6 17) (10 15))
;(425 (5 20) (8 19) (13 16))
;(650 (5 25) (11 23) (17 19))
;(725 (7 26) (10 25) (14 23))
;(845 (2 29) (13 26) (19 22))