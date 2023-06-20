$c #Substitution \unit-sort \kore-sort-SortBool #SetVariable #ElementVariable #Symbol ) #Variable #Pattern ( $.
$v ph0 xX x sg0 ph1 kore-sort-var-x0 $.
$d x kore-sort-var-x0 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
element-var-is-var $a #Variable x $.
symbol-is-pattern $a #Pattern sg0 $.
unit-sort-is-symbol $a #Symbol \unit-sort $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
${ substitution-1014 $p #Substitution \kore-sort-SortBool \kore-sort-SortBool \unit-sort kore-sort-var-x0 $= ( IMP-sort-32-is-pattern unit-sort-is-symbol symbol-is-pattern element-var-is-var substitution-disjoint ) BCDAEF $. $}
