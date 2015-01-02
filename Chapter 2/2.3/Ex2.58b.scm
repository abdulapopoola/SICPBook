#lang planet neil/sicp

;; Solution originally from Alexey Grigorev's comment on 
;; http://www.billthelizard.com/2012/04/sicp-256-258-symbolic-differentiation.html

;; helpers
(define (variable? x) (symbol? x))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) 
         (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) 
             (=number? m2 0)) 
         0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) 
         (* m1 m2))
        (else (list m1 '* m2))))

(define (make-exponentiation base exp)
  (cond ((=number? exp 0) 1)
        ((=number? exp 1) base)
        ((and (number? base) (number? exp)) (expt base exp))
        (else (list '**  base exp))))

(define (operation expr)
  (cond ((memq '+ expr) '+)
        ((memq '* expr) '*)
        ((memq '** expr) '**)))

(define (prefix item x)
  (define (iter x result)
    (if (eq? (car x) item)
        (reverse result)
        (iter (cdr x) (cons (car x) result))))
  (iter x '()))

(define (sum? x)
  (eq? '+ (operation x)))

(define (addend s)
  (let ((a (prefix '+ s)))
    (if (= (length a) 1)
        (car a)
        a)))

(define (augend s)
  (let ((a (cdr (memq '+ s))))
    (if (= (length a) 1) (car a) a)))

(define (product? x) 
  (eq? '* (operation x)))

(define (multiplier p)
  (let ((m (prefix '* p)))
    (if (= (length m) 1)
        (car m)
        m)))

(define (multiplicand p)
  (let ((m (cdr (memq '* p))))
    (if (= (length m) 1)
        (car m)
        m)))

(define (exponentiation? x)
  (eq? '** (operation x)))

(define (base e)
  (let ((p (prefix '** e)))
    (if (= (length p) 1)
        (car p)
        p)))

(define (exponent e)
  (let ((p (cdr (memq '** e))))
    (if (= (length p) 1)
        (car p)
        p)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product 
           (multiplier exp)
           (deriv (multiplicand exp) var))
          (make-product 
           (deriv (multiplier exp) var)
           (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (exponent exp)
                       (make-product (make-exponentiation (base exp)
                                                          (make-sum (exponent exp) -1))
                                     (deriv (base exp) var))))
        (else (error "unknown expression 
                      type: DERIV" exp))))

(deriv ' (x * 3 + 5 * (x + y + 2)) 'x)
(deriv '(x + (3 * (x + (y + 2)))) 'x)