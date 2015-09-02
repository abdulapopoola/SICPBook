#lang planet neil/sicp

(rule (reverse (?a) (?a)))
(rule (reverse (?x . ?y) ?z)
      (and (reverse ?y ?y-reversed)
           (append-to-form ?y-reversed (?x) ?z)))

(rule (ends-with-grandson ?list)
      (and (reverse ?list ?reversed-list)
           ((grandson . ?rest) ?reversed-list)))

(rule ((great . ?rel) ?x ?y)
      (and (ends-with-grandson ?rel)
           (son ?x son-of-x)
           (?rel son-of-x ?y)))
      