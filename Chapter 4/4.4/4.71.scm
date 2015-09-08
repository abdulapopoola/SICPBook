#lang planet neil/sicp

(define (simple-query 
         query-pattern frame-stream)
  (stream-flatmap
   (lambda (frame)
     (stream-append
      (find-assertions query-pattern frame)
      (apply-rules query-pattern frame)))
   frame-stream))

(define (disjoin disjuncts frame-stream)
  (if (empty-disjunction? disjuncts)
      the-empty-stream
      (interleave
       (qeval (first-disjunct disjuncts)
              frame-stream)
       (disjoin (rest-disjuncts disjuncts)
                frame-stream))))

;; Without the delay the apply-rules function will be immediately 
;; invoked and rules containing infinite loops will get stuck.

;; With the delay version, there is no stack overflow as the delay 
;; protects against this.

;; a failing query is 
;; (test x)
;; (rule (test ?x) (test ?x))