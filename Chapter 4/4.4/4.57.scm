#lang racket

(rule (can-replace ?person-1 ?person-2)
      (and (or (and (job ?person-1 ?job)
                    (job ?person-2 ?job))
               (and (job ?person-1 ?job1)
                    (job ?person-2 ?job2)
                    (can-do-job ?job1 ?job2)))
           (not (same ?person-1 ?person-2))))

(can-replace ?person (Cy D.Fect))

(and (can-replace ?person1 ?person2)
     (salary ?person1 v1)
     (salary ?person2 v2)
     (lisp-value < v1 v2))