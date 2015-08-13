#lang planet neil/sicp

;; It would not work since there is no upper bound on the kth value
;; thus, it would search forever (tries to go through the list of
;; integer values). We need some upper bound so that the backtracking
;; can stop successfully.
(define (a-pythagorean-triple-from low)
  (let ((i (an-integer-starting-from low)))
    (let ((j (an-integer-starting-from low)))
      (let ((k (an-integer-starting-from low)))
        (require (= (+ (* i i) (* j j)) 
                    (* k k)))
        (list i j k)))))

;; Solving the maths equation k^2 = i^2 + j^2
;; We get k = sqrt(i^2 + j^2)
;; thus if we know i (get it from an-integer-starting-from)
;; then we can look for j values that make the initial
;; equation give a perfect square.
;; This is based on the fact that i^2 + i^2 can not be a
;; perfect square; however if there are numbers in the 
;; range i -> i^2 can be checked

(define (a-pythagorean-triple-from low)
  (let ((i (an-integer-starting-from low)))
    (let ((square-i-value (* i i)))
      (let ((j (an-integer-between i square-i-value)))
        (let ((k (sqrt (+ (* i i) (* j j)))))
          (require (integer? k))
          (list i j k))))))


