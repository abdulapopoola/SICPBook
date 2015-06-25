#lang racket

(define zero-crossings
  (stream-map sign-change-detector 
              sense-data 
              (stream-cons 0 sense-data)))