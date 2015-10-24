;; (f 'x 'y)
;; None of the 4 types of save or restore operations are needed because the arguments
;; are constants and only a lookup is required to grab the f procedure and
;; no register modifications occur.

;; ((f) 'x 'y)
;; Same as above; arguments are constants so no need to save env

;; (f (g 'x) y)
;; The following are needed:
;; save and restore for the y operand (it's not a constant)
;; save and restore for proc for the evaluation of (g 'x) sequence
;; argl needs to be saved since the value of (g 'x) would modify it

;; (f (g 'x) 'y)
;; save and restore for the evaluation of (g 'x) sequence
