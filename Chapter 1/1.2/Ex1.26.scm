(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder 
          (* (expmod base (/ exp 2) m)
             (expmod base (/ exp 2) m))
          m))
        (else
         (remainder 
          (* base 
             (expmod base (- exp 1) m))
          m))))

;; The original expmod is O(logN) because it grows by
;; successive halving the power.
;; The function above does the same thing however instead
;; of calculating the value once and passing it to square,
;; it does the exponential calculation twice (i.e. multiples 
;; both results.

;; Mathematically, the expmod is a dividing operation and thus
;; takes O(logN) steps to reach the base; however with the approach
;; above, the process grows exponentially at each step i.e. 0(2^N)
;; thus there are (2^N) leaf nodes at the root of the tree (i.e. 
;; (2^N) operations have to be done.
;; Combining both, the new order of growth is O(log(2^N)) which 
;; gives O(N)