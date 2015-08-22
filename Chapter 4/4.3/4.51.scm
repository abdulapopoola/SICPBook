(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze 
                (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
            (lambda (val fail2)
                (set-variable-value! var val env)
                (succeed 'ok fail2)) 
            fail))))
