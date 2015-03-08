#lang planet neil/sicp

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
  (define (validate-password key)
    (eq? key password))
  (define (dispatch password-value m)
    (if (validate-password password-value)
        (cond ((eq? m 'validate)
               (validate-password password-value))
              ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request: 
                 MAKE-ACCOUNT" m)))
        (error "Incorrect password")))
  dispatch)

(define (make-joint acc password1 password2)
  (lambda (key message)
    (if (and (eq? key password2)
             (acc password1 'validate))
        (acc password1 message)
        (error "Incorrect password"))))

(define peter-acc (make-account 100 'secret-password))

(define paul-acc 
  (make-joint peter-acc 'secret-password 'rosebud))

((paul-acc 'rosebud 'withdraw) 0)
((peter-acc 'secret-password 'withdraw) 20)
((paul-acc 'rosebud 'withdraw) 0)