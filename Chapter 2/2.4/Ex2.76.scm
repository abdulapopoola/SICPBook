#lang planet neil/sicp

;; If new operations are frequently added, then the 
;; message passing approach is best suited as it requires
;; only specifying the new method.

;; For systems involving new types, then the data directed
;; approach is best; all that is required for new types are
;; the get and set handlers.

;; The generic method requires the most invasive changes and
;; will also be difficult to maintain.
