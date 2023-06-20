$c #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp ( |- \not ) \and $.
$v ph0 ph2 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-contrapositive-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive-sugar $a |- ( \imp ( \not ph1 ) ( \not ph0 ) ) $. $}
${ rule-imp-compat-in-and.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-compat-in-and.1 $e |- ( \imp ph2 ph3 ) $.
   rule-imp-compat-in-and $a |- ( \imp ( \and ph0 ph2 ) ( \and ph1 ph3 ) ) $. $}
${ disjointness-simplify.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
   disjointness-simplify.1 $e |- ( \imp ph2 ph1 ) $.
   disjointness-simplify $p |- ( \not ( \and ph0 ph2 ) ) $= ( and-is-pattern not-is-pattern imp-reflexivity rule-imp-compat-in-and rule-contrapositive-sugar proof-rule-mp ) ABFGACFGACFABFAACBAHEIJDK $. $}
