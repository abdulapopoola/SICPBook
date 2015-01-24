#lang planet neil/sicp

(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number)
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((number? datum) datum)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum: TYPE-TAG" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum: CONTENTS" datum))))

;; TESTS
(attach-tag 'scheme-number 1) ; 1
(type-tag 2) ; 2 - normal scheme number
(contents 3) ; 3

(define complex-number (attach-tag 'complex '(1 2)))
; (mcons 'complex (mcons 1 (mcons 2 '())))
(type-tag complex-number) ; 'complex
(contents complex-number) ; (1 2)
