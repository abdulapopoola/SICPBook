(load "compiler.scm")

(define code (compile
              '(+ 1 2)
               'val
               'next))

(pretty-print code)

;; Change preserving to always wrap in save, restore

(define (preserving regs seq1 seq2)
  (if (null? regs)
      (append-instruction-sequences seq1 seq2)
      (let ((first-reg (car regs)))
        (preserving 
         (cdr regs)
         (make-instruction-sequence
          (list-union 
           (list first-reg)
           (registers-needed seq1))
          (list-difference
           (registers-modified seq1)
           (list first-reg))
          (append `((save ,first-reg))
                  (statements seq1)
                  `((restore ,first-reg))))
         seq2))))

(define code (compile
              '(+ 1 2)
               'val
               'next))

(pretty-print code)

;; Without the preserving mechanism, the generated code is more verbose
;; and inefficient as it saves and restores at every single instruction 
;; generated

;; WITH only needed save / restore wrapping
   (env)
   (env proc argl continue val)
   ((assign proc (op lookup-variable-value) (const +) (reg env))
    (assign val (const 2))
    (assign argl (op list) (reg val))
    (assign val (const 1))
    (assign argl (op cons) (reg val) (reg argl))
    (test (op primitive-procedure?) (reg proc))
    (branch (label primitive-branch1))
    compiled-branch2 
    (assign continue (label after-call3))
    (assign val (op compiled-procedure-entry) (reg proc))
    (goto (reg val)) 
    primitive-branch1 
    (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
    after-call3)
   
;; With all save restore wrapping
   (env continue)
   (env proc argl continue val)
   ((save continue)
    (save env) 
    (save continue) ;;PRESERVING save and continues
    (assign proc (op lookup-variable-value) (const +) (reg env))
    (restore continue) 
    (restore env) 
    (restore continue) 
    (save continue) 
    (save proc) 
    (save env) 
    (save continue)
    (assign val (const 2))
    (restore continue) 
    (assign argl (op list) (reg val)) 
    (restore env) 
    (save argl) 
    (save continue) 
    (assign val (const 1)) 
    (restore continue) 
    (restore argl)
    (assign argl (op cons) (reg val) (reg argl))
    (restore proc)
    (restore continue) 
    (test (op primitive-procedure?) (reg proc))
    (branch (label primitive-branch4))
    compiled-branch5
    (assign continue (label after-call6)) 
    (assign val (op compiled-procedure-entry) (reg proc)) 
    (goto (reg val)) 
    primitive-branch4
    (save continue) 
    (assign val (op apply-primitive-procedure) (reg proc) (reg argl))
    (restore continue) 
    after-call6)