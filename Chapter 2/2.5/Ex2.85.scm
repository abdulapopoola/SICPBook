#lang planet neil/sicp
;; INSTALLATION
;; Integer number package
;; Internal implementation
(define (rational->integer rat)
  (make-integer (round (/ (numer rat) (denom rat)))))

;; External interface
(put-coercion 'rational 'integer rational->integer)

;; Rational number package
;; Internal procedure
(define (real->rational real)
  (make-rational (inexact-exact (numerator real))
                 (inexact-exact (denominator real))))
                                
;; External interface
(put-coercion 'real 'rational real->rational)

;; Real number package
;; Internal procedure
(define (complex->real complex)
  (make-real (complex-real-part complex)))

;; External interface
(put-coercion 'complex 'real real->complex)

(define type-tower '(integer rational real complex))

(define (project val)
  (let ((val-type-tower (memq (type-tag val) (reverse type-tower))))
    (cond ((not (val-type-tower))
           (error "Unknown type; not found in tower" (type-tag val)))
          ((null? (cdr val-type-tower)) val)
          (else 
           (let ((lower-operator
                  (get-lower (type-tag val) (cdr val-type-tower))))
                 (if lower-operator
                     (lower-operator (contents val))
                     (error "No lower operator exists for these types"
                            (list (type-tag val) (cdr val-type-tower)))))))))

;; Drop can also be achieved by passing in a reversed tower to the raise operator
;; in Ex2.84.
  
(define (drop val)
  (let ((dropped (project val))
        (raised (raise dropped)))
    (if (and (not (eq? (type-tag val) (type-tag dropped)))
             (eq? val raised))
        (drop dropped)
        val)))

;; apply-generic should simplify results; copying from 2.84
(define (apply-generic op . args)
  (define (solve)
    (let ((type-tags (map type-tag args)))
      (let ((proc (get op type-tags))
            (coerced-list (coerce-full-list type-tags args)))
        (cond (proc (apply proc (map contents args)))
              (coerced-list (apply-generic op coerced-list))
              (else (error "No method for these types"
                           (list op type-tags)))))))
  (let ((result (solve)))
    (if (and (pair? result)
             (memq (type-tag result) type-tower))
        (drop result)
        result)))