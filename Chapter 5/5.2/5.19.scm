#lang planet neil/sicp

(define (set-breakpoint machine label offset)
  ((machine 'set-breakpoint) label offset))

(define (cancel-breakpoint machine label offset)
  ((machine 'cancel-breakpoint) label offset))

(define (cancel-all-breakpoints machine)
  (machine 'cancel-all-breakpoints))

(define (proceed machine)
  (machine 'proceed))

(define (install-labels machine labels)
  ((machine 'install-labels) labels))

;; Modify update-insts to store all labels
(define (update-insts! insts labels machine)
  (let ((pc (get-register machine 'pc))
        (flag (get-register machine 'flag))
        (stack (machine 'stack))
        (ops (machine 'operations)))
    (install-labels machine labels) ;; ** INSTALL labels
    (for-each
     (lambda (inst)
       (set-instruction-execution-proc!
        inst
        (make-execution-procedure
         (instruction-text inst) labels machine pc flag stack ops)))
     insts)))

;; Instructions should know whether they have a breakpoint - 3rd parameter
(define (make-instruction text)
  (list text '() false))
(define (instruction-text inst) (car inst))
(define (instruction-execution-proc inst) (cadr inst))
(define (set-instruction-execution-proc! inst proc)
  (set-car! (cdr inst) proc))
(define (instruction-breakpoint? inst) (caddr inst))
(define (set-instruction-breakpoint! inst break?)
  (set-car! (cddr inst) break?))

;; Update make machine to leverage all these
(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (labels '())) ;; **
    (let ((the-ops
           (list (list 'initialize-stack
                       (lambda () (stack 'initialize)))
                 (list 'print-stack-statistics
                       (lambda () 
                         (stack 'print-statistics)))))
          (register-table
           (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error "Multiply defined register: " name)
            (set! register-table
                  (cons (list name (make-register name))
                        register-table)))
        'register-allocated)
      (define (lookup-register name)
        (let ((val (assoc name register-table)))
          (if val
              (cadr val)
              (error "Unknown register:" name))))
      (define (execute)
        (let ((insts (get-contents pc)))
          (if (null? insts)
              'done
              (begin                
                ((instruction-execution-proc (car insts)))
                (if (instruction-breakpoint? (car insts))
                    'breakpoint
                    (execute))))))
      (define (set-breakpoint label offset)
        (let* ((label-insts (lookup-label label))
               (break-inst (list-ref label-insts (- offset 1))))
          (if (not (null? break-inst))
              (set-instruction-breakpoint! break-inst true))))
      (define (cancel-breakpoint label offset)
        (let* ((label-insts (lookup-label label))
               (break-inst (list-ref label-insts (- offset 1))))
          (if (not (null? break-inst))
              (set-instruction-breakpoint! break-inst false))))
      (define (cancel-all-breakpoints)
        (for-each 
         (lambda (inst) 
           (set-instruction-breakpoint! inst false))
         the-instruction-sequence))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (λ (seq) (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (λ (ops) (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              ((eq? message 'install-labels) ;; **
               (λ (new-labels) (set! labels new-labels)))
              ((eq? message 'set-breakpoint) set-breakpoint)
              ((eq? message 'cancel-breakpoint) cancel-breakpoint)
              ((eq? message 'proceed) (execute))
              ((eq? message 'cancel-all-breakpoints) cancel-all-breakpoints)
              (else (error "Unknown request: MACHINE" message))))
      dispatch)))