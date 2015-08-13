#lang planet neil/sicp

(define (a-pythagorean-triple-between low high)
  (let ((i (an-integer-between low high))
        (hsq (* high high)))
    (let ((j (an-integer-between i high)))
      (let ((ksq (+ (* i i) (* j j))))
        (require (>= hsq ksq))
        (let ((k (sqrt ksq)))
          (require (integer? k))
          (list i j k))))))

;; Yes this is more efficient
;; 1. It doesn't try to compute every value of k between low and high, rather
;;    it checks if the square root is a valid integer
;; 2. Numbers that fall outside the range are ignored (i.e. hsq > ksq)