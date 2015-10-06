#lang planet neil/sicp
    
;; Append
(define append 
   (make-machine
    '(continue x y val tmp) ;registers
    (list (list 'null? null?)     ; ops
          (list 'cons cons)
          (list 'car car)
          (list 'cdr cdr))
   '(                             ; controller-text
    (assign continue (label done))
   append-loop 
    (test (op null?) (reg x)) 
    (branch (label x-null))
    (assign tmp (op car) (reg x))
    (save tmp) ;; Store the car of the list
    (assign x (op cdr) (reg x))
    (save continue)
    (assign continue (label walk-cdr-x))
    (goto (label append-loop)
   x-null
    (assign val (reg y))
    (restore continue)
    (goto (reg continue)))
   walk-cdr-x
    (restore tmp)
    (assign val (op cons) (reg tmp) (reg val))
    (restore continue)
    (goto (reg continue))
   done)))

;; Append!
(define append! 
   (make-machine
    '(x y val) ;registers
    (list (list 'null? null?)     ; ops
          (list 'set-cdr! set-cdr!)
          (list 'cdr cdr))
   '(                             ; controller-text
    (assign continue (label done))
   append!-loop 
    (assign x (op cdr) (reg x))
    (test (op null?) (reg x)) 
    (branch (label x-cdr-null))
    (goto (label append!-loop))    
   x-cdr-null
    (assign val (op set-cdr!) (reg tmp) (reg y)) ;;side effect op, val's content doesn't really matter    
    (goto (label done))
   done)))