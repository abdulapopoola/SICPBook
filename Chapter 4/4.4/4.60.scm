#lang racket

(rule (lives-near ?person-1 ?person-2)
      (and (address ?person-1 
                    (?town . ?rest-1))
           (address ?person-2 
                    (?town . ?rest-2))
           (not (same ?person-1 ?person-2))))

;; This happens because there is no ordering for the person lists
;; Thus it would find all possible pairs twice. If we enforce
;; some ordering (e.g. alphabetical or otherwise) on the people names
;; then it would eliminate the symmetry and result in unique values.
;; NOTE: using the length of names would not work here as two people
;; with equivalent name lengths will appear twice.

;; This solution was derived from the solutions appearing at the links
;; below:
;; https://github.com/skanev/playground/blob/master/scheme/sicp/04/60.scm
;; http://eli.thegreenplace.net/2008/02/08/sicp-section-441

(rule (ordered-lives-near ?person-1 ?person-2)
      (and (lives-near ?person-1 ?person-2)
           (lisp-value (lambda (person-1 person-2)
                         (string<? (string-join (map symbol->string person-1) " ")
                                   (string-join (map symbol->string person-2) " ")))
                       ?person-1
                       ?person-2)))