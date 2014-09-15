(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b)))) 

;; Normal form for (gcd 206 40)
;; Count of remainder operations
;;
(gcd 206 40)

(define (gcd 206 40)
  (if (= 40 0)
      206
      (gcd 40 (remainder 206 40))))

;; --> (gcd 40 (remainder 206 40))
(if (= (remainder 206 40) 0)) ;;<-- remainder is called once here
	40
	(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))

;; -->	(gcd (remainder 206 40) (remainder 40 (remainder 206 40)))
(if (= (remainder 40 (remainder 206 40)) 0) ;;<-- remainder called twice here [remainder 40 6]
  	(remainder 206 40)
	(gcd (remainder 40 (remainder 206 40)) 
	     (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))

;; -->  (gcd (remainder 40 (remainder 206 40)) (remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
(if (= (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) 0);; <-- remainder called four times here [remainder 6 4]
  	(remainder 40 (remainder 206 40))
	(gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40)))
	     (remainder ((remainder 40 (remainder 206 40))) ((remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))

;; --> (gcd (remainder (remainder 206 40) (remainder 40 (remainder 206 40))) (remainder ((remainder 40 (remainder 206 40))) ((remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))
(if (= (remainder ((remainder 40 (remainder 206 40))) ((remainder (remainder 206 40) (remainder 40 (remainder 206 40))))) 0) ;; <-- remainder called 7 times here [remainder 4 2]
	(remainder (remainder 206 40) (remainder 40 (remainder 206 40))) ;; <-- remainder called 4 times here
	(gcd (remainder ((remainder 40 (remainder 206 40))) ((remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))
	     (remainder ((remainder (remainder 206 40) (remainder 40 (remainder 206 40))))
			((remainder ((remainder 40 (remainder 206 40))) ((remainder (remainder 206 40) (remainder 40 (remainder 206 40)))))))))

;; TOTAL COUNT FOR NORMAL-ORDER EVALUATION = 1 + 2 + 4 + 7 +4 = 18 times

;; APPLICATIVE FORM FOR (gcd 206 40)
;; Count of remainder operations
;;

(gcd 206 40)
(gcd 40 (remainder 206 40)) ;; <-- called once
(gcd 40 6)
(gcd 6 (remainder 40 6)) ;; <-- called once
(gcd 6 4)
(gcd 4 (remainder 6 4)) ;; <-- called once
(gcd 4 2)
(gcd 2 (remainder 4 2)) ;; <-- called once
(gcd 2 0)

;;TOTAL COUNT FOR APPLICATIVE-ORDER EVALUATION = 1 + 1 + 1 + 1 = 4 TIMES
;;

