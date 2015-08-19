#lang racket

(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (let ((found-word (random-word (cdr word-list))))
    (set! *unparsed* (cdr *unparsed*))
    (list (car word-list) found-word)))

(define (random-word lst)
  (item-at (random (length lst)) lst))

(define (item-at index lst)
  (if (= index 0)
      (car lst)
      (item-at (- index 1) lst)))