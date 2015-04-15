;; COPIED from Sarabander's excellent solution here
;; https://github.com/sarabander/p2pu-sicp/blob/master/3.3/3.26.scm
;; Small modifications made

#lang planet neil/sicp

(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))

(define (same-key? key1 key2)
  (define tolerance 0.01)
  (if (and (number? key1) (number? key2))
      (< (abs (- key1 key2)) tolerance)
      (equal? key1 key2)))

(define (lt key1 key2)
  (compare < key1 key2))

(define (gt key1 key2)
  (compare > key1 key2))

(define (compare compare-type key1 key2)
  (define (get-operator compare-op value-type)
    (cond ((eq? value-type 'number)
           (if (eq? compare-op <)
               <
               >))
          ((eq? value-type 'string)
           (if (eq? compare-op <)
               string<?
               string>?))
          (else (error "Wrong value-type and compare-ops passed in"))))        
  (if (and (number? key1) (number? key2))
      ((get-operator compare-type 'number) key1 key2)
      ((get-operator compare-type 'string) (tostring key1) (tostring key2))))

(define (tostring val)
  (cond ((string? val) val)
	((symbol? val) (symbol->string val))
	((number? val) (number->string val))
	(else (error "tostring: argument must be an atom, given" val))))

(define (make-table)
  (let ((local-table (list '*table* (list 0))))
    (define tablekey car)
    (define value cdr)
    (define (lookup key)
      (assoc #f key 'void (cadr local-table)))
    (define (insert! key val)
      (assoc #t key val (cadr local-table))
      'ok)
    ;; For both reading and writing the value under a key 
    ;; in associative map organized as a binary tree:
    (define (assoc write? key val tree)
      (cond ((and (number? (car tree))
		  (zero? (car tree)))
	     (if write? 
		 (begin (set-car! tree (cons key val))
			(set-cdr! tree (list (list 0) (list 0))))
		 false))
	    ((same-key? key (tablekey (entry tree)))
	     (if write? 
		 (set-cdr! (entry tree) val)
		 (value (entry tree))))
	    ((lt key (tablekey (entry tree)))
	     (assoc write? key val (left-branch tree)))
	    ((gt key (tablekey (entry tree)))
	     (assoc write? key val (right-branch tree)))
	    (else (error "This location should be unreachable."))))
    (define (dispatch m)
      (cond ((eq? m 'lookup) lookup)
	    ((eq? m 'insert!) insert!)
	    ((eq? m 'table) local-table)
	    ((eq? m 'tree) (cadr local-table))
	    (else (error "Unknown operation - TABLE" m))))
    dispatch))

;; Tests
(define tbl4 (make-table))

(tbl4 'table) ; (*table* (0))
(tbl4 'tree)  ; (0)

((tbl4 'insert!) 1 "green")
((tbl4 'insert!) 2 "orange")

((tbl4 'lookup) 1) ; "green"
((tbl4 'lookup) 2) ; "orange"

((tbl4 'insert!) 2 "yellow")
((tbl4 'insert!) 0 "blue")

(tbl4 'tree)
; ((1 . "green") ((0 . "blue") (0) (0)) ((2 . "yellow") (0) (0)))

((tbl4 'insert!) 'w "white")
((tbl4 'insert!) "bl" "black")

(tbl4 'tree)
; ((1 . "green") ((0 . "blue") (0) (0)) ((2 . "yellow") (0) 
; ((w . "white") (("bl" . "black") (0) (0)) (0))))
