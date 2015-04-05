#lang planet neil/sicp

(define (make-table same-key?)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable 
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record 
                   (assoc key-2 
                          (cdr subtable))))
              (if record (cdr record) false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable 
             (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record 
                   (assoc key-2 
                          (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! 
                   subtable
                   (cons (cons key-2 value)
                         (cdr subtable)))))
            (set-cdr! 
             local-table
             (cons (list key-1
                         (cons key-2 value))
                   (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation: 
                          TABLE" m))))
    dispatch))

(define (same-key? key1 key2)
  (define tolerance 0.01)
  (if (and (number? key1) (number? key2))
      (< (abs (- key1 key2)) tolerance)
      (equal? key1 key2)))

(define tbl1 (make-table eq?))

((tbl1 'insert-proc!) 'planet 1 'Mercury)
((tbl1 'insert-proc!) 'planet 2 'Venus)
((tbl1 'insert-proc!) 'planet 3 'Earth)

((tbl1 'lookup-proc) 'planet 2.001)
