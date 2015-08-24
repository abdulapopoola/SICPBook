#lang racket

; the names of all people who are supervised by Ben Bitdiddle, 
; together with their addresses;
(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?where))

; all people whose salary is less than Ben Bitdiddle’s, together 
; with their salary and Ben Bitdiddle’s salary;
(and (salary ?person ?amount)
     (salary (Ben Bitdiddle) val)
     (lisp-value < ?amount val))


; all people who are supervised by someone who is not in the 
; computer division, together with the supervisor’s name and job.
(and (supervisor ?person ?supervisor)
     (not (job ?supervisor (computer . ?a)))
     (job ?supervisor ?description)