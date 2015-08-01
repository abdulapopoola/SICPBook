;; Alyssa's version is less efficient because it waits until run-time
;; - when the env is passed in - before re-evaluating the execute-sequence.

;; This involves some inefficiency because execute-sequence will have to
;; go into the analyze method again. The original method circumvents this
;; by converting everything during the analyze phase.