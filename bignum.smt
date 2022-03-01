(class Natural             ; Template taken from /comp/105/build-prove-compare
   [subclass-of Magnitude] ; abstract class
   (class-method base () 32768) ; private

   (class-method fromSmall: (anInteger) 
      ((anInteger = 0) ifTrue:ifFalse: 
                         {(NatZero new)}
                         {(NatNonZero first:rest: 
                             (anInteger mod: (Natural base))
                             (Natural fromSmall: 
                                (anInteger div: (Natural base))))}))

   (method = (aNatural) 
      (self compare:withLt:withEq:withGt: aNatural {false} {true} {false}))
   (method < (aNatural) 
      (self compare:withLt:withEq:withGt: aNatural {true} {false} {false}))

   (method + (aNatural) (self plus:carry: aNatural 0))
   (method * (aNatural) (self subclassResponsibility))
   (method - (aNatural)
      (self subtract:withDifference:ifNegative:
            aNatural
            [block (x) x]
            {(self error: 'Natural-subtraction-went-negative)}))
   (method subtract:withDifference:ifNegative: (aNatural diffBlock exnBlock)
      ((self < aNatural) ifTrue:ifFalse: 
         exnBlock 
         {(diffBlock value: (self minus:borrow: aNatural 0))}))

   (method sdiv: (n) (self sdivmod:with: n [block (q r) q]))
   (method smod: (n) (self sdivmod:with: n [block (q r) r]))
   (method sdivmod:with: (n aBlock) (self subclassResponsibility))

    ;; the following methods in this chunk are taken from page 681
   (method modBase   () (self subclassResponsbility))  ; page 681
   (method divBase   () (self subclassResponsbility))  ; page 681
   (method timesBase () (self subclassResponsbility))  ; page 681
   (method compare:withLt:withEq:withGt: (aNatural ltBlock eqBlock gtBlock) 
             (self subclassResponsbility))                      ; page 681
   (method plus:carry:   (aNatural c) (self subclassResponsbility))  ; page 681
   (method minus:borrow: (aNatural c) (self subclassResponsbility))  ; page 681

   (method decimal () [locals list tmp]
      (set tmp self)
      (set list (List new))
      ({(tmp isZero)} whileFalse:
        {(list addFirst: (tmp sdivmod:with: 10 [block (q r) (set tmp q) r]))})
      ((list isEmpty) ifTrue:ifFalse: {(list addFirst: 0)} {list})) 

   (method isZero  () (self subclassResponsbility))
   (method print   () ((self decimal) do: [block (x) (x print)]))

    ; Credits to bignums-smt.pdf
   (method validated ()
      ((self invariant) ifFalse:
         {(self printrep)
          (self error: 'invariant-violation)})
      self)

   (method compare-symbol: (aNat)
      (self compare:withLt:withEq:withGt: aNat {'LT} {'EQ} {'GT}))
)
(class NatZero
   [subclass-of Natural] ; concrete class
    ; A (self) == 0
    ; I (self) == true 
   (method isZero () true)
   (method invariant () true)
   (method printrep () (0 print))

   (method modBase   () 0)
   (method divBase   () self)
   (method timesBase () self)

   (method timesSmall: (n) self) ; private
   (method * (aNatural) self)
   (method sdivmod:with: (n aBlock) 
       ((n = 0) ifTrue:ifFalse: 
           {(self error: 'DivisionByZero)}
           {(aBlock value:value: self 0)}))
   (method compare:withLt:withEq:withGt: (aNatural ltBlock eqBlock gtBlock)
       ((aNatural isZero) ifTrue:ifFalse: eqBlock ltBlock))
   (method plus:carry: (aNatural c) 
       ((aNatural isZero) ifTrue:ifFalse: 
                            {(Natural fromSmall: c)} 
                            {(aNatural plus:carry: self c)}))
   (method minus:borrow: (aNatural c)
       (((aNatural isZero) and: {(c = 0)}) ifTrue:ifFalse: 
                                         {self}
                                         {(self error: 'negative)}))
)
(class NatNonZero
   [subclass-of Natural] ; concrete class
   [ivars m d]
    ; A (self) == m * base + d
    ; I (self) == 0 <= d < base && (m != 0 || d != 0)
   (method invariant () 
      (((d >= 0) & (d < (Natural base))) & ((d > 0) | (m invariant))))
   (method isZero () false)
   (method newD:andM: (anInteger aNatural) ; private
        (set m aNatural)
        (set d anInteger)
        self)
   (class-method first:rest: (anInteger aNatural)
      ((aNatural isZero) ifTrue:ifFalse: 
                          {((anInteger = 0) ifTrue:ifFalse: 
                                {(NatZero new)}
                                {(((self new) newD:andM: 
                                      anInteger (NatZero new))
                                  validated)})}
                          {(((self new) newD:andM: anInteger aNatural)
                            validated)}))
   (method printrep () ((m isZero) ifTrue:ifFalse: 
                                     {(d print)}
                                     {(m printrep) (', print) (d print)}))
   (method modBase   ()  d) ; private
   (method divBase   ()  m) ; private
   (method timesBase ()  
      (NatNonZero first:rest: 0 self)) ; private

   (method plus:carry: (aNatural c) [locals z0 c1]
      (set z0 (((d + (aNatural modBase)) + c) mod: (Natural base)))
      (set c1 (((d + (aNatural modBase)) + c) div: (Natural base)))
      (NatNonZero first:rest: z0 (m plus:carry: (aNatural divBase) c1)))

   (method sdivmod:with: (n aBlock) [locals q' r' rBaseD]
      (m sdivmod:with: n [block (q r) 
                            (set rBaseD ((r * (Natural base)) + d))
                            (set q' ((q timesBase) + (Natural fromSmall: (rBaseD div: n))))
                            (set r' (rBaseD mod: n))
                            (aBlock value:value: q' r')]))
   (method compare:withLt:withEq:withGt: (aNatural ltBlock eqBlock gtBlock)
      ((aNatural isZero) ifTrue:ifFalse: 
          gtBlock
          {(m compare:withLt:withEq:withGt: 
                (aNatural divBase) 
                ltBlock 
                {((d = (aNatural modBase)) ifTrue:ifFalse:
                      eqBlock
                      {((d < (aNatural modBase)) ifTrue:ifFalse:
                             ltBlock gtBlock)})}
                gtBlock)}))
   (method minus:borrow: (aNatural c) [locals dsMinusc]
      (set dsMinusc ((d - (aNatural modBase)) - c))
      ((dsMinusc < 0) ifTrue:ifFalse:
        {(((m minus:borrow: (aNatural divBase) 1) timesBase) + (Natural fromSmall: ((Natural base) + dsMinusc)))}
        {(((m minus:borrow: (aNatural divBase) 0) timesBase) + (Natural fromSmall: dsMinusc))}))
   (method timesSmall: (n) [locals zhi zlo] 
        (set zhi (Natural fromSmall: ((n * d) div: (Natural base))))
        (set zlo ((n * d) mod: (Natural base)))
        (NatNonZero first:rest: zlo ((m timesSmall: n) + zhi)))
   (method * (aNatural)
      ((aNatural timesSmall: d) + ((m * aNatural) timesBase)))

    ;;  (set zhi ((Natural fromSmall: (d * (aNatural modBase))) 
    ;;                sdivmod:with: (Natural base)
    ;;                    [block (q r) (set zlo (Natural fromSmall: r)) q])) 
    ;;  ((zlo + (((zhi + ((aNatural divBase) * (Natural fromSmall: d))) 
    ;;        + (m * (Natural fromSmall: (aNatural modBase)))) timesBase))
    ;;        + (((m * (aNatural divBase)) timesBase) timesBase)))

    ;;  (set zhi (Natural fromSmall: ((d * (aNatural modBase)) div: (Natural base))))
    ;;  (set zlo (Natural fromSmall: ((d * (aNatural modBase)) mod: (Natural base))))
    ;;  ((zlo + (((zhi + ((aNatural divBase) * (Natural fromSmall: d))) 
    ;;        + (m * (Natural fromSmall: (aNatural modBase)))) timesBase))
    ;;        + (((m * (aNatural divBase)) timesBase) timesBase)))
)


