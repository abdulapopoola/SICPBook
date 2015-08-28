#lang racket

(rule (last-pair (?x) (?x)))
(rule (last-pair (u? . v?) (?x))
      (last-pair v? (?x)))