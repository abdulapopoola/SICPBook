(load "register-machine-simulator.scm")
(load "scheme-operators.scm")
(load "machine-operations.scm")
(load "eceval-machine.scm")

(define the-global-environment (setup-environment))
(start eceval)