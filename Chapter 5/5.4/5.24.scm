#lang planet neil/sicp

;; Get expression out of cond
;; if true, jump to evaluate
;; otherwise set exp to next valu
;; go to cnd loop again

ev-cond
   (assign unev (op cond-clauses) (reg exp))
   (save continue)
ev-cond-loop
   (assign exp (op first-exp) (reg unev))
   (test (op cond-else-clause?) (reg exp)) ;;if is else clause, go to action
   (branch (label ev-cond-action))
   (save unev)
   (save env)
   ;;Now exp only contains predicate expression of cond clause
   (assign exp (op cond-predicate) (reg exp))
   (assign continue (label ev-cond-clause))
   (goto (label eval-dispatch))
   
;; Execution will only get here once predicate has been evaluated
;; i.e. from line 19 above
ev-cond-clause
   (restore unev)
   (restore env)
   (test (op true?) (reg val))
   (branch (label ev-cond-action))
   ;; Cond predicate was falsy, update unev to point to remaining clauses
   (assign unev (op cond-clauses) (reg unev))
   (goto (label ev-cond-loop))
   
ev-cond-action
   ; Only take the first exp as it is the one that eval to true or is else 
   ; clause. 
   ; This approach helps to avoid saving the exp and using continue
   (assign unev (op first-exp) (reg unev))
   (assign unev (op cond-actions) (reg unev))
   (goto (label ev-sequence))
   
