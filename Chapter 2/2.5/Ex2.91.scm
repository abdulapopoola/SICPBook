#lang planet neil/sicp

(define (sub-terms L1 L2)
  (add-terms L1 (negate-terms L2)))

(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) 
            (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-c (div (coeff t1) 
                              (coeff t2)))
                  (new-o (- (order t1) 
                            (order t2)))
                  (new-term (make-term new-o
                                       new-c))
                  (rest-of-result
                   (div-terms L1
                              (sub-terms L1 (mul-term-by-all-terms new-term L2)))))
                (list (adjoin-term new-term (car rest-of-results))
                      (cadr rest-of-results)))))))