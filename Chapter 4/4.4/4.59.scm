#lang racket

; 1.
(meeting ?division (Friday . ?time))

; 2.
(rule (meeting-time ?person ?day-and-time)
      (or (meeting whole-company ?day-and-time)
          (and 
           (job ?person (?division . ?title))
           (meeting ?division ?day-and-time))))

; 3. 
(meeting-time (Alyssa P.Hacker) (Wednesday . ?time))