;; Compiled expression
;; (define (f x)
;;     (+ x (g (+ x 2))))

;; DERIVATION
(assign val (op make-compiled-procedure) 
            (label entry16) 
            (reg env))
  (goto (label after-lambda15))
entry16
  (assign env (op compiled-procedure-env)
              (reg proc))
   ;; x is defined and environment extended
  (assign env (op extend-environment)
              (const (x)) 
              (reg argl) 
              (reg env))
  ;; operation + is added -> (+
  (assign proc (op lookup-variable-value) 
               (const +) 
               (reg env))
  (save continue) (save proc) (save env)
  ;; operation g (a procedure) is added -> (g
  (assign proc (op lookup-variable-value) 
               (const g) 
               (reg env))
  (save proc)
  ;; operation + is added again -> (g (+ (x 2))
  (assign proc (op lookup-variable-value) 
               (const +) 
               (reg env))
  (assign val (const 2))
  (assign argl (op list) (reg val))
  (assign val (op lookup-variable-value)
              (const x) 
              (reg env))
  (assign argl (op cons)
               (reg val)
               (reg argl)) 
  ;; argl now contains x and 2 -> (x 2)
  (test (op primitive-procedure?)
        (reg proc))
  (branch (label primitive-branch19))
compiled-branch18
  (assign continue (label after-call17))
  (assign val
          (op compiled-procedure-entry)
          (reg proc))
  (goto (reg val))
primitive-branch19
  (assign val
          (op apply-primitive-procedure)
          (reg proc) 
          (reg argl))
after-call17
  (assign argl (op list) (reg val))
  (restore proc)
  (test (op primitive-procedure?)
        (reg proc))
  (branch (label primitive-branch22))
compiled-branch21
  (assign continue (label after-call20))
  (assign val
          (op compiled-procedure-entry)
          (reg proc))
  (goto (reg val))
primitive-branch22
  (assign val 
          (op apply-primitive-procedure) 
          (reg proc) 
          (reg argl))
after-call20
  (assign argl (op list) (reg val))
  (restore env)
  (assign val
          (op lookup-variable-value) 
          (const x) 
          (reg env))
  (assign argl
          (op cons)
          (reg val)
          (reg argl))
  (restore proc)
  (restore continue)
  (test (op primitive-procedure?)
        (reg proc))
  (branch (label primitive-branch25))
compiled-branch24
  (assign val (op compiled-procedure-entry)
              (reg proc))
  (goto (reg val))
primitive-branch25
  (assign val 
          (op apply-primitive-procedure)
          (reg proc) 
          (reg argl))
  (goto (reg continue))
after-call23
after-lambda15
  (perform (op define-variable!) 
           (const f) 
           (reg val) 
           (reg env))
  (assign val (const ok))