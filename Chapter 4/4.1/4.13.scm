#lang planet neil/sicp

(define (make-unbound! var env)
  (let* ((frame (first-frame env)))
    (define (iter vars vals)
      (cond ((null? vars)
             (error "Trying to unbound non-existent var" var))
            ((eq? var (car vars))
             (set-car! vars '()) ;;delete var from vars list is better 
             (set-car! vals '()))
            (else (iter (cdr vars) (cdr vals)))))
    (iter (frame-variables frame) (frame-values frame))))