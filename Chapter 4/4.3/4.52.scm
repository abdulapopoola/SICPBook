#lang racket

(define (analyze-if-fail exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp))))
    (lambda (env succeed fail)
      (pproc env 
             (lambda (pred-value fail2)
               (if (true? pred-value)
                   pred-value
                   (fail)))
             (lambda () (cproc env succeed fail))))))