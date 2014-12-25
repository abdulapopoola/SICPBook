#lang planet neil/sicp

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) 
         (start-segment segment))
        ((frame-coord-map frame) 
         (end-segment segment))))
     segment-list)))

(define frame-outline (list (make-segment (make-vect 0 0)       (make-vect 0 0.99))
                          (make-segment (make-vect 0 0.99)    (make-vect 0.99 0.99))
                          (make-segment (make-vect 0.99 0.99) (make-vect 0.99 0))
                          (make-segment (make-vect 0.99 0)    (make-vect 0 0))))

(define outline (segments->painter frame-outline))

;; Same for remaining tasks, involves specifying coordinates, skipping