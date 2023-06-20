$c \exists \top #Variable \kore-sort-SortK \imp |- \kore-valid ) \kore-equals \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-sort-SortBlock \kore-exists \in-sort \kore-symbol-dotk \kore-sort-SortStateCell ( $.
$v ph0 kore-element-var-V0 ph2 x kore-element-var-VE3 th0 kore-element-var-VE2 kore-element-var-VE4 ph1 $.
$d kore-element-var-V0 x $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE4 kore-element-var-V0 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-V0 kore-element-var-VE2 $.
$d kore-element-var-VE4 x $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-V0 $.
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
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
sorting-cache-43 $a |- ( \imp \top ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) $.
typecode-cache-Pattern-39 $a #Pattern kore-element-var-V0 $.
sorting-rearrange-275 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortK \unit-sort kore-element-var-V0 ( \kore-equals \kore-sort-SortK \unit-sort kore-element-var-V0 \kore-symbol-dotk ) ) ) ) $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-382 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ) $.
${ sorting-rearrange-1130 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ) ) ( \exists kore-element-var-V0 ( \eq kore-element-var-V0 \kore-symbol-dotk ) ) ) $= ( top-is-pattern typecode-cache-Pattern-177 IMP-sort-18-is-pattern in-sort-is-pattern typecode-cache-Pattern-382 and-is-pattern KSEQ-symbol-1-is-pattern typecode-cache-Pattern-39 eq-is-pattern exists-is-pattern top-intro rule-weakening BASIC-K-sort-0-is-pattern sorting-cache-43 sorting-rearrange-275 kore-functional rule-imp-transitivity ) AFGHBCIJEDLKMDNAFGHBCIJEOPQKEDRDSTUA $. $}
