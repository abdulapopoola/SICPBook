(load "compiler.scm")

(define (compile exp target linkage)
  (cond ((self-evaluating? exp)
         (compile-self-evaluating exp target linkage))
        ((quoted? exp) 
         (compile-quoted exp target linkage))
        ((variable? exp)
         (compile-variable exp target linkage))
        ((assignment? exp)
         (compile-assignment exp target linkage))
        ((definition? exp)
         (compile-definition exp target linkage))
        ((open-coded? exp)
         (compile-open-coded exp target linkage))
        ((if? exp)
         (compile-if exp target linkage))
        ((lambda? exp)
         (compile-lambda exp target linkage))
        ((begin? exp)
         (compile-sequence (begin-actions exp) target linkage))
        ((cond? exp) 
         (compile (cond->if exp) target linkage))
        ((application? exp)
         (compile-application exp target linkage))
        (else
         (error "Unknown expression type: COMPILE" exp))))

(define (open-coded? exp)
  (and (pair? exp)
       (memq (car exp) '(+ - / *))))

(define (var-arg-open-coded? exp)
  (and (pair? exp)
       (memq (car exp) '(+ *))))
  
(define (spread-arguments list1 list2)
  (let ((code1 (compile list1 'arg1 'next))
        (code2 (compile list2 'arg2 'next)))
    (list code1 code2)))

(define (compile-open-coded exp target linkage)
  (if (or (var-arg-open-coded? exp)
          (= (length exp) 3))
      (let ((op (car exp))
            (first-operand (cadr exp))
            (rest-operands (cddr exp)))
        (preserving '(env continue)
                    (compile first-operand 'arg1 'next)
                    (compile-open-coded-rest-args op rest-operands target linkage)))
      (error "Expected a binary operation!" exp)))

(define (compile-open-coded-rest-args exp operands target linkage)
  (if (null? (cdr operands))
      (preserving '(arg1 continue)
                  (compile (car operands) 'arg2 'next)
                  (end-with-linkage
                   linkage
                   (make-instruction-sequence 
                    '(arg1 arg2) 
                    (list target)
                    `((assign ,target (op exp) (reg arg1) (reg arg2))))))
      (preserving '(env continue)
                  (preserving '(arg1)
                              (compile (car operands) 'arg2 'next)
                              (make-instruction-sequence
                               '(arg1 arg2)
                               '(arg1)
                               `((assign arg1 (op exp) (reg arg1) (reg arg2)))))
                  (compile-open-coded-rest-args exp (cdr operands) target linkage))))

(define code (compile
              '(+ 1 2 3 4)
               'val
               'next))

(pretty-print code)