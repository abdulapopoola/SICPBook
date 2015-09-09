#lang planet neil/sicp

(define (merge-frames f1 f2)
  (cond ((null? f1) f2)
        ((eq? 'failed f2) 'failed)
        (else 
         (let ((var (binding-variable (car f1)))
               (val (binding-value (car f1))))
           (let ((extension (extend-if-possible var val f2)))
             (merge-frames (cdr f1) extension))))))

(define (merge-frame-streams stream1 stream2)
  (stream-flatmap
   (lambda (f1)
     (stream-filter
      (lambda (f) (not (eq? f 'failed)))
      (stream-map
       (lambda (f2) (merge-frames f1 f2))
       stream2)))
   stream1))

(define (conjoin-v2 conjuncts frame-stream)
  (if (empty-conjunction? conjuncts)
      frame-stream
      (merge-frame-streams
        (qeval (first-conjunct conjuncts) frame-stream)
        (conjoin (rest-conjuncts conjuncts) frame-stream))))