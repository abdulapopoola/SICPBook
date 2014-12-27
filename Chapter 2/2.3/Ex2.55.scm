#lang planet neil/sicp

(car ''abracadabra)

; The first quote wraps around the second `'abracadabra`; thus it creates a value
; containing the verbatim value: `'abracadabra`. Thus doing a car on this value
; returns the first element which is the `'` character.

; The inner expression is the same as '('abracadabra) and this is a list containing
; the quote symbol and the abracadabra text; a car retrieves the quote.