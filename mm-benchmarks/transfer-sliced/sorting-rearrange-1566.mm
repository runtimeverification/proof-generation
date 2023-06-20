$c \exists \top "210" #Variable \imp \kore-dv |- \kore-sort-SortId \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-sort-SortKItem \kore-sort-SortInt \in-sort \kore-sort-SortMap ( $.
$v ph0 ph2 x kore-element-var-VE3 th0 kore-element-var-VE5 kore-element-var-VE4 kore-element-var-x1 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-x1 x $.
$d kore-element-var-VE4 kore-element-var-x1 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-VE5 kore-element-var-x1 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE4 x $.
$d kore-element-var-VE5 x $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
$d kore-element-var-VE3 kore-element-var-x1 $.
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
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-23 $a #Pattern kore-element-var-x1 $.
string-literal-20-is-pattern $a #Pattern "210" $.
sorting-cache-241 $a |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortInt "210" ) \kore-sort-SortInt ) ) $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-254 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) $.
sorting-rearrange-1527 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortInt \unit-sort kore-element-var-x1 ( \kore-equals \kore-sort-SortInt \unit-sort kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "210" ) ) ) ) ) $.
${ sorting-rearrange-1566 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ( \exists kore-element-var-x1 ( \eq kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "210" ) ) ) ) $= ( top-is-pattern IMP-sort-23-is-pattern typecode-cache-Pattern-178 IMP-sort-17-is-pattern in-sort-is-pattern typecode-cache-Pattern-254 and-is-pattern string-literal-20-is-pattern kore-dv-is-pattern typecode-cache-Pattern-23 eq-is-pattern exists-is-pattern top-intro rule-weakening sorting-cache-241 sorting-rearrange-1527 kore-functional rule-imp-transitivity ) AGHIBDJKECNFLMOCPAGHIBDJKEQRFFLMECSCTUAUB $. $}
