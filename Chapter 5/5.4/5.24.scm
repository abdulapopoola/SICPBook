#lang planet neil/sicp

;; Get expression out of cond
;; if true, jump to evaluate
;; otherwise set exp to next valu
;; go to cnd loop again

ev-cond
   (assign unev (op cond-clauses) (reg exp))
ev-cond-loop
   (assign exp (op first-exp) (reg exp))
   (test ) ;;if exp is true)
   (branch (label ev-cond-action))
   (save unev)
   (save env)
ev-cond-action
   
