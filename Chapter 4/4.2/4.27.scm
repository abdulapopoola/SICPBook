(define count 0)
(define (id x) (set! count (+ count 1)) x)

(define w (id (id 10)))

;;; L-Eval input:
count
;; returns 1

;;; L-Eval value:
1

;;; L-Eval input:
w

;;; L-Eval value:
10

;;; L-Eval input:
count

;;; L-Eval value:
2

;; When the first count is evaluated then it is 1 because the
;; first id call has been evaluated even though w still wraps another id call.

;; On calling w, its thunk is forced and this invokes anothe call to count
;; thereby incrementing it once again