#lang planet neil/sicp

;; One way to solve this design problem is to convert all
;; dense polynomials to sparse polynomials and then use
;; existing code

;; Another way will be to have separate handling functions
;; like the complex example in section 2.4 


;; Using the simple/easy approach ;)
(define (dense? poly)
  (eq? (type-tag poly) 'dense))

(define (sparse? poly)
  (eq? (type-tag poly) 'sparse))

(define (order-dense termlist) (- (length termlist) 1))


(define (dense->sparse poly)
  (if (empty-termlist? poly)
      (the-empty-termlist)
      (let ((order (order-dense poly))
            (coeff (first-term poly)))
        (adjoin-term
         (make-term order coeff)
         (dense->sparse (rest-terms poly))))))