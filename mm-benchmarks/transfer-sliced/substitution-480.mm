$c #Substitution \unit-sort \kore-sort-SortK #SetVariable #ElementVariable #Symbol ) #Variable #Pattern ( $.
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
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
${ substitution-480 $p #Substitution \kore-sort-SortK \kore-sort-SortK \unit-sort kore-sort-var-R $= ( BASIC-K-sort-0-is-pattern unit-sort-is-symbol symbol-is-pattern element-var-is-var substitution-disjoint ) BCDAEF $. $}
