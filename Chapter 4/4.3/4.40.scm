#lang planet neil/sicp

;; Before distinct is called, there are 5 exp 5 ways to assign people
;; however after distinct, this drops down to 5!

;; Remove all predefined constant conditions/values such that amb only gets really ambiguous
;; values.

(define (multiple-dwelling)
  (let ((cooper (amb 2 3 4 5))        
        (miller (amb 1 2 3 4 5)))
    (require (> miller cooper))
    (let ((fletcher (amb 2 3 4)))
      (require (not (= (abs (- fletcher cooper)) 1)))
      (let (smith (amb 1 2 3 4 5))
        (require (not (= (abs (- smith fletcher)) 1)))
        (let ((baker (amb 1 2 3 4)))
          (require (distinct? (list baker cooper fletcher 
                      miller smith)))  
          (list (list 'baker baker)
                (list 'cooper cooper)
                (list 'fletcher fletcher)
                (list 'miller miller)
                (list 'smith smith)))))))