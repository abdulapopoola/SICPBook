#lang planet neil/sicp

;;helpers
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (sum-seq seq)
  (accumulate + 0 seq))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low 
            (enumerate-interval 
             (+ low 1) 
             high))))

(define (triples n)
  (flatmap (lambda (x)
     (flatmap (lambda (y)
                (map (lambda (z)
                       (list x y z))
                     (enumerate-interval 1 (- y 1))))                  
              (enumerate-interval 1 (- x 1))))
           (enumerate-interval 1 n)))

(define (make-triple triple)
  (list (car triple) (cadr triple) (caddr triple) (sum-seq triple)))

(define (ordered-triples n s)
   (map make-triple
        (filter (lambda (triple)
                  (= (sum-seq triple) s))
                (triples n))))

(ordered-triples 5 10)
