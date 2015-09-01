#lang racket
;; The method might fail for queries that return duplicate results
;; like the who? query of the preceding exercise.

;; Thus the answer would be wrong if he tried to sum it up.

;; A better approach would be to introduce some sort of filter that
;; ensures that there are no duplicates