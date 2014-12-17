#lang planet neil/sicp

;;helpers
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

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

(define (unique-pairs n)
   (map (lambda (x)
          (map (lambda (y)
                  (list x y))
                (enumerate-interval 1 (- x 1))))
          (enumerate-interval 1 n)))

(unique-pairs 3)

(define (prime-sum-pairs n)
   (map make-pair-sum
        (filter prime-sum?
                (unique-pairs n))))

(define (prime-sum? pair)
   (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
   (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))