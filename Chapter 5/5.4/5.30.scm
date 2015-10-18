(define (error-info msg val)
  (list 'error-info msg val))
(define (error-info? obj)
  (tagged-list? obj 'error-info))
(define (error-msg obj)
  (cadr obj))
(define (error-val obj)
  (caddr obj))

(define (safe-lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars)) (car vals))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error-info "Unbound variable" var) ;; CHANGED
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))

(define (safe-car val)
  (cond ((null? val) (error-info "car into empty list" val))
        ((not (pair? val)) (error-info "car into non-pair value" val))
        (else (car val))))

(define (safe-divide dividend divisor)
  (if (zero? divisor)
      (error-info "Attempting to divide by zero" (cons dividend divisor))
      (/ dividend divisor)))

;; INSTALL into primitive procedures
(define primitive-procedures
  (list (list 'car safe-car)
        (list '/ safe-divide)))

(define eceval-operations
  (list         
        ; install new safe operators    
        (list 'lookup-variable-value safe-lookup-variable-value)
        (list 'error-info error-info)
        (list 'error-info? error-info?)
        (list 'error-msg error-msg)))

;; RELEVANT changed sections ONLY; change these where they are used and 
;; everything should work fine
ev-variable
  (assign val (op lookup-variable-value) (reg exp) (reg env))
  (test (op error-info?) (reg val))
  (branch (label signal-error))
  (goto (reg continue))
  
primitive-apply
  (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
  (test (op error-info?) (reg val))
  (branch (label signal-error))
  (restore continue)
  (goto (reg continue))
  
signal-error
  (assign val (op error-msg) (reg val))
  (goto (label done))
  
done ;; <- LAST label in eceval machine
