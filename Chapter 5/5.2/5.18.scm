#lang planet neil/sicp

(define (make-register name)
  (let ((contents '*unassigned*)
        (trace-register false))
    (define (dispatch message)
      (cond ((eq? message 'get) contents)
            ((eq? message 'set)
               (lambda (value)
                 (if trace-register
                     (begin 
                       (display "REGISTER: " name)
                       (display "ORIGINAL VALUE: " contents)
                       (display "NEW VALUE: " value)))
                 (set! contents value)))
            ((eq? message 'trace-on)
             (set! trace-register true))
            ((eq? message 'trace-off)
             (set! trace-register false))
            (else
             (error "Unknown request:  REGISTER" message))))
    dispatch))

(define (get-contents register)
  (register 'get))

(define (set-contents! register value)
  ((register 'set) value))

(define (trace-on register)
  (register 'trace-on))

(define (trace-off register)
  (register 'trace-off))

;; EXTENSION TO MAKE NEW MACHINE shown with ;; **

(define (make-new-machine)
  (define register-trace-proc (lambda (name old new) (void)))
  (define (trace name old new)
    (register-trace-proc name old new))
  (let ((pc (make-register 'pc trace))
        (flag (make-register 'flag trace))
        (stack (make-stack))
        (the-instruction-sequence '()))
    (let ((the-ops (list (list 'initialize-stack
                               (lambda () (stack 'initialize)))))
          (register-table (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: " name)
            (set! register-table (cons (list name (make-register name trace))
                                       register-table)))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register: " name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin
                ((instruction-execution-proc (car insts)))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              ((eq? message 'install-register-trace-proc)
               (lambda (proc) (set! register-trace-proc proc)))
              ((eq? message 'register-trace-on) ;; **
               (lambda (reg-name) (trace-on (lookup-register reg-name))))
              ((eq? message 'register-trace-off) ;; **
               (lambda (reg-name) (trace-off (lookup-register reg-name))))
              (else (error "Unknown request: MACHINE" message))))
      dispatch)))