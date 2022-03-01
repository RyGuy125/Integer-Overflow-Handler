;; George Sidamon-Eristoff
;; Ryan Dreher
;; 3 May 2021

;; ideas and template credits for this document to bignums-smt.pdf

(use bignum.smt)

(SmallInteger addSelector:withMethod: 'asLargeInteger
        (compiled-method () (LargeInteger fromSmall: self)))



;; partial credits bignums-smt.pdf
(SmallInteger addSelector:withMethod: 'multiplyBySmallInteger:
    (compiled-method (aSmallInteger)
        ((primitive mulWithOverflow self aSmallInteger
            {((self asLargeInteger) * aSmallInteger)}) value)))

(SmallInteger addSelector:withMethod: 'multiplyByLargePositiveInteger:
        (compiled-method (aLargeInteger)
            ((self asLargeInteger) * aLargeInteger)))

(SmallInteger addSelector:withMethod: 'multiplyByLargeNegativeInteger:
        (compiled-method (aLargeInteger)
            ((self asLargeInteger) * aLargeInteger)))

(SmallInteger addSelector:withMethod: '*
        (compiled-method (n)
            (n multiplyBySmallInteger: self)))

(LargeInteger addSelector:withMethod: 'multiplyBySmallInteger:
        (compiled-method (aSmallInteger)
            (self * (aSmallInteger asLargeInteger))))



(SmallInteger addSelector:withMethod: 'addSmallIntegerTo:
        (compiled-method (aSmallInteger)
            ((primitive addWithOverflow self aSmallInteger
                {((self asLargeInteger) + aSmallInteger)}) value)))

(SmallInteger addSelector:withMethod: 'addLargePositiveIntegerTo:
        (compiled-method (aLargeInteger)
            ((self asLargeInteger) + aLargeInteger)))

(SmallInteger addSelector:withMethod: 'addLargeNegativeIntegerTo:
        (compiled-method (aLargeInteger)
            ((self asLargeInteger) + aLargeInteger)))

(SmallInteger addSelector:withMethod: '+
        (compiled-method (n)
            (n addSmallIntegerTo: self)))

(LargeInteger addSelector:withMethod: 'addSmallIntegerTo:
        (compiled-method (aSmallInteger)
            (self + (aSmallInteger asLargeInteger))))


(SmallInteger addSelector:withMethod: 'negated
        (compiled-method ()
            ((primitive subWithOverflow 0 self
                {(0 - self)}) value)))

(SmallInteger addSelector:withMethod: '-
        (compiled-method (n)
            (self + (n negated))))




;; Step 4.3
        (check-print ( 5 *  4)  20)
        (check-print (-5 *  4) -20)
        (check-print ( 5 * -4) -20)
        (check-print (-5 * -4)  20)

        (check-print ( 5 * ( 4 asLargeInteger))  20)
        (check-print ( 5 * (-4 asLargeInteger)) -20)
        (check-print (-5 * ( 4 asLargeInteger)) -20)
        (check-print (-5 * (-4 asLargeInteger))  20)

        (check-print (( 4 asLargeInteger) *  5)  20)
        (check-print (( 4 asLargeInteger) * -5) -20)
        (check-print ((-4 asLargeInteger) *  5) -20)
        (check-print ((-4 asLargeInteger) * -5)  20)


;; Step 4.5
        (check-print ( 5 +  4)  9)
        (check-print (-5 +  4) -1)
        (check-print ( 5 + -4)  1)
        (check-print (-5 + -4) -9)

        (check-print ( 5 + ( 4 asLargeInteger))  9)
        (check-print ( 5 + (-4 asLargeInteger))  1)
        (check-print (-5 + ( 4 asLargeInteger)) -1)
        (check-print (-5 + (-4 asLargeInteger)) -9)

        (check-print (( 4 asLargeInteger) +  5)  9)
        (check-print (( 4 asLargeInteger) + -5) -1)
        (check-print ((-4 asLargeInteger) +  5)  1)
        (check-print ((-4 asLargeInteger) + -5) -9)

;; Step 4.7 in longtests.smt

;; Step 4.9
(Integer addSelector:withMethod: 'times10
    (compiled-method () [locals two four]
        (set two (self + self))
        (set four (two + two))
        ((four + four) + two)))

        (check-print (((10101 times10) times10) times10) 10101000)
        (check-print (((((32767 times10) times10) times10) times10) times10)
                     3276700000)
        (check-print (((((-32767 times10) times10) times10) times10) times10)
                     -3276700000)
        (check-print ( 2147483647 +  2147483645)  4294967292)
        (check-print (-2147483647 + -2147483645) -4294967292)


;; Step 4.10, some tests in longtests.smt
        (check-print (-2147483647 -  2147483645) -4294967292)
        (check-print ( 2147483647 - -2147483645)  4294967292)


