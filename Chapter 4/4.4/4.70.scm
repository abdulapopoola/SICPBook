#lang planet neil/sicp

(define (add-assertion! assertion)
  (store-assertion-in-index assertion)
  (set! THE-ASSERTIONS
        (cons-stream assertion 
                     THE-ASSERTIONS))
  'ok)

;; This version would cause an infinite recursion because
;; cons-stream does not evaluate its second argument immediately and thus
;; THE-ASSERTIONS will point to itself. i.e. 
;; -> a = cons-stream(b a) and this can cause infinite loops under the 
;; right conditions.

;; Using a let triggers an evaluation and thus cons-stream gets an already
;; evaluated different value.