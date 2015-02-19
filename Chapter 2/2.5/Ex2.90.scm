#lang planet neil/sicp

(define (dense? poly)
  (eq? (type-tag poly) 'dense))

(define (sparse? poly)
  (eq? (type-tag poly) 'sparse))
  
(define (make-term term-order term-coeff)
  (cons term-coeff term-order))
  
(define (coeff term) (car term))
(define (order term) (cdr term))

(define (order termlist) (- (length termlist) 1))

(define (adjoin-term term-order term-coeff term-list)
  (cond ((zero? term-coeff) term-list)
        ((= term-order (+ 1 (order term-list)))
         (cons term-coeff term-list))
        ((> term-order (order term-list))
         (adjoin-term term-order term-coeff
                      (cons zero-coeff term-list)))
        (else (error "Cannot adjoin term with a lower order to term list"
                     (list term-order term-coeff term-list)))))

;;Procedures rewritten
(define (add-terms L1 L2)
  (cond ((empty-termlist? L1) L2)
        ((empty-termlist? L2) L1)
        (else
         (let ((t1 (first-term L1))
               (o1 (order L1))
               (t2 (first-term L2))
               (o2 (order L2)))
           (cond ((> o1 o2)
                  (adjoin-term
                   o1 t1                   
                   (add-terms (rest-terms L1) L2)))
                 ((< o1 o2)
                  (adjoin-term
                   o2 t2 
                   (add-terms 
                    L1 
                    (rest-terms L2))))
                 (else
                  (adjoin-term
                   o1 (add t1 t2)
                   (add-terms 
                    (rest-terms L1)
                    (rest-terms L2)))))))))

(define (mul-terms L1 L2)
  (if (empty-termlist? L1)
      (the-empty-termlist)
      (add-terms 
       (mul-term-by-all-terms 
        (first-term L1) (order L1) L2)
       (mul-terms (rest-terms L1) L2))))

(define (mul-term-by-all-terms term-coeff term-order L)
  (if (empty-termlist? L)
      (the-empty-termlist)
      (let ((t2 (first-term L))
            (new-order (add term-order (order L)))
        (adjoin-term
         new-order
         (mul term-coeff t2)
         (mul-term-by-all-terms term-coeff term-order (rest-terms L)))))))

(define (negate-terms L)
  (if (empty-termlist? L)
      (the-empty-termlist)
      (adjoin-term (order L) (- (first-term L))
                   (negate-terms (rest-terms L)))))
