;; Evaluation of combination operands occurs from right to left. 
;; In the SICP text, the need for this is explained and quoted below:

;; ` The code to construct the argument list will evaluate each operand 
;; into val and then cons that value onto the argument list being 
;; accumulated in argl. Since we cons the arguments onto argl in sequence,
;; we must start with the last argument and end with the first, so that the
;; arguments will appear in order from first to last in the resulting list.`

;; To change to a left-to-right evaluation order, we can change the construct
;; arglist method 

(define (construct-arglist operand-codes)
  (let ((operand-codes operand-codes))  ;;Remove reversal
    (if (null? operand-codes)
        (make-instruction-sequence 
         '() 
         '(argl)
         '((assign argl (const ()))))
        (let ((code-to-get-last-arg
               (append-instruction-sequences
                (car operand-codes)
                (make-instruction-sequence 
                 '(val)
                 '(argl)
                 '((assign argl
                           (op list)
                           (reg val)))))))
          (if (null? (cdr operand-codes))
              code-to-get-last-arg
              (preserving 
               '(env)
               code-to-get-last-arg
               (code-to-get-rest-args
                (cdr operand-codes))))))))