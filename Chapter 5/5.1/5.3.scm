#planet lang neil/sicp

(controller
   (assign guess (const 1))
test-sqrt
   (test (op good-enough) (reg guess) (reg value))
   (branch (label sqrt-done))
   (assign guess (op improve) (reg guess) (reg value))
   (goto (label test-sqrt))
 sqrt-done
   (perform (op print) (reg guess)))

;; Replacing all functions with primitives
(controller
   (assign guess (const 1))
   (assign tmp (reg guess))
test-sqrt
   (assign tmp (op square) (reg guess))
   (assign tmp (op -) (reg tmp) (reg value))
   (assign tmp (op abs) (reg tmp))
   (test (op < ) (reg tmp) (const 0.001))
   (branch (label sqrt-done))
   (assign tmp (op /) (reg value) (reg guess))
   (assign guess (op average) (reg guess) (reg tmp))
   (goto (label test-sqrt))
sqrt-done
   (perform (op print) (reg guess)))