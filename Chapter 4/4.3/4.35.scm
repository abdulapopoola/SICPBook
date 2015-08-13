#lang planet neil/sicp

(define (an-integer-between low high)
  (define (an-integer-starting-from n)
    (require (and (> n low)
                  (< n high)))
    (amb n (an-integer-starting-from (+ n 1))))
  (an-integer-starting-from (+ low 1)))

;; More elegant solution from Eli's http://eli.thegreenplace.net/2007/12/28/sicp-section-431
(define (an-integer-between low high)
  (require (<= low high))
  (amb low (an-integer-between (+ low 1) high)))

(define (a-pythagorean-triple-between low high)
  (let ((i (an-integer-between low high)))
    (let ((j (an-integer-between i high)))
      (let ((k (an-integer-between j high)))
        (require (= (+ (* i i) (* j j)) 
                    (* k k)))
        (list i j k)))))