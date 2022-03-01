;; frac-and-int.smt 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Solution to Exercise 36a

(Integer addSelector:withMethod: 'den
    (compiled-method () 1))

(Integer addSelector:withMethod: 'num
    (compiled-method () self))

(check-expect ((1 / 2) + 4) (9 / 2))
(check-expect ((5 / 2) + -1) (3 / 2))

(check-expect ((57 / 19) - 2) 1)
(check-assert (((1 / 2) - 2) isNegative))

(check-expect ((1 / 8) * 16) 2)
(check-expect ((5 / 1) * 3) 15)

(check-expect ((1 / 2) + 0) (1 / 2))
(check-expect ((1 / 2) - 0) (1 / 2))
(check-expect ((1 / 2) * 0) 0)

