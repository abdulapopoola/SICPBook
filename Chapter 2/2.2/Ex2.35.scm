#lang planet neil/sicp

;; helpers
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op 
                      initial 
                      (cdr sequence)))))

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append 
               (enumerate-tree (car tree))
               (enumerate-tree (cdr tree))))))


(define (count-leaves t)
  (accumulate 
   (lambda (x y) (+ 1 y))
   0
   (enumerate-tree t)))

;;Another (probably better) way to solve this
(define (count-leaves t)
  (accumulate + 0
   (map (lambda (x) 1) (enumerate-tree t))))

(define x (cons (list 1 2) (list 3 4)))
(count-leaves x)
(count-leaves (list x x))