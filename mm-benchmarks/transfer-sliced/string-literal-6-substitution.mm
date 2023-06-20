$c #Substitution #SetVariable #ElementVariable #Symbol ) #Variable #Pattern "-1" ( $.
$v ph0 xX xX0 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
xX-is-var $f #Variable xX $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
string-literal-6-is-pattern $a #Pattern "-1" $.
${ string-literal-6-substitution $p #Substitution "-1" "-1" ptn0 xX0 $= ( string-literal-6-is-pattern substitution-disjoint ) CBAD $. $}
