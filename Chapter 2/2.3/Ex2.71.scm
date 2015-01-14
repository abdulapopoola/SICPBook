#lang planet neil/sicp

;; One bit needed for the most frequent symbol while n-1 bits are 
;; needed for the least frequent symbol

;; Sample tree is shown below

    a,b,c,d,e
       /\
      a  {b,c,d,e}
            /\
           b  {c,d,e}
                 /\
                c  {d,e}
                     /\
                    d  e
