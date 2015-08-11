#lang planet neil/sicp

;;Influence: https://wqzhang.wordpress.com/2010/04/21/sicp-exercise-4-33/

(define (eval-quote exp env)
  (let ((quoted (text-of-quotation exp)))
    (if (pair? quoted)
        (eval (list 'cons (list 'quote (car text))
                    (list 'quote (cdr text)))
              env)
        quoted)))
  
