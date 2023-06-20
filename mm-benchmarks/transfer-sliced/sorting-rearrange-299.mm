$c \exists \top \kore-sort-SortStmt #Variable \kore-sort-SortIds \imp |- \kore-sort-SortId \kore-valid ) \kore-equals \and \unit-sort \kore-symbol-Lbl'Stop'Map #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \in-sort \kore-sort-SortMap ( $.
$v ph0 ph2 x kore-element-var-VE3 th0 kore-element-var-VE2 kore-element-var-VE4 kore-element-var-Val ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE3 kore-element-var-Val $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-Val kore-element-var-VE2 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-Val x $.
$d kore-element-var-VE4 kore-element-var-Val $.
$d kore-element-var-VE4 x $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
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
${ $d x ph0 $.
   $d x ph1 $.
   kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
   kore-functional $a |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $. $}
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
sorting-cache-44 $a |- ( \imp \top ( \in-sort \kore-symbol-Lbl'Stop'Map \kore-sort-SortMap ) ) $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
sorting-rearrange-52 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortMap \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortMap \unit-sort kore-element-var-Val \kore-symbol-Lbl'Stop'Map ) ) ) ) $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-180 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) $.
${ sorting-rearrange-299 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val \kore-symbol-Lbl'Stop'Map ) ) ) $= ( top-is-pattern typecode-cache-Pattern-177 IMP-sort-17-is-pattern in-sort-is-pattern typecode-cache-Pattern-180 and-is-pattern IMP-symbol-124-is-pattern typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern top-intro rule-weakening IMP-sort-14-is-pattern sorting-cache-44 sorting-rearrange-52 kore-functional rule-imp-transitivity ) AFGHBCIJEDLKMDNAFGHBCIJEOPQKEDRDSTUA $. $}
