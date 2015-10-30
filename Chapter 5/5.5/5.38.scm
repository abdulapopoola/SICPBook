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
  (if (= (length exp) 3)
    (let ((op (car exp))
          (args (spread-arguments (cadr exp) (caddr exp))))
      (end-with-linkage linkage
        (append-instruction-sequences
          (car args)
          (preserving '(arg1)
            (cadr args)
            (make-instruction-sequence '(arg1 arg2) (list target)
              `((assign ,target (op ,op) (reg arg1) (reg arg2))))))))
    (error "Expected a 3-element list -- COMPILE-OPEN-BINARY-OP" exp)))

(define code (compile
              '(+ 1 2)
               'val
               'next))

(pretty-print code)