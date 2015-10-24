
;; B
;; No we still lose the benefit of re-using already compiled
;; code. The interpreter will reevaluate such code every time
;; whereas the compiler will use the 'object' version of the code.


;; code for A
(define (symbol-operator-application? exp)
  (and (pair? exp) (symbol? (car exp))))

;; For installation in machine
(list 'symbol-operator-application? symbol-operator-application?)

;; For installation in eccore
(test (op symbol-operator-application?) (reg exp))
(branch (label ev-symbol-operator-application))

;; For installation in evaluation sequence
ev-symbol-operator-application
 (save continue)
 (assign unev (op operands) (reg exp))
 (assign proc (op operator) (reg exp))
 (assign proc (op lookup-variable-value) (reg proc) (reg env)) ;;operator is a symbol
 (assign argl (op empty-arglist))
 (test (op no-operands?) (reg unev))
 (branch (label apply-dispatch))
 (save proc)
 (goto (label ev-appl-operand-loop))
         