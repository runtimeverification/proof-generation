$c #Substitution \unit-sort \top #SetVariable #ElementVariable #Symbol #Variable #Pattern ( \kore-is-sort ) \and $.
$v kore-sort-var-R ph0 xX ph2 x sg0 ph3 ph4 ph1 $.
$d kore-sort-var-R x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
element-var-is-var $a #Variable x $.
symbol-is-pattern $a #Pattern sg0 $.
top-is-pattern $a #Pattern \top $.
unit-sort-is-symbol $a #Symbol \unit-sort $.
${ substitution-and.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-and.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-and $a #Substitution ( \and ph1 ph2 ) ( \and ph3 ph4 ) ph0 xX $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
substitution-81 $a #Substitution ( \kore-is-sort \unit-sort ) ( \kore-is-sort kore-sort-var-R ) \unit-sort kore-sort-var-R $.
substitution-82 $a #Substitution \top \top \unit-sort kore-sort-var-R $.
${ substitution-83 $p #Substitution ( \and ( \kore-is-sort \unit-sort ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \unit-sort kore-sort-var-R $= ( unit-sort-is-symbol symbol-is-pattern kore-is-sort-is-pattern top-is-pattern typecode-cache-Pattern-0 element-var-is-var substitution-81 substitution-82 substitution-and ) BCBCDEAFDEAGAHAIJ $. $}
