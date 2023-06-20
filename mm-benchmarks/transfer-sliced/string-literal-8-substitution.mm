$c #Substitution #SetVariable #ElementVariable #Symbol ) #Variable #Pattern "_" ( $.
$v ph0 xX xX0 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
xX-is-var $f #Variable xX $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
string-literal-8-is-pattern $a #Pattern "_" $.
${ string-literal-8-substitution $p #Substitution "_" "_" ptn0 xX0 $= ( string-literal-8-is-pattern substitution-disjoint ) CBAD $. $}
