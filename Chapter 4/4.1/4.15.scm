#lang planet neil/sicp

;; This is the halting problem

(define (run-forever)
  (run-forever))

(define (try p)
  (if (halts? p p)
      (run-forever)
      'halted))

;; If the try program halts, then it'll return tru
;; however the if branch will now execute run-forever.
;; Thus the halts program will still execute forever.

;; On the other hand, if the try program does not halt
;; then the program will not even execute any of the
;; branches since it'll run infinitely