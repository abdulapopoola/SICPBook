(define (pretty-print compiled-code)
  (if (not (null? compiled-code))
      (let ((first-instruction (car compiled-code)))
        (if (not (symbol? first-instruction)) ;; is not a label?
            (display "   ")
            (newline))
        (begin
              (print-to-screen first-instruction)
              (pretty-print (cdr compiled-code))
              (newline)))
      'OK))

(define (print-to-screen . values)
  (map 
   (lambda (value)
     (display value)
     (newline))
   values))

