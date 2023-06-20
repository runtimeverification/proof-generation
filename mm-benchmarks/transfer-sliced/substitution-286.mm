$c #Substitution \unit-sort #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol ) #Variable #Pattern ( $.
$v kore-sort-var-R ph0 xX x sg0 ph1 $.
$d kore-sort-var-R x $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
${ substitution-286 $p #Substitution \kore-sort-SortAExp \kore-sort-SortAExp \unit-sort kore-sort-var-R $= ( IMP-sort-13-is-pattern unit-sort-is-symbol symbol-is-pattern element-var-is-var substitution-disjoint ) BCDAEF $. $}
