#lang planet neil/sicp

(define (dense-terms-list poly)
  (map (lambda (term) (coeff term))
       (term-list poly)))

;; Procedures
(define (order val termlist) 
  (- (length termlist)
     (length (memq val (reverse termlist)))))

(define (order2 val termlist)
  (- (length (memq val termlist))
     1))

(define (adjoin-term coeff coeff-list)
  (if (=zero? coeff)
      coeff-list
      (cons coeff term-list)))

;;Procedures rewritten
(define (add-terms L1 L2)
  (cond ((empty-termlist? L1) L2)
        ((empty-termlist? L2) L1)
        (else
         (let ((t1 (first-term L1)) 
               (t2 (first-term L2)))
           (cond ((> (order t1 L1) (order t2 L2))
                  (adjoin-term
                   t1 
                   (add-terms (rest-terms L1) 
                              L2)))
                 ((< (order t1 L1) (order t2 L2))
                  (adjoin-term
                   t2 
                   (add-terms 
                    L1 
                    (rest-terms L2))))
                 (else
                  (adjoin-term
                   (add t1 t2)
                   (add-terms 
                    (rest-terms L1)
                    (rest-terms L2)))))))))

(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms 
       (mul-term-by-all-terms 
        (first-term L1) (order (first-term L1) L1) L2)
       (mul-terms (rest-terms L1) L2))))

(define (mul-term-by-all-terms coeff order L)
  (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L)))
        (adjoin-term
         (make-term 
          (+ (order t1) (order t2))
          (mul (coeff t1) (coeff t2)))
         (mul-term-by-all-terms 
          t1 
          (rest-terms L))))))