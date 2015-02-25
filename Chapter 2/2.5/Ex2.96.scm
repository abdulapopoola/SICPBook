#lang planet neil/sicp

;; Greatly influenced by wonderful solution here:
;; http://jots-jottings.blogspot.com/2013/03/sicp-exercise-296-pseudo-remainder-terms.html

(define (pseudoremainder-terms L1 L2)
  (let ((leading-coeff (coeff (first-term L2)))
        (O1 (order L1))
        (O2 (order L2))
        (integerizing-factor (expt leading-coeff (+ 1 (- O1 O2)))))
    (cadr (div-terms 
           (mul-term-by-all-terms integerizing-factor 0 L1)
           L2))))

(define (gcd-terms a b)
  (if (empty-termlist? b)
      (reduce-to-lowest a)
      (gcd-terms b (pseudoremainder-terms a b))))

(define (gcd-poly L1 L2)
  (if (not (eq? (variable L1)
                (variable L2)))
      (error "The polynomials are not in the same variable"
             '(L1 L2))
      (make-poly (variable L1) 
                 (gcd-terms (term-list L1)
                            (term-list L2)))))

(define (reduce-to-lowest P)
  (if (empty-termlist? P)
      P
      (let ((gcd-value (find-gcd (coeff (first-term P)) (rest-terms P)))
            (divisor (adjoin-term (make-term 0 gcd-value) (the-empty-termlist))))
        (car (div-terms P divisor)))))

(define (find-gcd c P)
  (if (empty-termlist? P)
      c
      (find-gcd (greatest-common-divisor c (coeff (first-term P)))
                (rest-terms P))))