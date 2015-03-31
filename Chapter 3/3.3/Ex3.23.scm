#lang planet neil/sicp

;; Helpers
(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) 
  (set-car! queue item))
(define (set-rear-ptr! queue item) 
  (set-cdr! queue item))
(define (empty-queue? queue) 
  (null? (front-ptr queue)))
(define (make-queue) (cons '() '()))
(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an 
              empty queue" queue)
      (car (front-ptr queue))))
(define (insert-queue! queue item front-of-queue)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (front-of-queue
           (set-cdr! new-pair (front-ptr queue))
           (set-front-ptr! queue new-pair)
           queue)
          (else (set-cdr! (rear-ptr queue) 
                          new-pair)
                (set-rear-ptr! queue new-pair)
                queue))))
(define (front-insert-queue! queue item)
  (insert-queue! queue item true))
(define (rear-insert-queue! queue item)
  (insert-queue! queue item false))
(define (delete-queue! queue front-of-queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with 
                 an empty queue" queue))
        (front-of-queue
         (set-front-ptr! queue 
               (cdr (front-ptr queue)))
              queue)
        (else (set-rear-ptr! queue '())
              queue)))
(define (front-delete-queue! queue)
  (delete-queue! queue true))
(define (rear-delete-queue! queue)
  (delete-queue! queue false))

(define (print-queue queue)
  (if (empty-queue? queue)
      (display '())
      (display (front-ptr queue))))

(define q1 (make-queue))
(print-queue q1)

(front-insert-queue! q1 'a)
(print-queue q1)

(rear-insert-queue! q1 'b)
(print-queue q1)

(front-delete-queue! q1)
(print-queue q1)

(rear-delete-queue! q1)
(print-queue q1)

(empty-queue? q1)

(car q1)