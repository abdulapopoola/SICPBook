#lang racket

(define (insert-at lst pos x)
  (define-values (before after) (split-at lst pos))
  (append before (cons x after)))

(define (process-entries items num)
    (if (null? items)
        items
        (append 
         (walk-list (car items) num)
         (process-entries (cdr items) num))))

(define (permutations num)  
  (define (iter val curr)
    (if (< curr num)
        (iter (process-entries val (+ 1 curr)) (+ 1 curr))
        val))
  (iter (process-entries '((1)) 2) 2))
        
(define (walk-list lst num)
  (define (iter index out-list)
    (cond ((not (pair? lst)) out-list)
          ((> index (length lst)) out-list)
          (else
           (iter (+ index 1) (cons
                   (insert-at lst index num) out-list)))))
  (iter 0 '()))

(define (multiple-dwellings)
  (define (valid? floors-plan)
    (let ((baker (first floors-plan))
          (cooper (second floors-plan))
          (fletcher (third floors-plan))
          (miller (fourth floors-plan))
          (smith (fifth floors-plan)))
      (and (> miller cooper)
           (not (= (abs (- fletcher cooper)) 1))
           (not (= (abs (- smith fletcher)) 1))
           (not (= baker 5))
           (not (= cooper 1))
           (not (= fletcher 1))
           (not (= fletcher 5)))))
  (define (find-valid-plan plans)
    (if (valid? (car plans))
        (begin
          (display (map (λ (name floor)
                          (list name floor))
                        '(baker cooper fletcher miller smith)
                        (car plans)))
          (newline))
        (find-valid-plan (cdr plans))))
  (find-valid-plan (permutations 5)))
                
;(define x (walk-list (list 1 2 3) 4))
;(car x)
;(cadr x)
;(caddr x)
;(map (lambda (lst)
;       (walk-list lst 4))
;       (list (list 1 2 3) (list 2 1 3)))

;(length (permutations 5))
;(length (process-entries (process-entries (process-entries '((2 3) (3 2)) 1) 4) 5))

(multiple-dwellings)
; ((baker 3) (cooper 2) (fletcher 4) (miller 5) (smith 1))