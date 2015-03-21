#lang planet neil/sicp

; if cdr x and 

(define (has-cycle x)
  (cond ((or (null? x)
             (null? (car x))
             (null? (cdr x))
             (null? (cddr x))) false) ;not pair?
        ((eq? (car x) (cddr x)) true)
        (else (has-cycle (cdr x)))))
        
(define p1 1)
(define p2 2)
(define p3 3)

(define three (list p1 p2 p3)); (cons 1 2) (cons 3 4) (cons 5 6)))
(has-cycle three)

(define four (list (cons p1 p2) p2 p3))
(has-cycle four)

(define seven (list (cons p1 (cons p1 p2)) (cons p2 p3) (cons p1 p3)))
(has-cycle seven)

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

(define infinite (list p1-inf p2-inf p3-inf p1-inf))
(has-cycle infinite)

(define (cyclic? lst)
  (define (iter switch slow-pointer fast-pointer)
    (cond ((null? fast-pointer) #f)
	  ((eq? slow-pointer fast-pointer) #t)
	  (else (iter (not switch) 
		      (if switch (cdr slow-pointer) slow-pointer)
		      (cdr fast-pointer)))))
  (iter #t lst (cdr lst)))

(cyclic? infinite)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define z (make-cycle (list 'a 'b 'c 'd)))
(define w (append '(g h j) z))

(cyclic? z)
(has-cycle z)