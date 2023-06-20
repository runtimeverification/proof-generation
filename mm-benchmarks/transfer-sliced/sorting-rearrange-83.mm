$c \exists \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids \unit-sort \top #SetVariable #ElementVariable #Symbol \eq #Variable #Pattern \kore-exists \and \kore-sort-SortIds \imp \kore-is-sort |- \kore-valid ) \kore-equals \in-sort ( $.
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
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
${ $d x ph0 $.
   $d x ph1 $.
   kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
   kore-functional $a |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $. $}
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-symbol-123-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
sorting-cache-7 $a |- ( \imp \top ( \in-sort \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids \kore-sort-SortIds ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
sorting-rearrange-82 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortIds \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortIds \unit-sort kore-element-var-Val \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids ) ) ) ) $.
${ sorting-rearrange-83 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids ) ) ) $= ( top-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern and-is-pattern IMP-symbol-123-is-pattern typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern top-intro rule-weakening IMP-sort-0-is-pattern sorting-cache-7 sorting-rearrange-82 kore-functional rule-imp-transitivity ) ADECFCBHGIBJADECFCKLMGCBNBOPQ $. $}
