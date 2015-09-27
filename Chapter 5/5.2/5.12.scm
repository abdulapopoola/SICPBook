#lang planet neil/sicp

(define (assemble controller-text machine)
  (extract-labels controller-text
    (lambda (insts labels)
      (update-insts! insts labels machine)
      ;Only store insts if prior step succeeded
      (update-instruction-info insts machine)
      insts)))

(define (make-new-machine)
  (let ((pc (make-register 'pc))
        (flag (make-register 'flag))
        (stack (make-stack))
        (the-instruction-sequence '())
        (instructions '(() () ())))
    (let ((the-ops
           (list (list 'initialize-stack
                  (lambda () (stack 'initialize)))))
          (register-table
           (list (list 'pc pc) (list 'flag flag))))
      (define (allocate-register name)
        (if (assoc name register-table)
            (error 
             "Multiply defined register: " 
             name)
            (set! register-table
                  (cons 
                   (list name (make-register name))
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
                (execute)))))
      (define (set-instructions insts)
        (set! instructions insts))
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
              ((eq? message 'get-used-instructions) (car instructions))
              ((eq? message 'get-goto-regs) (cadr instructions))
              ((eq? message 'get-save-restore-regs) (caddr instructions))
              ((eq? message 'set-instructions) set-instructions)              
              (else (error "Unknown request: MACHINE" message))))
      dispatch)))

(define (get-all-instructions machine)
  (machine 'get-used-instructions))

(define (get-goto-instructions machine)
  (machine 'get-goto-regs))

(define (get-save-restore-instructions machine)
  (machine 'get-save-restore-regs))

(define (set-instruction-info machine insts)
  ((machine 'set-instructions) insts))

(define (get-sorted-instructions insts)
  (let* ((sorted-instructions '()))
    (map 
     (lambda (inst)
       (let ((inst-name (symbol->string (car inst))))
         (if (not (member inst-name sorted-instructions))
             (set! sorted-instructions 
                   (cons inst-name sorted-instructions)))))
     insts)
    (sort sorted-instructions string<)))

;; B - entry points
(define (is-goto-register-inst? inst)
  (and (eq? (car inst) 'goto)
       (eq? (caadr inst) 'reg)))

(define (get-goto-registers insts)
  (let ((registers '()))
    (map
      (lambda (inst)
        (set! registers (cons (cdadr inst) registers)))
      (filter (lambda (inst) 
                (is-goto-register-inst? inst)) 
              insts))
    registers))

;; C - save / restore registers
(define (is-save-or-restore-inst? inst)
  (or (eq? (car inst) 'save)
      (eq? (car inst) 'restore)))

(define (get-save-restore-registers insts)
  (let ((registers '()))
    (map
      (lambda (inst)
        (set! registers (cons (cadr inst) registers)))
      (filter (lambda (inst) 
                (is-save-or-restore-inst? inst)) 
              insts))
    registers))

; insert in machine
(define (update-instruction-info insts machine)
  (let ((sorted-insts (get-sorted-instructions insts))
        (goto-registers (get-goto-registers insts))
        (save-restore-registers (get-save-restore-registers insts)))
    (set-instruction-info 
     machine 
     (list sorted-insts goto-registers save-restore-registers))))
        
  