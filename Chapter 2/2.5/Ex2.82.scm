#lang planet neil/sicp

;; check if list is empty - return not working
;; 

(define (coerce-to-type type full-list)
  (map (lambda (t) ((get-coercion type t))) full-list))

(define (coerce-full-list types-list full-list)
  (cond ((null? types-list) false)
        ((memq false
               (coerce-to-type (car types-list) full-list))
         (coerce-full-list (cdr types-list) full-list))
        (else (coerce-to-type (car types-list) full-list))))
  

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