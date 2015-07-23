#lang racket

(define (make-frame variables values)
  (define (iter var-list val-list)
    (cons (cons (car var-list) (car val-list))
          (iter (cdr var-list) (cdr val-list))))
  (if (= (length variables) (length values))
      (iter variables values)
      (error "Variable and values lengths do not match"
             variables
             values)))

(define (picker selector cons-list out)
  (if (null? cons-list)
      out
      (picker selector (cdr cons-list)
              (append out (selector (car cons-list))))))

(define (frame-variables frame)
  (picker car frame '()))

(define (frame-values frame)
  (picker cdr frame '()))

(define (add-binding-to-frame! var val frame)
  (cons (cons var val) frame))