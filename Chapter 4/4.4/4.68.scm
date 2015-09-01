#lang planet neil/sicp

(rule (reverse (?a) (?a)))
(rule (reverse (?x . ?y) ?z)
      (and (reverse ?y ?y-reversed)
           (append-to-form ?y-reversed (?x) ?z)))