#lang planet neil/sicp

(define (attach-tag type-tag contents)
  (cons type-tag contents))
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum -- TYPE-TAG" datum)))
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum -- CONTENTS" datum)))

;; helpers
(define (raise val)
  (let ((type-tower '(integer rational real complex)))
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
    (do-raise type-tower)))

;; INSTALLATION
;; Integer number package
;; Internal implementation
(define (integer->rational int)
  (make-rational int 1))

;; External interface
(put-coercion 'integer 'rational integer->rational)

;; Rational number package
;; Internal procedure
(define (rational->real rat)
  (make-real (/ (numer rat) (denom rat))))

;; External interface
(put-coercion 'rational 'real rational->real)

;; Real number package
;; Internal procedure
(define (real->complex real)
  (make-complex-from-real-imag real 0))

;; External interface
(put-coercion 'real 'complex real->complex)
    
