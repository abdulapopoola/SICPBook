#lang planet neil/sicp

(define (count-pairs x)
  (let ((pairs '()))
    (define (count-unique lst)
      (cond ((not (pair? lst)) 0)
            ((memq lst pairs) 0)   
            (else (set! pairs (append pairs lst))
                  (+ (count-unique (car lst))
                     (count-unique (cdr lst))
                     1))))
    (count-unique x)))

(define p1 1)
(define p2 2)
(define p3 3)

(define three (list p1 p2 p3)); (cons 1 2) (cons 3 4) (cons 5 6)))
(count-pairs three)

(define four (list (cons p1 p2) p2 p3))
(count-pairs four)

(define seven (list (cons p1 (cons p1 p2)) (cons p2 p3) (cons p1 p3)))
(count-pairs seven)

(define tmp (cons 1 2))
(define p1-inf (cons tmp tmp))
(define p2-inf (cons tmp tmp))
(define p3-inf (cons tmp tmp))

;set up inifinite chaining conditions
(set-car! (car p1-inf) p2-inf)
(set-car! (cdr p1-inf) p3-inf)
(set-car! (car p2-inf) p1-inf)
(set-car! (cdr p2-inf) p3-inf)
(set-car! (car p3-inf) p1-inf)
(set-car! (cdr p3-inf) p2-inf)

(define infinite (list p1-inf p2-inf p3-inf))
(count-pairs infinite)

;; Second approach also works
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate 
                       (cdr sequence))))
        (else  (filter predicate 
                       (cdr sequence)))))

(define (count-pairs2 x)
  (define pairs-list '())
  (define (exists-in-pairs-list? item)
    (> (length (filter (lambda (entry)
                         (eq? entry item))
                       pairs-list))
       0))
  (define (count-unique lst)
    (cond ((not (pair? lst)) 0)
          ((exists-in-pairs-list? lst) 0)
          (else (set! pairs-list (cons pairs-list lst))
                (+ (count-unique (car lst))
                   (count-unique (cdr lst))
                   1))))
    (count-unique x))