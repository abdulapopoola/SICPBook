#lang planet neil/sicp

(define adjectives '(tall beautiful short good))

(define (parse-simple-noun-phrase)
  (amb 
   (list 'simple-noun-phrase
         (parse-word articles)
         (parse-word nouns))
   (list 'adjective-noun-phrase
         (parse-word articles)
         (parse-word adjectives)
         (parse-word nouns))))
         
