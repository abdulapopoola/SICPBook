#lang planet neil/sicp

;; Would not work so well since memoize fib would not take
;; advantage of previously memoized values but instead calculates
;; it all over again.