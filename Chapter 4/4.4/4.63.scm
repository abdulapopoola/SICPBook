#lang racket

(rule (grandson-of G S)
      (and (son-of f S)
           (son-of G f)))

(rule (mother-of W S)
      (and (son-of M S)
           (wife-of M W)))
      