$c \exists \top #Variable \kore-sort-SortBool \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-equals "false" \and \unit-sort \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-inj \in-sort ( $.
$v kore-sort-var-R ph0 ph2 x th0 kore-element-var-Val ph1 $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-Val x $.
$d kore-sort-var-R x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ $d x ph0 $.
   $d x ph1 $.
   kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
   kore-functional $a |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $. $}
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
string-literal-5-is-pattern $a #Pattern "false" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
sorting-rearrange-1098 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortKResult \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortKResult \unit-sort kore-element-var-Val ( \kore-inj \kore-sort-SortBool \kore-sort-SortKResult ( \kore-dv \kore-sort-SortBool "false" ) ) ) ) ) ) $.
sorting-cache-1790 $a |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortBool \kore-sort-SortKResult ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-sort-SortKResult ) ) $.
${ sorting-rearrange-1099 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val ( \kore-inj \kore-sort-SortBool \kore-sort-SortKResult ( \kore-dv \kore-sort-SortBool "false" ) ) ) ) ) $= ( top-is-pattern IMP-sort-32-is-pattern IMP-sort-28-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern and-is-pattern string-literal-5-is-pattern kore-dv-is-pattern kore-inj-is-pattern typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern top-intro rule-weakening sorting-cache-1790 sorting-rearrange-1098 kore-functional rule-imp-transitivity ) AFGCHCBLDEDIJKMBNAFGCHCOPEDEDIJKCBQBRST $. $}
