(class DebugNat
   [subclass-of Object]
   [ivars nat] ; a nat
   (class-method of: (aNat) ((self new) init: aNat))
   (method init: (n) (set nat n) self) ; private
   (method print () (nat printrep))
)

        ;; Testing isZero (1.9)
        (check-assert  ((Natural fromSmall: 0)        isZero))
        (check-assert (((Natural fromSmall: 34)       isZero) not))
        (check-assert (((Natural fromSmall: 32768)    isZero) not))
        (check-assert (((Natural fromSmall: 34937434) isZero) not))

        ;; Testing fromSmall (1.12)
        (check-print (DebugNat of: (Natural fromSmall: 0))
                     0)
        (check-print (DebugNat of:
                        (Natural fromSmall: ((Natural base) * (Natural base))))
                     1,0,0)  ;; or it might have a leading zero
        (check-print (DebugNat of: (Natural fromSmall: 1))
                     1)
        (check-print (DebugNat of: (Natural fromSmall: 1000))
                     1000)
        (check-print (DebugNat of: (Natural fromSmall: 1234567898))
                     1,4908,730)
        (check-print (DebugNat of: (Natural fromSmall: 4096))
                     4096)

        ;; Testing times/mod/divBase (1.14)
            ;; timesBase
        (check-print (DebugNat of: ((Natural fromSmall: 34) timesBase)) 
                     34,0)
        (check-print (DebugNat of: ((Natural fromSmall: 32768) timesBase))
                     1,0,0)
        (check-print (DebugNat of: ((Natural fromSmall: 1234567898) timesBase))
                     1,4908,730,0)
        (check-print (DebugNat of: ((Natural fromSmall: 0) timesBase)) 0)

            ;; divBase
        (check-print (DebugNat of: ((Natural fromSmall: 34) divBase))
                     0)
        (check-print (DebugNat of: ((Natural fromSmall: 32768) divBase))
                     1)
        (check-print (DebugNat of: ((Natural fromSmall: 1234567898) divBase))
                     1,4908)
        (check-print (DebugNat of: ((Natural fromSmall: 0) divBase))
                     0)

            ;; modBase
        (check-print (DebugNat of: (Natural fromSmall:
                                      ((Natural fromSmall: 746) modBase))) 746)
        (check-print (DebugNat of: (Natural fromSmall: 
                                      ((Natural fromSmall: 32768) modBase))) 0)
        (check-print (DebugNat of: (Natural fromSmall: 
                                      ((Natural fromSmall: 32773) modBase)))
                     5)
        (check-print (DebugNat of: (Natural fromSmall: 
                                      ((Natural fromSmall: 0) modBase))) 0)
        
        ;; testing plus:carry: and + (1.17)
            ;; testing plus:carry:
        (check-print (DebugNat of: ((Natural fromSmall: 12) plus:carry:
                                   (Natural fromSmall: 0) 1))
                     13)
        (check-print (DebugNat of: ((Natural fromSmall: 12) plus:carry:
                                   (Natural fromSmall: 1) 0))
                     13)
        (check-print (DebugNat of: ((Natural fromSmall: 32767) plus:carry:
                                   (Natural fromSmall: 0) 1))
                     1,0)
        (check-print (DebugNat of: ((Natural fromSmall: 32767) plus:carry:
                                   (Natural fromSmall: 1) 0))
                     1,0)
        (check-print (DebugNat of: ((Natural fromSmall: 32768) plus:carry:
                                   (Natural fromSmall: 32768) 0))
                     2,0) 
        (check-print (DebugNat of: ((Natural fromSmall: 1234567898) plus:carry:
                                   (Natural fromSmall: 1234567898) 0))
                     2,9816,1460) 
        (check-print (DebugNat of: ((Natural fromSmall: 1234567898) plus:carry:
                                   (Natural fromSmall: 1234567898) 1))
                     2,9816,1461) 
        (check-print (DebugNat of: ((Natural fromSmall: 0) plus:carry:
                                   (Natural fromSmall: 0) 0))
                     0) 
        (check-print (DebugNat of: ((Natural fromSmall: 0) plus:carry:
                                   (Natural fromSmall: 1) 0))
                     1) 
        (check-print (DebugNat of: ((Natural fromSmall: 0) plus:carry:
                                   (Natural fromSmall: 0) 1))
                     1) 

            ;; testing +
        (check-print (DebugNat of: ((Natural fromSmall: 12) +
                                   (Natural fromSmall: 0)))
                     12)
        (check-print (DebugNat of: ((Natural fromSmall: 12) +
                                   (Natural fromSmall: 1)))
                     13)
        (check-print (DebugNat of: ((Natural fromSmall: 32767) +
                                   (Natural fromSmall: 0)))
                     32767)
        (check-print (DebugNat of: ((Natural fromSmall: 32767) +
                                   (Natural fromSmall: 1)))
                     1,0)
        (check-print (DebugNat of: ((Natural fromSmall: 32768) +
                                   (Natural fromSmall: 32768)))
                     2,0) 
        (check-print (DebugNat of: ((Natural fromSmall: 1234567898) +
                                   (Natural fromSmall: 1234567898)))
                     2,9816,1460) 
        (check-print (DebugNat of: ((Natural fromSmall: 0) +
                                   (Natural fromSmall: 0)))
                     0) 
        (check-print (DebugNat of: ((Natural fromSmall: 0) +
                                   (Natural fromSmall: 1)))
                     1) 

        ;; testing sdivmod:with: (1.19)
        (check-print (DebugNat of: ((Natural fromSmall: 32768) sdivmod:with:
                                   1 [block (q r) q]))
                     1,0)
        (check-print (DebugNat of: ((Natural fromSmall: 1267) sdivmod:with:
                                   10 [block (q r) q]))
                     126)
        (check-print (DebugNat of: ((Natural fromSmall: (Natural base)) sdivmod:with:
                                    (Natural base) [block (q r) q]))
                     1)
        (check-print ((Natural fromSmall: (Natural base)) sdivmod:with:
                                    (Natural base) [block (q r) r])
                     0)
        (check-print (DebugNat of: (((Natural fromSmall: (Natural base)) timesBase) sdivmod:with:
                                    (Natural base) [block (q r) q]))
                     1,0)
        (check-print (DebugNat of: ((Natural fromSmall: 0) sdivmod:with:
                                    (Natural base) [block (q r) q]))
                     0)
        (check-error ((Natural fromSmall: 4) sdivmod:with: 0 [block (q r) q]))
        (check-error ((Natural fromSmall: 0) sdivmod:with: 0 [block (q r) q]))

        ;; testing decimal (1.21)

            ;; testing plus:carry: with decimal
        (check-print ((Natural fromSmall: 12) plus:carry:
                                   (Natural fromSmall: 0) 1)
                     13)
        (check-print ((Natural fromSmall: 12) plus:carry:
                                   (Natural fromSmall: 1) 0)
                     13)
        (check-print ((Natural fromSmall: 32767) plus:carry:
                                   (Natural fromSmall: 0) 1)
                     32768)
        (check-print ((Natural fromSmall: 32767) plus:carry:
                                   (Natural fromSmall: 1) 0)
                     32768)
        (check-print ((Natural fromSmall: 32768) plus:carry:
                                   (Natural fromSmall: 32768) 0)
                     65536) 
        (check-print ((Natural fromSmall: 1234567898) plus:carry:
                                   (Natural fromSmall: 1234567898) 0)
                     2469135796) 
        (check-print ((Natural fromSmall: 1234567898) plus:carry:
                                   (Natural fromSmall: 1234567898) 1)
                     2469135797) 
        (check-print ((Natural fromSmall: 0) plus:carry:
                                   (Natural fromSmall: 0) 0)
                     0) 
        (check-print ((Natural fromSmall: 0) plus:carry:
                                   (Natural fromSmall: 1) 0)
                     1) 
        (check-print ((Natural fromSmall: 0) plus:carry:
                                   (Natural fromSmall: 0) 1)
                     1) 

            ;; testing + with decimal
        (check-print ((Natural fromSmall: 12) +
                                   (Natural fromSmall: 0))
                     12)
        (check-print ((Natural fromSmall: 12) +
                                   (Natural fromSmall: 1))
                     13)
        (check-print ((Natural fromSmall: 32767) +
                                   (Natural fromSmall: 0))
                     32767)
        (check-print ((Natural fromSmall: 32767) +
                                   (Natural fromSmall: 1))
                     32768)
        (check-print ((Natural fromSmall: 32768) +
                                   (Natural fromSmall: 32768))
                     65536) 
        (check-print ((Natural fromSmall: 1234567898) +
                                   (Natural fromSmall: 1234567898))
                     2469135796) 
        (check-print ((Natural fromSmall: 0) +
                                   (Natural fromSmall: 0))
                     0) 
        (check-print ((Natural fromSmall: 0) +
                                   (Natural fromSmall: 1))
                     1) 

            ;; testing fromSmall with decimal
        (check-print (Natural fromSmall: 0) 0)
        (check-print (Natural fromSmall: ((Natural base) * (Natural base)))
                     1073741824)  ;; or it might have a leading zero
        (check-print (Natural fromSmall: 1) 1)
        (check-print (Natural fromSmall: 1000) 1000)
        (check-print (Natural fromSmall: 1234567898) 1234567898)
        (check-print (Natural fromSmall: 4096) 4096)

        ;; testing comparison (1.24)
        (check-expect ((Natural fromSmall: 0) compare-symbol: (Natural fromSmall: 0))
                     'EQ)
        (check-expect ((Natural fromSmall: 0) compare-symbol: (Natural fromSmall: 34))
                      'LT)
        (check-expect ((Natural fromSmall: 34) compare-symbol: (Natural fromSmall: 0))
                      'GT)
        (check-expect ((Natural fromSmall: ((Natural base) - 14)) 
                      compare-symbol: (Natural fromSmall: ((Natural base) - 124)))
                      'GT)
        (check-expect ((Natural fromSmall: ((Natural base) - 123)) 
                      compare-symbol: (Natural fromSmall: ((Natural base) - 12)))
                      'LT)
        (check-expect ((Natural fromSmall: (((Natural base) * 2) + 5)) 
                      compare-symbol: (Natural fromSmall: 65541))
                      'EQ)
        (check-expect ((Natural fromSmall: ((Natural base) * 2)) 
                      compare-symbol: (Natural fromSmall: 123456789))
                      'LT)
        (check-expect ((Natural fromSmall: 1234567898) 
                      compare-symbol: (Natural fromSmall: ((Natural base) + 2324)))
                      'GT)
        (check-expect ((Natural fromSmall: (((Natural base) * 2) + 5)) 
                      compare-symbol: (Natural fromSmall: 5))
                      'GT)
        (check-expect ((Natural fromSmall: 5) 
                      compare-symbol: (Natural fromSmall: (((Natural base) * 2) + 5)))
                      'LT)
   
        ;; testing <,=,> (1.24)
        (check-assert ((Natural fromSmall: 0) = (Natural fromSmall: 0)))
        (check-assert (((Natural fromSmall: 0) < (Natural fromSmall: 0)) not))
        (check-assert (((Natural fromSmall: 0) > (Natural fromSmall: 0)) not))

        (check-assert ((Natural fromSmall: 0) < (Natural fromSmall: 2324)))
        (check-assert (((Natural fromSmall: 0) > (Natural fromSmall: 2324)) not))
        (check-assert (((Natural fromSmall: 0) = (Natural fromSmall: 2324)) not))

        (check-assert ((Natural fromSmall: 3314) > (Natural fromSmall: 0)))
        (check-assert (((Natural fromSmall: 3314) < (Natural fromSmall: 0)) not))
        (check-assert (((Natural fromSmall: 3314) = (Natural fromSmall: 0)) not))

        (check-assert ((Natural fromSmall: 45) < (Natural fromSmall: 65538)))
        (check-assert (((Natural fromSmall: 45) > (Natural fromSmall: 65538)) not))
        (check-assert (((Natural fromSmall: 45) = (Natural fromSmall: 65538)) not))

        (check-assert ((Natural fromSmall: 65536) = (Natural fromSmall: 65536)))
        (check-assert (((Natural fromSmall: 65536) > (Natural fromSmall: 65536)) not))
        (check-assert (((Natural fromSmall: 65536) < (Natural fromSmall: 65536)) not))

        (check-assert ((Natural fromSmall: 123456789) > (Natural fromSmall: 1239)))
        (check-assert (((Natural fromSmall: 123456789) < (Natural fromSmall: 1239)) not))
        (check-assert (((Natural fromSmall: 123456789) = (Natural fromSmall: 1239)) not))

        (check-assert ((Natural fromSmall: 1) < (Natural fromSmall: 3)))
        (check-assert (((Natural fromSmall: 1) > (Natural fromSmall: 3)) not))
        (check-assert (((Natural fromSmall: 1) = (Natural fromSmall: 3)) not))

        (check-assert ((Natural fromSmall: 55) > (Natural fromSmall: 13)))
        (check-assert (((Natural fromSmall: 55) < (Natural fromSmall: 13)) not))
        (check-assert (((Natural fromSmall: 55) = (Natural fromSmall: 13)) not))

        (check-assert ((Natural fromSmall: 101) = (Natural fromSmall: 101)))
        (check-assert (((Natural fromSmall: 101) < (Natural fromSmall: 101)) not))
        (check-assert (((Natural fromSmall: 101) > (Natural fromSmall: 101)) not))

        (check-assert ((Natural fromSmall: 
                        (((Natural base) * 3) + 5)) < 
                        (Natural fromSmall: (((Natural base) * 3) + 100))))
        (check-assert (((Natural fromSmall: 
                         (((Natural base) * 3) + 5)) > 
                         (Natural fromSmall: (((Natural base) * 3) + 100))) not))
        (check-assert (((Natural fromSmall: 
                         (((Natural base) * 3) + 5)) = 
                         (Natural fromSmall: (((Natural base) * 3) + 100))) not))

        (check-assert ((Natural fromSmall: 
                        (((Natural base) * 3) + 134)) >
                        (Natural fromSmall: (((Natural base) * 3) + 100))))
        (check-assert (((Natural fromSmall: 
                         (((Natural base) * 3) + 134)) <
                         (Natural fromSmall: (((Natural base) * 3) + 100))) not))
        (check-assert (((Natural fromSmall:
                         (((Natural base) * 3) + 134)) =
                         (Natural fromSmall: (((Natural base) * 3) + 100))) not))

        (check-assert ((Natural fromSmall:
                        (((Natural base) * 3) + 100)) =
                        (Natural fromSmall: (((Natural base) * 3) + 100))))
        (check-assert (((Natural fromSmall:
                         (((Natural base) * 3) + 100)) >
                         (Natural fromSmall: (((Natural base) * 3) + 100))) not))
        (check-assert (((Natural fromSmall:
                         (((Natural base) * 3) + 100)) <
                         (Natural fromSmall: (((Natural base) * 3) + 100))) not))

 

        ;; testing subtraction (1.27)
       (check-print ((Natural fromSmall: 123456789) - (Natural fromSmall: 0))
                     123456789)
       (check-print ((Natural fromSmall: 0) - (Natural fromSmall: 0)) 0)
       (check-print ((Natural fromSmall: 12345) - (Natural fromSmall: 6789))
                     5556)
       (check-print ((Natural fromSmall: 32769) - (Natural fromSmall: 31079))
                     1690)
       (check-print ((Natural fromSmall: 42069) - (Natural fromSmall: 42069))
                     0)
       (check-error ((Natural fromSmall: 0) - (Natural fromSmall: 32768)))

        ;; testing multiplication (1.29)
       (check-print ((Natural fromSmall: 0)  * (Natural fromSmall: 0))    0)
       (check-print ((Natural fromSmall: 0)  * (Natural fromSmall: 2345678)) 0)
       (check-print ((Natural fromSmall: 2351) * (Natural fromSmall: 0)) 0)
       (check-print ((Natural fromSmall: 16) * (Natural fromSmall: 14)) 224)
       (check-print ((Natural fromSmall: ((Natural base) - 1)) 
                        * (Natural fromSmall: ((Natural base) + 1)))
                    1073741823)
      (check-print ((Natural fromSmall: 11111111) * (Natural fromSmall: 11111111))
                    123456787654321)


       (Natural addSelector:withMethod: 'squared
         (compiled-method () (self * self)))
       (Natural addSelector:withMethod: 'coerce:
         (compiled-method (i) (Natural fromSmall: i)))
       (Natural addSelector:withMethod: 'raisedToInteger:
         (Number compiledMethodAt: 'raisedToInteger:))

         (check-print ((Natural fromSmall: 10) raisedToInteger: 10) 10000000000)
         (check-print ((Natural fromSmall:  9) raisedToInteger:  9)   387420489)
         (check-print ((Natural fromSmall: 50) raisedToInteger: 50) 8881784197001252323389053344726562500000000000000000000000000000000000000000000000000)
         (check-print ((Natural fromSmall: 99) raisedToInteger: 99)
            369729637649726772657187905628805440595668764281741102430259972423552570455277523421410650010128232727940978889548326540119429996769494359451621570193644014418071060667659301384999779999159200499899)
         (check-print ((Natural fromSmall: 150) raisedToInteger: 150)
            259232147948794494594485446818048254863271026096382337884099237269509380022108148908589797968903058274437782549758243999867043174477180579595714249308002763427793979644775390625000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000)
