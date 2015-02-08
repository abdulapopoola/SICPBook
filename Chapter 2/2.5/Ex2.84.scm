#lang planet neil/sicp

(define type-tower '(integer rational real complex))

(define (raise val)
  (define (do-raise types)
    (cond ((null? types)
           (error "Type does not exist in type tower"
                  (list val type-tower)))
          ((eq? (type-tag val) (car types))
           (if (null? (cdr types))
               val
               (let ((raise-operator (get-coercion (type-tag val)
                                                   (cadr types))))
                 (if raise-operator
                     (raise-operator (contents val))
                     (error "No coercion operator exists for these types"
                            (list (type-tag val) (cadr types)))))))
          (else (do-raise (cdr types)))))
  (do-raise type-tower))

(define (raise-to-type val type)
  (if (eq? (type-tag val) type)
      val
      (raise-to-type (raise val) type)))

(define (highest-type types-list)
  (define (find-top-type types types-list)
    (if (memq (car types) types-list)
        (car types)
        (find-top-type (cdr types) types-list)))
  (find-top-type (reverse type-tower) types-list))

(define (coerce-full-list types-list full-list)
  (define top-type (highest-type types-list))
  (cond ((null? types-list) false)
        (else (map (lambda (t)
                     (raise-to-type t top-type))
                   full-list))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags))
          (coerced-list (coerce-full-list type-tags args)))
      (cond (proc (apply proc (map contents args)))
            (coerced-list (apply-generic op coerced-list))
            (else (error "No method for these types"
                         (list op type-tags)))))))
