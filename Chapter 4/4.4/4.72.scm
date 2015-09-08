#lang planet neil/sicp

; Interleave ensures that results from all the various
; constituent streams are printed out. Otherwise, if the
; first stream is an infinite stream, then we would get no
; results from the other ones since the loop will continue
; indefinitely.