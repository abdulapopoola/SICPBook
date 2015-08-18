#lang racket

(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 
        'verb-phrase
        (parse-verb-phrase)
        (parse-prepositional-phrase))))

; It does not work well with verbal sentences containing prepositional phrases. 
; This would cause it to end up in an infinite loop
; whenever the parse-prepositional-phrase segment fails. This happens because
; this will trigger another parse-verb-phrase call which will also fail for this
; purpose. End result: infinite loop.

; Changing the order makes this infinite loop problem more obvious rapidly.
