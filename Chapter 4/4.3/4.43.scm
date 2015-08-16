#lang racket

(define (father)
  (let ((Mary (amb 'Downing 'Hall 'Hood 'Parker 'Moore))
        (Gabrielle (amb 'Downing 'Hall 'Hood 'Parker 'Moore))
        (Lorna (amb 'Downing 'Hall 'Hood 'Parker 'Moore))
        (Rosalind (amb 'Downing 'Hall 'Hood 'Parker 'Moore))
        (Melissa (amb 'Downing 'Hall 'Hood 'Parker 'Moore)))
    (require (= Mary 'Moore))
    (require (and (not (= Gabrielle 'Moore))
                  (not (= Gabrielle 'Hood)))
    (require (not (= Lorna 'Moore)))
    (require (not (= Rosalind 'Hall)))
    (require (= Melissa 'Hood))   
    (list (list 'Mary Mary)
          (list 'Gabrielle Gabrielle)
          (list 'Lorna Lorna)
          (list 'Rosalind Rosalind)
          (list 'Melissa Melissa))))

;
