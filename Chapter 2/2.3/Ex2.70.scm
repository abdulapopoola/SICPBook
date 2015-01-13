#lang planet neil/sicp
(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set 
         (make-leaf (car pair)    ; symbol
                    (cadr pair))  ; frequency
         (make-leaf-set (cdr pairs))))))


(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) 
         (cons x set))
        (else 
         (cons (car set)
               (adjoin-set x (cdr set))))))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: 
               CHOOSE-BRANCH" bit))))

(define (make-leaf symbol weight)
  (list 'leaf symbol weight))
(define (leaf? object)
  (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch 
                (car bits) 
                current-branch)))
          (if (leaf? next-branch)
              (cons 
               (symbol-leaf next-branch)
               (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) 
                        next-branch)))))
  (decode-1 bits tree))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) 
                (symbols right))
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (encode message tree)
  (if (null? message)
      '()
      (append 
       (encode-symbol (car message) 
                      tree)
       (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((member symbol (symbols (left-branch tree)))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((member symbol (symbols (right-branch tree)))
         (cons 1 (encode-symbol symbol (right-branch tree))))
        (else (error "Symbol not found in tree" symbol))))


(define (successive-merge pairs)
  (if (= (length pairs) 1)
      (car pairs)
      (successive-merge
       (adjoin-set (make-code-tree (car pairs)
                                   (cadr pairs)) 
                   (cddr pairs)))))

(define (generate-huffman-tree pairs)
  (successive-merge 
   (make-leaf-set pairs)))

(define tree '((A 2) (BOOM 1) (GET 2) (JOB 2)
               (NA 16) (SHA 3) (YIP 9) (WAH 1)))

(define message 
  '(GET A JOB
        SHA NA NA NA NA NA NA NA NA
        GET A JOB
	SHA NA NA NA NA NA NA NA NA
	WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
	SHA BOOM))

(display (encode message (generate-huffman-tree tree)))

;; (1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0
;;  1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1
;;  0 1 0 1 0 1 1 1 0 1 1 0 1 1)

(newline)
(length (encode message (generate-huffman-tree tree))) ;;84 bits

;; A fixed length code will require 3 (log8) * 36 (length of message)
;; 108 bits