$c \exists \top #Variable "10" \kore-sort-SortK \imp \kore-dv |- \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-sort-SortInt \in-sort \kore-sort-SortStateCell ( $.
$v ph0 ph2 x kore-element-var-VE3 th0 kore-element-var-VE2 kore-element-var-VE4 kore-element-var-x1 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-x1 x $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-x1 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-x1 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-VE4 x $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-x1 $.
$d kore-element-var-VE2 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
${ $d x ph0 $.
   $d x ph1 $.
   kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
   kore-functional $a |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
string-literal-13-is-pattern $a #Pattern "10" $.
sorting-cache-18 $a |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortInt "10" ) \kore-sort-SortInt ) ) $.
typecode-cache-Pattern-23 $a #Pattern kore-element-var-x1 $.
sorting-rearrange-26 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortInt \unit-sort kore-element-var-x1 ( \kore-equals \kore-sort-SortInt \unit-sort kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-347 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) $.
${ sorting-rearrange-1243 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) ) ( \exists kore-element-var-x1 ( \eq kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) $= ( top-is-pattern IMP-sort-23-is-pattern typecode-cache-Pattern-177 BASIC-K-sort-0-is-pattern in-sort-is-pattern typecode-cache-Pattern-347 and-is-pattern string-literal-13-is-pattern kore-dv-is-pattern typecode-cache-Pattern-23 eq-is-pattern exists-is-pattern top-intro rule-weakening sorting-cache-18 sorting-rearrange-26 kore-functional rule-imp-transitivity ) AGHIBCJKEDNFLMODPAGHIBCJKEQRFFLMEDSDTUAUB $. $}
