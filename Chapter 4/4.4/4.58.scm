#lang racket

(rule (big-shot ?person)
      (and (supervisor ?person ?super)
           (job ?person (?division . ?a))
           (job ?super (?super-div . ?a))
           (not (same ?division ?super-div))))