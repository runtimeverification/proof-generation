$c #SetVariable \ceil #ElementVariable #Symbol \sorted-exists #Variable #Pattern \and \imp |- \not ) ( $.
$v ph2 ph0 x y ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
ceil-is-pattern $a #Pattern ( \ceil ph0 ) $.
sorted-exists-is-pattern $a #Pattern ( \sorted-exists x ph0 ph1 ) $.
${ rule-contrapositive-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive-sugar $a |- ( \imp ( \not ph1 ) ( \not ph0 ) ) $. $}
${ lemma-not-ceil-elim.0 $e |- ( \not ph0 ) $.
   lemma-not-ceil-elim $a |- ( \not ( \ceil ph0 ) ) $. $}
${ $d x y $.
   $d x ph0 $.
   disjointness-alt-lemma $a |- ( \imp ( \sorted-exists x ph2 ( \ceil ( \and ph0 ph1 ) ) ) ( \ceil ( \and ph0 ( \sorted-exists x ph2 ph1 ) ) ) ) $. $}
${ $d x ph0 $.
   disjointness-alt.0 $e |- ( \not ( \and ph0 ( \sorted-exists x ph2 ph1 ) ) ) $.
   disjointness-alt $p |- ( \not ( \sorted-exists x ph2 ( \ceil ( \and ph0 ph1 ) ) ) ) $= ( sorted-exists-is-pattern and-is-pattern ceil-is-pattern not-is-pattern disjointness-alt-lemma rule-contrapositive-sugar lemma-not-ceil-elim proof-rule-mp ) ACBDFGHICABGHDFICABGHDFACBDFGHABCDJKACBDFGELM $. $}
