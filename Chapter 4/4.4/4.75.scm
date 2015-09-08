#lang planet neil/sicp

;; Influenced by solution at
;; https://github.com/skanev/playground/blob/master/scheme/sicp/04/75.scm

(define (uniquely-asserted query frame-stream)
  (stream-flatmap
   (lambda (frame)
     (let ((result (qeval (car query) (singleton-stream frame))))
       (cond ((stream-empty? result) empty-stream)
             ((not (stream-empty? (stream-rest result))) empty-stream)
             (else (singleton-stream (stream-first result))))))
   frame-stream))

(put 'unique 'qeval uniquely-asserted)

(define supervises-only-one-person 
  (and (supervisor ?s ?x)
        (unique (supervisor ?z ?x))))