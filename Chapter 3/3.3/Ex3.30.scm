#lang planet neil/sicp

(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

(define (full-adder a b c-in sum c-out)
  (let ((c1 (make-wire)) 
        (c2 (make-wire))
        (s  (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

(define (ripple-carry-adder ak bk sk c)
  (if (null? ak)
      'ok
      (begin 
        (full-adder (car ak) (car bk) c (car sk) c-out)
        (ripple-carry-adder (cdr ak) (cdr bk) (cdr sk) c-out))))