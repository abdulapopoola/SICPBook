#lang planet neil/sicp

;; Install new ops in evaluator
(list (list 'cond? cond?)
      (list 'cond->if cond->if)
      (list 'let? let?)
      (list 'let->combination let-combination))

;; Install new expressions in eval dispatcher
eval-dispatch
   ...
   (test op cond?) (reg exp))
   (branch (label ev-cond))
   (test op let?) (reg exp))
   (branch (label ev-let))

;; evaluate code in evaluator
ev-cond
   (assign exp (op cond->if) (reg exp))
   (goto (label ev-if))

ev-cond
   (assign exp (op let->combination) (reg exp))
   (goto (label eval-dispatch))

