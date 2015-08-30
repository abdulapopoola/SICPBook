#lang racket

(rule (outranked-by ?staff-person ?boss)
  (or (supervisor ?staff-person ?boss)
      (and (outranked-by ?middle-manager
                         ?boss)
           (supervisor ?staff-person 
                       ?middle-manager))))

(outranked-by (Bitdiddle Ben) ?who)
; On unification with rule, this becomes:
; -> (outranked-by (Bitdiddle Ben) ?boss)

; in the 'or' half of the rule, this turns to
; (outranked-by ?middle-manager ?boss)
; And this triggers another round since boss and middle-manager
; are not defined.

;; The outranked-by would always fail because it would get called
;; with a huge set as the first clause of the and statement and not
;; filtered down as before.

;; And is a pipe that narrowed down the problem space in the first
;; scenario however now, it keeps expanding and the loop is always 
;; triggered.