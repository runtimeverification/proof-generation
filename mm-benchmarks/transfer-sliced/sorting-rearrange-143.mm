$c \top \kore-sort-SortAExp #Variable \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol #Pattern \kore-exists "100" \kore-inj \kore-sort-SortInt ( $.
$v kore-sort-var-R ph0 ph2 x kore-element-var-Val ph3 ph1 $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-Val x $.
$d kore-sort-var-R x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
x-is-element-var $f #ElementVariable x $.
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
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
string-literal-16-is-pattern $a #Pattern "100" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-136 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
sorting-rearrange-142 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortAExp kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortAExp kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) ) ) ) $.
${ sorting-rearrange-143 $p |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortAExp kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortAExp kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) ) ) ) $= ( top-is-pattern typecode-cache-Pattern-0 and-is-pattern kore-is-sort-is-pattern IMP-sort-13-is-pattern IMP-sort-23-is-pattern typecode-cache-Pattern-31 string-literal-16-is-pattern kore-dv-is-pattern kore-inj-is-pattern kore-equals-is-pattern kore-exists-is-pattern kore-valid-is-pattern sorting-cache-136 top-intro rule-weakening rule-and-intro-alt2-sugar sorting-rearrange-142 rule-imp-transitivity ) CADFCEEADFCEADGADGADBIHGHJKLMBNOCADFCEEADFCAPCADFCEECQRSABTUA $. $}
