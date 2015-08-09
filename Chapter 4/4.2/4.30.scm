#lang planet neil/sicp

(define (eval-sequence exps env)
  (cond ((last-exp? exps) 
         (eval (first-exp exps) env))
        (else 
         (actual-value (first-exp exps) 
                       env)
         (eval-sequence (rest-exps exps) 
                        env))))


;; 1
;;    Ben Bitdidle's procedure works because display is a primitive
;;    which will force the expressions to have values


;; 2
(define (p1 x)
  (set! x (cons x '(2))) x)
; (p1 1) -> (1 2)

(define (p2 x)
  (define (p e) e x)
  (p (set! x (cons x '(2)))))
; (p2 1) -> 1; because the e is evaluated (sets x to (1 2)) and then
; its value discarded (since it is not yet evaluated) so x is still 1 in the environment of the p2
; function

;; With Cy's changes both values will be the same since the actual-value
;; call forces the thunk to be evaluated.

;; 3
;; Yes, because begin is a primitive and forces thunk evaluation

;; 4
;; I prefer Cy's approach because it gives consistent results and that
;; helps a lot when writing programs using a language. Ideally, there 
;; should be no surprises and users shouldn't have to learn quirks