#!/bin/bash

# echo -e "(use bignum.smt) (use longtests.smt)" | usmalltalk -qq
# echo -e "(use bignum.smt) (use longtests.smt)" | env BPCOPTIONS=nothrottle /usr/bin/time usmalltalk @MLton gc-summary -- -qq
# echo -e "(use bignum.smt) (use FiftyTest.smt)" | env BPCOPTIONS=nothrottle /usr/bin/time usmalltalk @MLton gc-summary -- -qq
echo -e "(use bignum.smt) (use longtests.smt)" | env BPCOPTIONS=nothrottle usmalltalk -qq
# echo '(use bignum.smt) (use natural-tests.smt)' | usmalltalk -qq

