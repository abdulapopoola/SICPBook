#lang planet neil/sicp

;; 1.
;; A never-ending loop occurs since apply-generic will always be called
;; with 'complex 'complex params. This will in turn always trigger the 
;; coercion call and return exactly the same params.


;; 2.
;; It works fine if the 'proc' operation exists in its lookup table, however
;; if it does not find a matching operation, then it will try to coerce values
;; to their original values. E.g. 'scheme-number 'scheme-number params will be 
;; passed to the get-coercion calls.

;; 3.
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags)))
                (if (eq? type1 type2)
                    (error "Operation not found in table for matching types"
                           (list op type-tags))
                    (let ((a1 (car args))
                          (a2 (cadr args))
                          (t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2
                         (apply-generic op (t1->t2 a1) a2))
                        (t2->t1 
                         (apply-generic op a1 (t2->t1 a2)))
                        (else
                         (error "No method for these types"
                          (list op type-tags))))))
              (error "No method for these types"
               (list op type-tags))))))))