(define (get-frame-and-index index var env)  
  (if (member? var (first-frame env))
      (cons index (first-frame env))
      (get-frame-and-index (+ index 1) var (enclosing-environment env))))

(define (get-value-index index var frame-values)  
  (if (eq? var (car frame-values))
      index
      (get-value-index (+ index 1) var (cdr frame-values))))

(define (find-variable var env)
  (let* ((frame-index (get-frame-and-index 0 var env))
         (value-index (get-value-index 0 var (cdr frame-index))))
    (cons (car frame-index) value-index)))
  
  