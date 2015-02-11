#lang planet neil/sicp

;; INSTALLATION
;; External interface for Integer package
(put 'square 'integer
     (lambda (x) (tag (* x x))))
(put 'arctan '(integer integer)
     (lambda (x y) (make-real (atan x y))))
(put 'sine 'integer
     (lambda (x) (make-real (sin x))))
(put 'cosine 'integer
     (lambda (x) (make-real (cos x))))

;; Rational number package
;; External interface for Rational package
(put 'square 'rational
     (lambda (x) (make-real (mul-rat x x))))
(put 'arctan '(rational rational)
     (lambda (x y) 
       (make-real (atan (/ (numer x) (denom x))
                        (/ (numer y) (denom y))))))
(put 'sine 'rational
     (lambda (x) (make-real (sin (/ (numer x) (denom x))))))
(put 'cosine 'rational
     (lambda (x) (make-real (cos (/ (numer x) (denom x))))))

;; Real number package
;; External interface for Complex package
(put 'square 'complex
     (lambda (x) (tag (* x x))))
(put 'arctan '(real real)
       (lambda (x y) (tag (atan x y))))
(put 'cosine '(real)
       (lambda (x) (tag (cos x))))
(put 'sine '(real)
       (lambda (x) (tag (sin x))))