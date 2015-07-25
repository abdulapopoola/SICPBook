#lang racket

(define (find-val-in-frame var frame)
  (define (iter vars vals)
    (cond ((null? vars) false)
          ((eq? var (car vars)) vals)
          (else (iter (cdr vars) (cdr vals)))))
  (iter (frame-variables frame) (frame-values frame)))

(define (define-variable! var val env)
  (let* ((frame (first-frame env))
         (frame-val (find-val-in-frame var frame)))
    (if frame-val
        (set-car! frame-val val)
        (add-binding-to-frame! var val frame))))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var)
        (let* ((frame (first-frame env))
               (frame-val (find-val-in-frame var frame)))
          (if frame-val
              (set-car! frame-val val)
              (env-loop (enclosing-environment env))))))
  (env-loop env))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let* ((frame (first-frame env))
               (frame-val (find-val-in-frame var frame)))
          (if frame-val
              (car frame-val)
              (env-loop (enclosing-environment env))))))
  (env-loop env))