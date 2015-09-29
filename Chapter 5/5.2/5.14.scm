#lang planet neil/sicp


;; Copying the repl pattern from here:
;; https://github.com/ivanjovanovic/sicp/blob/master/5.2/e-5.14.scm
(define fact-machine
  (make-machine
    '(continue n val)
    ; adding the read operation that reads frm STDIN
    (list (list '= =) (list '- -) (list '* *) (list 'read read))
    '(init
       (perform (op initialize-stack))
       (assign n (op read))
       (assign continue (label fact-done))
      fact-loop
       (test (op =) (reg n) (const 1))
       (branch (label base-case))
       (save continue)
       (save n)
       (assign n (op -) (reg n) (const 1))
       (assign continue (label after-fact))
       (goto (label fact-loop))
      after-fact
       (restore n)
       (restore continue)
       (assign val (op *) (reg n) (reg val))
       (goto (reg continue))
      base-case
       (assign val (const 1))
       (goto (reg continue))
      fact-done
       (perform (op print-stack-statistics)))))

(define (repl)
  (start fact-machine)
  (repl))

(repl)

; pushes and maximum depth are the same values
; 100 -> 198
; 1000 -> 1998
; 10k -> 19998 
; formula -> 2n - 2