#lang planet neil/sicp

(define (cont-frac n d k)
  (define (iter n d i)
    (if (= k i)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (iter n d (+ i 1))))))
  (iter n d 1))

(define (d i)
  (if (zero? (remainder (+ 1 i) 3))
      (* 2 (/ (+ i 1) 3))
      1))

(define (e depth)
  (+ 2 (cont-frac 
        (lambda (i) 1.0)
        d
        depth)))

(e 12)

;; The series is     1 2 1 1 4 1 1 6 1 1  8  1  1   
;; The indices are   1 2 3 4 5 6 7 8 9 10 11 12 13

;; Offsetting the original series by adding one produces the new series below
;; Original series is     1 2 1 1 4 1 1 6 ...
;; Offset series          2 3 4 5 6 7 8 9 ...

;; The multiples of 3 are the non 1 values and can be gotten
;; by dividing the 'shifted' value by 3 and multiplying by 2