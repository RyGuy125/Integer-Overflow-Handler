;; George Sidamon-Eristoff
;; Ryan Dreher
;; 3 May 2021

;; LargeIntTests.smt
;; Tests for Problem 38

    ;; Step 3.8
        (check-assert  ((LargeInteger fromSmall: 5) isNonnegative))
        (check-assert  ((LargeInteger fromSmall: 5) isStrictlyPositive))
        (check-assert (((LargeInteger fromSmall: 5) isNegative) not))


        (check-assert  ((LargeInteger fromSmall: 0) isNonnegative))
        (check-assert (((LargeInteger fromSmall: 0) isStrictlyPositive) not))
        (check-assert (((LargeInteger fromSmall: 0) isNegative) not))


    ;; Step 3.10
        (check-assert  (((LargeInteger fromSmall: 0) negated) isNonnegative))
        (check-assert ((((LargeInteger fromSmall: 0) negated) isStrictlyPositive) not))
        (check-assert ((((LargeInteger fromSmall: 0) negated) isNegative) not))


        (check-assert ((((LargeInteger fromSmall: 5) negated) isNonnegative) not))
        (check-assert ((((LargeInteger fromSmall: 5) negated) isStrictlyPositive) not))
        (check-assert  (((LargeInteger fromSmall: 5) negated) isNegative))

        (check-print ((LargeInteger fromSmall: 32768) negated) -32768)
        (check-print ((LargeInteger fromSmall: 1203983473) negated) -1203983473)
        (check-print ((LargeInteger fromSmall: 5) negated) -5)

        (check-print (((LargeInteger fromSmall: 32768) negated) negated) 32768)
        (check-print (((LargeInteger fromSmall: 1203983473) negated) negated) 1203983473)
        (check-print (((LargeInteger fromSmall: 5) negated) negated) 5)

        (check-print ((LargeInteger fromSmall: 0) negated) 0)
        (check-print (((LargeInteger fromSmall: 0) negated) negated) 0)

    ;; Step 3.12
        (check-print  ((LargeInteger fromSmall: 4)          * (LargeInteger fromSmall: 5)) 20)
        (check-print (((LargeInteger fromSmall: 4) negated) * (LargeInteger fromSmall: 5)) -20)
        (check-print  ((LargeInteger fromSmall: 4)          * ((LargeInteger fromSmall: 5) negated)) -20)
        (check-print (((LargeInteger fromSmall: 4) negated) * ((LargeInteger fromSmall: 5) negated)) 20)

        (check-print  ((LargeInteger fromSmall: 999)        * (LargeInteger fromSmall: 999)) 998001)
        (check-print  ((LargeInteger fromSmall: 13412341)   * (LargeInteger fromSmall: 99999)) 1341220687659)

        (check-print (((LargeInteger fromSmall: 13412341) negated) * (LargeInteger fromSmall: 99999)) -1341220687659)
        (check-print  ((LargeInteger fromSmall: 13412341) * ((LargeInteger fromSmall: 99999) negated)) -1341220687659)
        (check-print (((LargeInteger fromSmall: 13412341) negated) * ((LargeInteger fromSmall: 99999) negated)) 1341220687659)
       
        (check-print (((LargeInteger fromSmall: 2147483647) negated) * (LargeInteger fromSmall: 2147483647)) -4611686014132420609)
        (check-print  ((LargeInteger fromSmall: 2147483647) * ((LargeInteger fromSmall: 2147483647) negated)) -4611686014132420609)

        (check-print  ((LargeInteger fromSmall: 0)          *  (LargeInteger fromSmall: 5)) 0)
        (check-print  ((LargeInteger fromSmall: 0)          * ((LargeInteger fromSmall: 5) negated)) 0)
        (check-print (((LargeInteger fromSmall: 0) negated) *  (LargeInteger fromSmall: 5)) 0)
        (check-print (((LargeInteger fromSmall: 0) negated) * ((LargeInteger fromSmall: 5) negated))  0)


        (check-print  ((LargeInteger fromSmall: 4)          *  (LargeInteger fromSmall: 0)) 0)
        (check-print  ((LargeInteger fromSmall: 9)          * ((LargeInteger fromSmall: 0) negated)) 0)
        (check-print (((LargeInteger fromSmall: 4) negated) *  (LargeInteger fromSmall: 0)) 0)
        (check-print (((LargeInteger fromSmall: 6) negated) * ((LargeInteger fromSmall: 0) negated)) 0)

        (check-print  ((LargeInteger fromSmall: 0)          *  (LargeInteger fromSmall: 0)) 0)
        (check-print  ((LargeInteger fromSmall: 0)          * ((LargeInteger fromSmall: 0) negated)) 0)
        (check-print (((LargeInteger fromSmall: 0) negated) *  (LargeInteger fromSmall: 0)) 0)
        (check-print (((LargeInteger fromSmall: 0) negated) * ((LargeInteger fromSmall: 0) negated))  0)


    ;; Step 3.14
        ;; + +
        (check-print ((LargeInteger fromSmall: 4) + (LargeInteger fromSmall: 5)) 9)
        (check-print ((LargeInteger fromSmall: 2147483647) + (LargeInteger fromSmall: 2147483647)) 4294967294)


        ;; + - when + > -
        (check-print ((LargeInteger fromSmall: 567) + ((LargeInteger fromSmall: 234) negated)) 333)
        (check-print ((LargeInteger fromSmall: 2147483647) + ((LargeInteger fromSmall: 2147483645) negated)) 2)

        ;; + - when + = -
        (check-print ((LargeInteger fromSmall: 567) + ((LargeInteger fromSmall: 567) negated)) 0)
        (check-print ((LargeInteger fromSmall: 2147483647) + ((LargeInteger fromSmall: 2147483647) negated)) 0)

        ;; + - when + < -
        (check-print ((LargeInteger fromSmall: 234) + ((LargeInteger fromSmall: 567) negated)) -333)
        (check-print ((LargeInteger fromSmall: 2147483645) + ((LargeInteger fromSmall: 2147483647) negated)) -2)


        ;; - + when + > -
        (check-print (((LargeInteger fromSmall: 234) negated) + (LargeInteger fromSmall: 567)) 333)
        (check-print (((LargeInteger fromSmall: 2147483645) negated) + (LargeInteger fromSmall: 2147483647)) 2)

        ;; - + when + = -
        (check-print (((LargeInteger fromSmall: 1324) negated) + (LargeInteger fromSmall: 1324)) 0)
        (check-print (((LargeInteger fromSmall: 2147483647) negated) + (LargeInteger fromSmall: 2147483647)) 0)

        ;; - + when + < -
        (check-print (((LargeInteger fromSmall: 1324) negated) + (LargeInteger fromSmall: 333)) -991)
        (check-print (((LargeInteger fromSmall: 2147483647) negated) + (LargeInteger fromSmall: 1235)) -2147482412)


        ;; - -
        (check-print (((LargeInteger fromSmall: 4) negated) + ((LargeInteger fromSmall: 5) negated)) -9)
        (check-print (((LargeInteger fromSmall: 2147483647) negated) + ((LargeInteger fromSmall: 2147483647) negated)) -4294967294)


        ;; 0's
        (check-print ((LargeInteger fromSmall: 0) + (LargeInteger fromSmall: 5)) 5)
        (check-print ((LargeInteger fromSmall: 5) + (LargeInteger fromSmall: 0)) 5)

        (check-print ((LargeInteger fromSmall: 0) + ((LargeInteger fromSmall: 234) negated)) -234)
        (check-print ((LargeInteger fromSmall: 567) + ((LargeInteger fromSmall: 0) negated)) 567)

        (check-print (((LargeInteger fromSmall: 0) negated) + (LargeInteger fromSmall: 234)) 234)
        (check-print (((LargeInteger fromSmall: 567) negated) + (LargeInteger fromSmall: 0)) -567)

        (check-print (((LargeInteger fromSmall: 0) negated) + ((LargeInteger fromSmall: 5) negated)) -5)
        (check-print (((LargeInteger fromSmall: 4) negated) + ((LargeInteger fromSmall: 0) negated)) -4)
        (check-print (((LargeInteger fromSmall: 0) negated) + ((LargeInteger fromSmall: 0) negated)) 0)

        (check-print ((LargeInteger fromSmall: -51324) + (LargeInteger fromSmall: -100)) -51424)
        (check-print ((LargeInteger fromSmall: -4) + (LargeInteger fromSmall: -0)) -4)


    ;; Step 3.16 test division and modulus

        ;; partial credits to bignums-smt.pdf
        (check-print ((LargeInteger fromSmall:  7) sdiv:  4)  1)
        (check-print ((LargeInteger fromSmall: -7) sdiv:  4) -2)
        (check-print ((LargeInteger fromSmall:  7) sdiv: -4) -2)
        (check-print ((LargeInteger fromSmall: -7) sdiv: -4)  1)

        (check-print ((LargeInteger fromSmall:  32768) sdiv:  18)   1820)
        (check-print ((LargeInteger fromSmall:  32768) sdiv: -18)  -1821)
        (check-print ((LargeInteger fromSmall: -32768) sdiv:  18)  -1821)
        (check-print ((LargeInteger fromSmall: -32768) sdiv: -18)   1820)


        ;; partial credits to bignums-smt.pdf
        (check-print ((LargeInteger fromSmall:  7) smod:  4)  3)
        (check-print ((LargeInteger fromSmall: -7) smod:  4)  1)
        (check-print ((LargeInteger fromSmall:  7) smod: -4) -1)
        (check-print ((LargeInteger fromSmall: -7) smod: -4) -3)

        (check-print ((LargeInteger fromSmall:  32768) smod:  18)   8)
        (check-print ((LargeInteger fromSmall:  32768) smod: -18) -10)
        (check-print ((LargeInteger fromSmall: -32768) smod:  18)  10)
        (check-print ((LargeInteger fromSmall: -32768) smod: -18)  -8)


