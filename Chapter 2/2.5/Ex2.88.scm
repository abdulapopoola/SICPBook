#lang planet neil/sicp

;; a - b = a + (-b); define a generic negate and re-use the existing add

;; INSTALLATION
;; External interface for Integer package
(put 'negate 'integer
     (lambda (x) (tag (- x))))

;; Rational number package
;; External interface for Rational package
(put 'negate 'rational
     (lambda (x) (make-rat (- numer x) (denom x))))

;; Real number package
;; External interface for Real package
(put 'negate 'complex
     (lambda (x) (make-real (- x))))

;; Complex number package
;; External interface for Complex package
(put 'negate 'complex
     (lambda (x) (make-from-real-imag
                  (negate (complex-real-part x))
                  (negate (complex-imag-part x)))))

;; Polynomial package
;; Internal interface for Polynomial package
(define (negate-poly poly)
  (define (negate-coeffs polyList)
    (if (empty-termlist? polyList)
        (the-empty-termlist)
        (let ((first-term (first-term polyList)))
          (adjoin-term (make-term (order (first-term))
                                  (negate (coeff first-term)))
                       (negate-coeffs (rest-term polyList))))))
  (define (create-negated-poly p)
    (make-poly (variable p)
               (negate-coeffs (term-list p))))
  (create-negated-poly poly))

;; External interface for Polynomial package
(put 'negate 'polynomial
     (lambda (p) (tag (negate-poly poly))))