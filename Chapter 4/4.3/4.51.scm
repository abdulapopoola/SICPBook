#lang planet neil/sicp

(define (permanent-set exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze 
                (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
            (lambda (val fail2)
                (set-variable-value! var val env)
                (succeed 'ok fail2)) 
            fail))))


; count would be 1 since it always backtracks after a failure