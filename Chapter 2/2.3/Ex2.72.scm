#lang planet neil/sicp

;; encode grows at O(N) however the member function 
;; also grows at O(N) so this might end up being a 
;; O(N**2) operation in the worst case

;; Mathematically, the most frequent term can be encoded in constant time
;; the next symbol will take 2 steps, the next will take 3 steps and so on.
;; So this is the sum of an arithmetic progression up to (n-1)
;; And this will be N**2.