#lang planet neil/sicp

(define (make-monitored proc)
  (let ((counter 0))
        (define (dispatch m)
          (cond ((eq? m 'how-many-calls?) counter)
                ((eq? m 'reset) 
                 (set! counter 0))
                (else (set! counter (+ counter 1))
                      (proc m))))
        dispatch))

(define s (make-monitored sqrt))

(s 100)
;10

(s 9)
;3 

(s 'how-many-calls?)

(define (call-the-cops val) 
  (display "Calling the cops! \n"))

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance 
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((failed-access-count 0))
    (define (dispatch password-value m)
      (cond ((= failed-access-count 7) call-the-cops)
            ((eq? password-value password)
             (begin (set! failed-access-count 0)
                 (cond ((eq? m 'withdraw) withdraw)
                       ((eq? m 'deposit) deposit)
                       (else (error "Unknown request: MAKE-ACCOUNT" m)))))
            (else 
             (begin (set! failed-access-count (+ 1 failed-access-count))
                 (display "Incorrect password")
                 (lambda (x) nil)))))
    dispatch))

(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)

((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
((acc 'some-other-password 'deposit) 50)
