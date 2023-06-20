$c #SetVariable #ElementVariable #Symbol \sorted-exists #Variable #Pattern \inh \imp ( |- \not ) \and $.
$v ph0 xX ph2 x ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
var-is-pattern $a #Pattern xX $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
sorted-exists-is-pattern $a #Pattern ( \sorted-exists x ph0 ph1 ) $.
${ disjointness-simplify.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
   disjointness-simplify.1 $e |- ( \imp ph2 ph1 ) $.
   disjointness-simplify $a |- ( \not ( \and ph0 ph2 ) ) $. $}
${ $d x ph0 $.
   sorted-exists-to-inh $a |- ( \imp ( \sorted-exists x ph0 x ) ( \inh ph0 ) ) $. $}
${ $d x ph1 $.
   disjointness-sort.0 $e |- ( \not ( \and ph0 ( \inh ph1 ) ) ) $.
   disjointness-sort $p |- ( \not ( \and ph0 ( \sorted-exists x ph1 x ) ) ) $= ( inh-is-pattern element-var-is-var var-is-pattern sorted-exists-is-pattern sorted-exists-to-inh disjointness-simplify ) ABEBCFGCHDBCIJ $. $}
