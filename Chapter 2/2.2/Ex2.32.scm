#lang planet neil/sicp

;;helpers
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map 
                      (lambda (x) (cons (car s) x))
                      rest)))))

(subsets '(1 2 3))

;; This is the power expansion of a set and it works as follows
;; The 'rest' is the list of all possible subsets that do not
;; include the car of the set
;; The lambda function is the list of all possible subsets that
;; do include the car of set (achieved by mapping the cons to all of rest

;; The union of these two sets will give the power set, see algorithm on
;; wikipedia - http://en.wikipedia.org/wiki/Power_set