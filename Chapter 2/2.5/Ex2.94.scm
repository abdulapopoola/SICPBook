#lang planet neil/sicp

(define (remainder-terms L1 L2)
  (cadr (div-terms L1 L2)))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))

(define (gcd-poly L1 L2)
  (if (not (eq? (variable L1)
                (variable L2)))
      (error "The polynomials are not in the same variable"
             '(L1 L2))
      (make-poly (variable L1) 
                 (gcd-terms (term-list L1)
                            (term-list L2)))))

;; INSTALLATION
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(put 'gcd '(scheme-number scheme-number) gcd)

(put 'gcd '(polynomial polynomial) gcd-poly)


;; EXTERNAL INTERFACE
(define (greatest-common-divisor x y)
  (apply-generic 'gcd x y))

