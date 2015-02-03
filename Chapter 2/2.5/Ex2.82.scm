#lang planet neil/sicp


(define (coerce-to-type type full-list)
  (map (lambda (t) 
         (let ((coerce-op (get-coercion type t)))
           (if coerce-op
             (coerce-op t)
             false))
       full-list)))

(define (coerce-full-list types-list full-list)
  (cond ((null? types-list) false)
        ((memq false
               (coerce-to-type (car types-list) full-list))
         (coerce-full-list (cdr types-list) full-list))
        (else (coerce-to-type (car types-list) full-list))))
  

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags))
          (coerced-list (coerce-full-list type-tags args)))
      (cond (proc (apply proc (map contents args)))
            (coerced-list (apply-generic op coerced-list))
            (else (error "No method for these types"
                         (list op type-tags)))))))

;;NOT TESTED!!!