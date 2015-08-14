#lang planet neil/sicp

(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4 5))
        (cooper (amb 1 2 3 4 5))
        (fletcher (amb 1 2 3 4 5))
        (miller (amb 1 2 3 4 5))
        (smith (amb 1 2 3 4 5)))
    (require (not (= baker 5)))
    (require (not (= cooper 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (> miller cooper))
    (require 
     (not (= (abs (- fletcher cooper)) 1)))
    (require
     (distinct? (list baker cooper fletcher 
                      miller smith)))    
    (list (list 'baker baker)
          (list 'cooper cooper)
          (list 'fletcher fletcher)
          (list 'miller miller)
          (list 'smith smith))))

;; The answer does not change if you re-order the restrictions however
;; it is possible to make the program faster.

;; The program as shown above will be faster since it pushes the really
;; expensive distinct call (O(N^2)) will not be called as many times.
;; Rather it'll be called only when the cheaper conditions have been met.