#lang planet neil/sicp

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define one (lambda (f) (lambda (x) (f x))))
;; one -> (add-1 zero)
;; (lambda (f) (lambda (x) (f ((zero f) x)))))

;; (zero f) -> ((lambda (f) (lambda (x) x)) f)
;;             (lambda (x) x)

;; Substituting into (add-1 zero)
;; (lambda (f) (lambda (x) (f (lamda (x) x) x)))))
;;    ->   (lambda (f) (lambda (x) (f x))))


(define two (lambda (f) (lambda (x) (f (f x)))))
;; two -> (add-1 one)
;; (lambda (f) (lambda (x) (f ((one f) x)))))

;; (one f) -> ((lambda (f) (lambda (x) (f x)))) f)
;;            (lambda (x) (f x))

;; Substituting into (add-1 one)
;; (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x)))))
;;    ->     (lambda (f) (lambda (x) (f (f x))))

(define (church-addition m n)
   (lambda (f) (lambda (x) ((m f) ((n f) x)))))