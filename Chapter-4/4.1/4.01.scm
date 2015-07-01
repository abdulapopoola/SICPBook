#lang planet neil/sicp

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((left (eval (first-operand exps) env)))
        (cons left
            (list-of-values (rest-operands exps) env)))))
            
; right-to-left evaluation            
(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (let ((right (list-of-values (rest-operand exps) env)))
        (cons (eval (first-operand exps) env)
              right))))
