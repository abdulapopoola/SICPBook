#lang planet neil/sicp

;; Need to change to pass in table in search to lookup/insert procedures

(define (make-table)
  (define (lookup-table table key)
    (assoc key (cdr table)))
  (define (walk-down-tables table lst)
    (cond ((= (length lst) 1)
           (lookup-table table (car lst)))
          (else (walk-down-tables 
                 (lookup-table table (car lst))
                 (cdr lst)))))
  (define (create-linear-chain lst val)
    (if (null? lst)
        val
        (cons (car lst)
              (list (create-linear-chain (cdr lst) val)))))
  (define (insert-into-tables table lst val)
    (let ((record (lookup-table table (car lst))))
      (if (not record)
          (set-cdr! table
                    (cons (create-linear-chain lst val)
                          (cdr table)))
          (insert-into-tables record (cdr lst) val))))
  (let ((local-table (list '*table*)))
    (define (lookup key-list) 
      (let ((record (walk-down-tables local-table key-list)))
        (if record
            (cdr record)
            false)))
    (define (insert! key-list value)
      (insert-into-tables local-table key-list value)
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: 
                          TABLE" m))))
    dispatch))

(define tbl1 (make-table))

((tbl1 'insert-proc!) (list 'planet 1) 'Mercury)
((tbl1 'insert-proc!) (list 'planet 2) 'Venus)
((tbl1 'insert-proc!) (list 'planet 3) 'Earth)

(newline)
((tbl1 'lookup-proc) (list 'planet 1)) ;Mercury
((tbl1 'lookup-proc) (list 'planet 2)) ;Venus
((tbl1 'lookup-proc) (list 'planet 3)) ;Earth
