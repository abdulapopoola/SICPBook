#lang racket
(require racket/include)
(include "../4.1.helpers.rkt")

(define (let? exp) (tagged-list? exp 'let))
(define (let-expressions exp) (cadr exp))
(define (let-variables exp) (map car (let-expressions exp)))
(define (let-params exp) (map cadr (let-expressions exp)))
(define (let-body exp) (caddr exp))

(define (named-let? exp)
  (variable? (cadr exp)))

(define (named-let-name exp) (cadr exp))
(define (named-let-bindings exp) (caddr exp))
(define (named-let-body exp) (cdddr exp))

(define (let->combination exp)
  (if (named-let? exp)
      (create-named-let (named-let-name exp)
                        (named-let-bindings exp)
                        (named-let-body exp))
      (make-procedure 
          (let-variables exp)
          (let-body exp)
         (let-params exp))))

(define (create-named-let name bindings body)
  (sequence->exp
   (list (cons 'define
               (cons name (let-variables bindings) body))
         (cons name (let-params bindings)))))

