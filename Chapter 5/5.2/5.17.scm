#lang planet neil/sicp

(define (make-instruction text)
  (list text '() '()))
(define (make-labeled-instruction text label)
  (list text label '()))
(define (instruction-text inst) (car inst))
(define (instruction-label inst) (cadr inst))
(define (instruction-execution-proc inst) (caddr inst))
(define (set-instruction-label! inst label) 
  (set-cdr! inst label))
(define (set-instruction-execution-proc! inst proc)
  (set-car! (cddr inst) proc))

(define (extract-labels text receive)
  (if (null? text)
      (receive '() '())
      (extract-labels 
       (cdr text)
       (lambda (insts labels)
         (let ((next-inst (car text)))
           (if (symbol? next-inst)
               (begin
                 (if (not (null? insts))
                     (set-instruction-label! (car insts) next-inst))
                 (receive insts
                          (cons (make-label-entry next-inst insts)
                                labels)))
               (receive 
                   (cons (make-instruction next-inst)
                         insts)
                   labels)))))))

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (trace-instructions false)) ;; **
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
                (if trace-instructions ;; **
                    (if (not (null? (instruction-label (car insts))))
                        (display "TRACE (LABEL) : " (instruction-label (car insts))))
                    (display "TRACE: " (instruction-text (car insts))))
                ((instruction-execution-proc (car insts)))
                (execute)))))
      (define (dispatch message)
        (cond ((eq? message 'start)
               (set-contents! pc the-instruction-sequence)
               (execute))
              ((eq? message 'install-instruction-sequence)
               (lambda (seq) 
                 (set! the-instruction-sequence seq)))
              ((eq? message 'allocate-register) allocate-register)
              ((eq? message 'get-register) lookup-register)
              ((eq? message 'install-operations)
               (lambda (ops) 
                 (set! the-ops (append the-ops ops))))
              ((eq? message 'stack) stack)
              ((eq? message 'operations) the-ops)
              ((eq? message 'trace-on) ;; **
               (set! trace-instructions true))
              ((eq? message 'trace-off) ;; **
               (set! trace-instructions false))
              (else (error "Unknown request: MACHINE" message))))
      dispatch)))