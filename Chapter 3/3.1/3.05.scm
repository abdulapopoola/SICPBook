#lang planet neil/sicp

(define (square x) (* x x))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials 
                          cesaro-test))))
(define (cesaro-test)
   (= (gcd (random) (random)) 1))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) 
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) 
                 trials-passed))))
  (iter trials 0))

(define (estimate-integral p x1 x2 y1 y2 trials)
  (define (experiment) 
    (p (random-in-range x1 x2)
       (random-in-range y1 y2)))
  (* (- x2 x1)
     (- y2 y1)
     (monte-carlo trials experiment)))

(define (pred x y)
  (or (= (+ (* (- x 5) (- x 5)) (* (- y 7) (- y 7))) 9)
      (< (+ (* (- x 5) (- x 5)) (* (- y 7) (- y 7))) 9)))

;;test
(estimate-integral pred 2 8 4 10 500000)

(/ (* 22 9) 7)

(define (unit-circle-pred x y)
  (or (= (+ (square x) (square y)) 1)
      (< (+ (square x) (square y)) 1)))

(define pi-estimate (estimate-integral unit-circle-pred -1 1 -1 1 1000000))
pi-estimate


