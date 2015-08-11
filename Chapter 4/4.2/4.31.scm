;;Not tested but should work.
#lang planet neil/sicp

(define (lazy-thunk? obj)
  (tagged-list? obj 'lazy))

(define (lazy-memo-thunk? obj)
  (tagged-list? obj 'lazy-memo))

(define (actual-value exp env)
  (force-it (eval exp env)))

(define (force-it obj)
  (cond ((lazy-thunk? obj)
         (actual-value (thunk-exp obj) 
                       (thunk-env obj)))
        ((lazy-memo-thunk? obj)
         (let ((result
                (actual-value 
                 (thunk-exp obj)
                 (thunk-env obj))))
           (set-car! obj 'evaluated-thunk)
           ;; replace exp with its value:
           (set-car! (cdr obj) result) 
           ;; forget unneeded env:
           (set-cdr! (cdr obj) '()) 
           result))
        ((evaluated-thunk? obj)
         (thunk-value obj))
        (else obj)))

;; force it should pick up memo or not flag

(define (delay-it exp env)
  (cond ((and (pair? exp) (eq? (cadr exp) 'lazy))
         (list 'lazy (car exp) env))
        ((and (pair? exp) (eq? (cadr exp) 'lazy-memo))
         (list 'lazy-memo (car exp) env))
        (else
         (actual-value exp env))))
 
        