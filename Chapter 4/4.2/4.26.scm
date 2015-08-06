#lang racket

(define (unless? exp) (tagged-list? exp 'unless))
(define (unless-clauses exp) (cdr exp))
(define (unless-condition clauses) (car clauses))
(define (unless-usual clauses) (cadr clauses))
(define (unless-exception clauses) (caddr clauses))

(define (unless->if exp)
  (let clauses ((unless-clauses exp))
    (make-if (unless-condition clauses)
             (unless-exception clauses)
             (unless-usual clauses))))