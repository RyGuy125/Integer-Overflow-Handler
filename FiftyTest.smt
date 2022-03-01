;; FiftyTest.smt tests 50^50

       (Natural addSelector:withMethod: 'squared
         (compiled-method () (self * self)))
       (Natural addSelector:withMethod: 'coerce:
         (compiled-method (i) (Natural fromSmall: i)))
       (Natural addSelector:withMethod: 'raisedToInteger:
         (Number compiledMethodAt: 'raisedToInteger:))
         
        (check-print ((Natural fromSmall: 50) raisedToInteger: 50) 8881784197001252323389053344726562500000000000000000000000000000000000000000000000000)

