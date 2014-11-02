; Always returns the sum of a and the absolute value of b
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

; (a-plus-abs-b 1 -2) evaluates to 3
