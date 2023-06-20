$c \exists "amount" \top \kore-sort-SortStmt #Variable \kore-sort-SortIds \imp \kore-dv |- \kore-sort-SortId \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \in-sort ( $.
$v ph0 ph2 x kore-element-var-VE3 th0 kore-element-var-VE4 kore-element-var-x1 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-x1 x $.
$d kore-element-var-VE4 kore-element-var-x1 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-VE4 x $.
$d kore-element-var-VE3 kore-element-var-x1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
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
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
string-literal-14-is-pattern $a #Pattern "amount" $.
sorting-cache-3 $a |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortId "amount" ) \kore-sort-SortId ) ) $.
typecode-cache-Pattern-23 $a #Pattern kore-element-var-x1 $.
sorting-rearrange-9 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortId \unit-sort kore-element-var-x1 ( \kore-equals \kore-sort-SortId \unit-sort kore-element-var-x1 ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) $.
typecode-cache-Pattern-180 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) $.
${ sorting-rearrange-333 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ( \exists kore-element-var-x1 ( \eq kore-element-var-x1 ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) $= ( top-is-pattern IMP-sort-17-is-pattern typecode-cache-Pattern-180 string-literal-14-is-pattern kore-dv-is-pattern typecode-cache-Pattern-23 eq-is-pattern exists-is-pattern top-intro rule-weakening sorting-cache-3 sorting-rearrange-9 kore-functional rule-imp-transitivity ) ABFDCIEGHJCKABFDLMEEGHDCNCOPQ $. $}
