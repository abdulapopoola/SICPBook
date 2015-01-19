#lang racket

;; SOLUTION IS heavily influenced by solution here:
;; https://github.com/abdulapopoola/p2pu-sicp/blob/master/2.4/2.74.scm
;; Also is racket

;;HELPERS
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: 
              TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: 
              CONTENTS" datum)))

;; SAMPLE DATA
(define div1
  '(tech
    ("John Doe" "12 John Street" 1000)
    ("Jane Smith" "13 Jane Street" 2000)))

(define div2
  '(finance
    (0 "Fulan He" "1 Fulan Street" 3000)
    (1 "Tani She" "2 Tani Street" 4000)))

;; A hash table to hold file reading operations:
(define file-ops (make-hash))

;; Getter and setter to access the hash table:
(define (get op type)
  (hash-ref file-ops (list op type) false))
(define (set op type proc)
  (hash-set! file-ops (list op type) proc))

;; 1
(define (get-record name file)
  ((get 'employee (type-tag file)) name (contents file)))

(set 'employee 'tech
     (lambda (name records)
       (let ((result (filter (lambda (record) 
                               (equal? (car record) name))
                             records)))
         (if (empty? result)
             false
             (car result)))))

(set 'employee 'finance
     (lambda (name records)
       (let ((result (filter (lambda (record) 
                               (equal? (cadr record) name))
                             records)))
         (if (empty? result)
             false
             (cadar result)))))            

;; 2
(define (get-salary name file)
  ((get 'salary (type-tag file)) name (contents file)))

(set 'salary 'tech
     (lambda (name file)
       (let ((result (filter (lambda (record) 
                               (equal? (car record) name))
                             file)))
         (if (empty? result)
             false             
             (caddr (car result))))))

(set 'salary 'finance
     (lambda (name file)
       (let ((result (filter (lambda (record) 
                               (equal? (cadr record) name))
                             file)))
         (if (empty? result)
             false
             (cadddr (car result))))))

(get-record "John Doe" div1)
(get-salary "John Doe" div1)
(get-record "Fulan He" div2)
(get-salary "Fulan He" div2)
;; 3
(define (true? x) (not (false? x)))

(define (find-employee-record name files)
  (let ((result (filter true?
                        (map (lambda (file) 
                               (get-record name file))
                               files))))
    (if (empty? result)
	"Employee not found"
	result)))

(find-employee-record "John Doe" (list div1 div2))

;;4 
;; The new company should just add set and get operations to the existing
;; hash table.