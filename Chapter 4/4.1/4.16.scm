#lang racket
(require racket/include)
(include "../4.1.helpers.rkt")

(define (find-val-in-frame var frame)
  (define (iter vars vals)
    (cond ((null? vars) false)
          ((eq? var (car vars)) vals)
          (else (iter (cdr vars) (cdr vals)))))
  (iter (frame-variables frame) (frame-values frame)))

(define (is-unassigned val)
  (and (symbol? val)
       (eq? val "*unassigned*")))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let* ((frame (first-frame env))
               (frame-val (find-val-in-frame var frame)))
          (if frame-val
              (if (is-unassigned (car frame-val))
                  (error "Unassigned value usage")
                  (car frame-val))
              (env-loop (enclosing-environment env))))))
  (env-loop env))

;; grab procedure, grab body, walk through
;; if definition -> convert to lambda let
;; filter all defs into new list
;; define new lambda
;; set all def vars into let unassigned
;; set var vals to their valus
;; use remaining body

(define (scan-out-defines proc-body)
  (let* ((let-list '())
           (set-list '())
           (non-define-exprs '()))
    (define (converter body-list)   
      (cond ((empty? body-list) '())
            ((definition? (car body-list))
             (let ((def-var (definition-variable (car body-list)))
                   (def-val (definition-value (car body-list))))
               (set! let-list (cons (list def-var "*unassigned") let-list))
               (set! set-list (cons (cons 'set (list def-var def-val) set-list)))))
            (else 
             (set! non-define-exprs (append non-define-exprs (list (car body-list))))))
      (if (not (empty? body-list))
          (converter (cdr body-list))))
    (converter proc-body)
    (if (empty? let-list)
        proc-body
        (list (append (list 'let let-list) (append set-list non-define-exprs))))))

(define (make-procedure parameters body env)
  (list 'procedure parameters (scan-out-defines body) env))

;; Installing in make-procedure makes it more efficient as it only gets called once
;; whereas procedure-body gets invoked a lot of times so it is less efficient
      