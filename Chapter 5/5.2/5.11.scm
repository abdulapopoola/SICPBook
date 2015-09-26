#lang planet neil/sicp

;;C is heavily influenced by Eli's solution
;; originally here: http://eli.thegreenplace.net/2008/02/23/sicp-section-52

;; A
(controller
   (assign continue (label fib-done))
 fib-loop
   (test (op <) (reg n) (const 2))
   (branch (label immediate-answer))
   ;; set up to compute Fib(n − 1)
   (save continue)
   (assign continue (label afterfib-n-1))
   (save n)           ; save old value of n
   (assign n 
           (op -)
           (reg n)
           (const 1)) ; clobber n to n-1
   (goto 
    (label fib-loop)) ; perform recursive call
 afterfib-n-1 ; upon return, val contains Fib(n − 1)
   (restore n)
   ;;(restore continue) ;; NOT NEEDED
   ;; set up to compute Fib(n − 2)
   (assign n (op -) (reg n) (const 2))
   ;;(save continue) ;; NOT NEEDED
   (assign continue (label afterfib-n-2))
   (save val)         ; save Fib(n − 1)
   (goto (label fib-loop))
 afterfib-n-2 ; upon return, val contains Fib(n − 2)   
   (restore n)      ; THIS ENSURES N IS NOW FIB(N-1) AND VAL IS FIB(N-2)
   (restore continue)
   (assign val        ; Fib(n − 1) + Fib(n − 2)
           (op +) 
           (reg val)
           (reg n))
   (goto              ; return to caller,
    (reg continue))   ; answer is in val
 immediate-answer
   (assign val 
           (reg n))   ; base case: Fib(n) = n
   (goto (reg continue))
 fib-done)


;; B
(define (make-save inst machine stack pc)
  (let ((reg (get-register 
              machine
              (stack-inst-reg-name inst))))
    (lambda ()
      (push stack (cons (get-contents reg) (stack-inst-reg-name inst)))
      (advance-pc pc))))

(define (make-restore inst machine stack pc)
  (let ((reg (get-register
              machine
              (stack-inst-reg-name inst)))
        (stack-top (pop stack)))
    (lambda ()
      (if (eq? (cadr stack-top)
               (stack-inst-reg-name inst))
          (begin
            (set-contents! reg (pop stack))
            (advance-pc pc))
          (error "Trying to restore from mismatched register"
                    (stack-inst-reg-name inst))))))

;; C
(define (make-stack)
  (let ((s '()))
    (define (push reg-name x)
      (let ((reg-stack (assoc reg-name s)))
        (if reg-stack
            (set-cdr! reg-stack (cons x (cdr reg-stack)))
            (error "Trying to push on non-existent stack"))))
    (define (pop reg-name)
      (let ((reg-stack (assoc reg-name s)))
        (if reg-stack
            (let ((top (cadr reg-stack)))
              (set-cdr! reg-stack (cddr reg-stack))
              top))
        (error "POP: Stack register is empty " (car reg-stack))))
    (define (add-new-reg-stack reg-name)
      (if (assoc reg-name s)
        (error "Stack already exists for " reg-name)
        (set! s (cons (cons reg-name '()) s))))
    (define (initialize)
       (for-each
        (lambda (stack)
          (set-cdr! stack '()))
        s)
      'done)
    (define (dispatch message)
      (cond ((eq? message 'push) push)
            ((eq? message 'pop) (pop))
            ((eq? message 'add-reg-stack) add-reg-stack)            
            ((eq? message 'initialize) 
             (initialize))
            (else 
             (error "Unknown request: STACK"
                    message))))
    dispatch))

(define (pop stack reg-name)
  ((stack 'pop) reg-name))

(define (push stack reg-name value)
  ((stack 'push) reg-name value))

(define (create-register-stack stack reg-name)
  ((stack 'add-reg-stack) reg-name))

(define (allocate-register name)
  (if (assoc name register-table)
    (error "Multiply defined register: " name)
    (begin
      (set! register-table 
            (cons (list name (make-register name))
                  register-table))
      (create-register-stack stack reg-name)
      'register-allocated)))

(define (make-save inst machine stack pc)
  (let ((reg (get-register 
              machine
              (stack-inst-reg-name inst))))
    (lambda ()
      (push stack (stack-inst-reg-name inst) (get-contents reg))
      (advance-pc pc))))

(define (make-restore inst machine stack pc)
  (let ((reg (get-register machine reg-name)))
    (lambda ()
      (set-contents! reg (pop stack (stack-inst-reg-name inst)))
      (advance-pc pc))))