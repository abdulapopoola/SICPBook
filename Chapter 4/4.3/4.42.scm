#lang racket

(define (xor x y)
  (or (and x (not y))
      (and y (not x))))

(define (liars-puzzle)
  (let ((Betty (amb 1 2 3 4 5))
        (Ethel (amb 1 2 3 4 5))
        (Joan (amb 1 2 3 4 5))
        (Kitty (amb 1 2 3 4 5))
        (Mary (amb 1 2 3 4 5)))
    (require (xor (= Betty 3) (= Kitty 3)))
    (require (xor (= Ethel 1) (= Joan 2)))
    (require (xor (= Joan 3) (= Ethel 5)))
    (require (xor (= Kitty 2) (= Mary 4)))
    (require (xor (= Mary 4) (= Betty 1)))
    (require
     (distinct? (list Betty Ethel Joan 
                      Kitty Mary)))    
    (list (list 'Betty Betty)
          (list 'Ethel Ethel)
          (list 'Joan Joan)
          (list 'Kitty Kitty)
          (list 'Mary Mary))))

;((betty 3) (ethel 5) (joan 2) (kitty 1) (mary 4))
