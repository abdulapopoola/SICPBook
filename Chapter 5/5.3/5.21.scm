#lang planet neil/sicp

(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
        (else 
         (+ (count-leaves (car tree))
            (count-leaves (cdr tree)))))) 

(define count-leaves-machine 
   (make-machine
    '(continue tree tmp val) ;registers
    (list (list 'null? null?)     ; ops
          (list 'pair? pair?) 
          (list 'not not)
          (list '+ +)
          (list 'car car)
          (list 'cdr cdr))
   '(                             ; controller-text
    (assign continue (label completed)) 
    (assign val (const 0)) 
   tree-loop 
    (test (op null?) (reg tree)) 
    (branch (label tree-null)) 
    (assign tmp (op pair?) (reg tree))
    (test (op not) (reg tmp))
    (branch (label tree-leaf))
    (save continue)
    (save tree)
    (assign continue (label walk-tree-right))
    (assign tree (op car) (reg tree))
    (goto (label tree-loop))
   walk-tree-right
    (restore tree)
    (restore continue)
    (assign tree (op cdr) (reg tree))
    (save continue)
    (save val)
    (assign continue (label tree-walk-done))
    (goto (label tree-loop))
   tree-walk-done
    (assign tmp (reg val))
    (restore val)
    (assign val (op +) (reg tmp) (reg val))
    (restore continue)
    (goto (reg continue))    
   tree-null
    (assign val (const 0))
    (goto (reg continue)) 
   tree-leaf
    (assign val (const 1))
    (goto (reg continue)) 
   completed)))