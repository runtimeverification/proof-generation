$c \kore-symbol-LblinitStateCell \top #SetVariable \kore-symbol-Lbl'Stop'Map \kore-symbol-Lbl'-LT-'state'-GT-' #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- \kore-valid ) \kore-equals \kore-sort-SortStateCell ( $.
$v kore-sort-var-R ph0 ph2 ph3 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
ptn0-pattern $f #Pattern ptn0 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
IMP-symbol-132-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) $.
IMP-symbol-245-is-pattern $a #Pattern \kore-symbol-LblinitStateCell $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-136 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-rearrange-284 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortStateCell kore-sort-var-R \kore-symbol-LblinitStateCell ( \kore-symbol-Lbl'-LT-'state'-GT-' \kore-symbol-Lbl'Stop'Map ) ) ) ) $.
${ sorting-rearrange-285 $p |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortStateCell kore-sort-var-R \kore-symbol-LblinitStateCell ( \kore-symbol-Lbl'-LT-'state'-GT-' \kore-symbol-Lbl'Stop'Map ) ) ) ) $= ( top-is-pattern typecode-cache-Pattern-0 and-is-pattern kore-is-sort-is-pattern IMP-sort-9-is-pattern IMP-symbol-245-is-pattern IMP-symbol-124-is-pattern IMP-symbol-132-is-pattern kore-equals-is-pattern kore-valid-is-pattern sorting-cache-136 top-intro rule-weakening rule-and-intro-alt2-sugar sorting-rearrange-284 rule-imp-transitivity ) BACEBDDACEBDACFACGHIJKBACEBDDACEBALBACEBDDBMNOAPQ $. $}
