#lang racket

(rule (last-pair (?x) (?x)))
(rule (last-pair (u? . v?) (?x))
      (last-pair v? (?x)))

; There are an infinite amount of numbers ending with 3