#lang racket

(define (expand-clauses clauses)
  (if (null? clauses)
      'false     ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp 
                 (cond-actions first))
                (error "ELSE clause isn't 
                        last: COND->IF"
                       clauses))
            (make-if (cond-predicate first)
                     (sequence->exp-add 
                      (cond-predicate first)
                      (cond-actions first))
                     (expand-clauses 
                      rest))))))

(define (sequence->exp-add predicate action)
  (if (eq? (car action) '=>)
      (list (cadr action) predicate)
      (sequence->exp action)))