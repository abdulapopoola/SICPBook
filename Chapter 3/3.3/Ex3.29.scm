#lang planet neil/sicp
;; Helpers
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
           (logical-and (get-signal a1) 
                        (get-signal a2))))
      (after-delay 
       and-gate-delay
       (lambda ()
         (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

(define (inverter input output)
  (define (invert-input)
    (let ((new-value 
           (logical-not (get-signal input))))
      (after-delay 
       inverter-delay
       (lambda ()
         (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)

;; De morgan's theorem AUB = !(!A n !B)

(define (or-gate2 a1 a2 output)
  (define (or-action-procedure)
    (let ((not-a1 (make-wire))
          (not-a2 (make-wire))
          (not-a1-and-a2 (make-wire)))
      (inverter a1 not-a1)
      (inverter a2 not-a2)
      (and-gate not-a1 not-a2 not-a1-and-a2)
      (inverter not-a1-and-a2 output)
      'ok))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)