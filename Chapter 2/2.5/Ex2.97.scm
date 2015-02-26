#lang planet neil/sicp

(define (gcd-terms a b)
  (if (empty-termlist? b)
      (reduce-to-lowest a)
      (gcd-terms b (pseudoremainder-terms a b))))

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

(define (pseudoremainder-terms L1 L2)
  (let ((leading-coeff (coeff (first-term L2)))
        (O1 (order L1))
        (O2 (order L2))
        (integerizing-factor (expt leading-coeff (+ 1 (- O1 O2)))))
    (cadr (div-terms 
           (mul-term-by-all-terms integerizing-factor 0 L1)
           L2))))

(define (reduce-terms n d)
  (let ((gcd-all (gcd-terms n d)))
    (let ((01 (max (order n) (order d)))
          (O2 (order gcd-all))
          (c (coeff (first-term gcd-all))))
      (let ((factor (expt c (+ 1 (- O1 O2)))))
        (let ((raised-n (mul-term-by-all-terms factor 0 n))
              (raised-d (mul-term-by-all-terms factor 0 d)))
          (let ((factorized-n (car (div-terms raised-n gcd-all)))
                (factorized-d (car (div-terms raised-d gcd-all))))
            (let ((gcd-all-coeffs
                   (find-gcd (first-term n)
                             (append (rest-terms n) (termlist d)))))
              (let ((divisor (adjoin-term (make-term 0 gcd-all-coeffs)
                                          (the-empty-termlist))))
                (list (car (div-terms factorized-n divisor))
                      (car (div-terms factorized-d divisor)))))))))))

(define (reduce-poly L1 L2)
  (if (not (eq? (variable L1)
                (variable L2)))
      (error "The polynomials are not in the same variable"
             '(L1 L2))
      (map (lambda (termlist) 
             ((make-poly (variable L1) termlist)))
           (reduce-terms (term-list L1) (term-list L2)))))

(define (reduce-integers n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))