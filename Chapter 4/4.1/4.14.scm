;; It fails because the custom interpreter passes its own variables
;; to the system version. However the system version does not understand
;; such and blows up.

;; Eva Lu Ator's approach works because the underlying system is not invoked
;; rather the values are all interpreted in the same custom interpreter