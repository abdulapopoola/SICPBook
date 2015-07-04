#lang racket

(define (and? exp) (tagged-list? exp 'and))
(define (and-expressions exp) (cadr exp))
(define (make-and expr-sequence)
  (list 'and (sequence->exp expr-sequence)))

; To be included in eval definition
(define (eval-and-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        ((eval (first-exp exps) env)
         (eval-sequence (rest-exps exps) env))
        (else false)))

(define (or? exp) (tagged-list? exp 'or))
(define (or-expressions exp) (cadr exp))
(define (make-or expr-sequence)
  (list 'and (sequence->exp expr-sequence)))

; To be included in eval definition
(define (eval-or-sequence exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        ((eval (first-exp exps) env) true)
        (else (eval-sequence (rest-exps exps) env))))


;; As a derived implementation
(define (eval-derived-and exps)
  (if (null? exps)
      'true
      (make-if (car exps)
               (eval-derived-and (cdr exps))
               'false)))

(define (eval-derived-or exps)
  (if (null? exps)
      'false
      (make-if (car exps)
               'true
               (eval-derived-or (cdr exps)))))

; installation
;...
((and? exp) (eval (eval-derived-and exps) env))
((or? exp) (eval (eval-derived-or exps) env))