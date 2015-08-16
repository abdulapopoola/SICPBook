#lang racket

(define (valid-for-baker floorNo)
  (memq floorNo '(1 2 3 4)))

(define (valid-for-cooper floorNo)
  (memq floorNo '(2 3 4 5)))

(define (valid-for-fletcher floorNo)
  (memq floorNo '(2 3 4)))

(define (valid-for-miller floorNo cooper-floor-value)
  (> floorNo cooper-floor-value))

(define (valid-for-smith floorNo)
  (memq floorNo '(1 2 3 4 5)))

(define (insert-at lst pos x)
  (define-values (before after) (split-at lst pos))
  (append before (cons x after)))

(define (permutations lst)
  (cond ((= (length lst) 1) (list lst))
        (else 
         (display (cdr lst))
         (newline)
         (display (permutations (cdr lst)))
         (map (lambda (lst-val)
                (display lst-val)
                (newline)
                (walk-list lst-val (car lst)))
             (permutations (cdr lst))))))
        
(define (walk-list lst num)
  (define (iter index out-list)
    (cond ((> index (length lst)) out-list)
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
                        plans))
          (newline))
        (find-valid-plan (cdr plans))))
  (find-valid-plan (permutations (list 1 2 3 4 5))))
                
(define x (walk-list (list 1 2 3) 4))
;(car x)
;(cadr x)
;(caddr x)
;(map (lambda (lst)
;       (walk-list lst 4))
;       (list (list 1 2 3) (list 2 1 3)))

(permutations (list 1 2 3))