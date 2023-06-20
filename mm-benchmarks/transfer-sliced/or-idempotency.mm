$c \iff #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp |- ) ( $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
or-intro-left-sugar $a |- ( \imp ph0 ( \or ph0 ph1 ) ) $.
${ rule-or-elim-sugar.0 $e |- ( \imp ph0 ph2 ) $.
   rule-or-elim-sugar.1 $e |- ( \imp ph1 ph2 ) $.
   rule-or-elim-sugar $a |- ( \imp ( \or ph0 ph1 ) ph2 ) $. $}
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ or-idempotency $p |- ( \iff ( \or ph0 ph0 ) ph0 ) $= ( imp-reflexivity or-is-pattern rule-or-elim-sugar or-intro-left-sugar rule-iff-intro ) AACAAAAABABDAAEF $. $}
