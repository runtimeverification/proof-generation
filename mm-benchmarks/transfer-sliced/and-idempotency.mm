$c \iff #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp ( |- ) \and $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-2 $a |- ( \imp ( \imp ph0 ( \imp ph1 ph2 ) ) ( \imp ( \imp ph0 ph1 ) ( \imp ph0 ph2 ) ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-intro-sugar $a |- ( \imp ph0 ( \imp ph1 ( \and ph0 ph1 ) ) ) $.
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ and-idempotency $p |- ( \iff ( \and ph0 ph0 ) ph0 ) $= ( imp-is-pattern and-is-pattern proof-rule-mp and-elim-left-sugar proof-rule-prop-2 and-intro-sugar imp-reflexivity rule-iff-intro ) AACAAAEAABAAACBAAAACBBAABAAACBBAAAACFAAGDAHDI $. $}
