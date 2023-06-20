$c \top #Variable \kore-sort-SortIds \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol #Pattern \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids \kore-exists \in-sort "balanceTo" ( $.
$v kore-sort-var-R ph0 ph2 x kore-element-var-Val kore-element-var-K1 ph1 $.
$d kore-element-var-K1 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-K1 x $.
$d kore-sort-var-R kore-element-var-K1 $.
$d kore-element-var-Val x $.
$d kore-sort-var-R x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
x-is-element-var $f #ElementVariable x $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
typecode-cache-Pattern-58 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortIds ) \top ) ) $.
typecode-cache-Pattern-67 $a #Pattern ( \kore-equals \kore-sort-SortIds kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceTo" ) kore-element-var-K1 ) ) $.
sorting-rearrange-76 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortIds ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortIds kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortIds kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceTo" ) kore-element-var-K1 ) ) ) ) ) $.
sorting-cache-281 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortIds ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortIds ) \top ) ) ) $.
${ sorting-rearrange-88 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortIds ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortIds kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortIds kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceTo" ) kore-element-var-K1 ) ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern IMP-sort-0-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-49 in-sort-is-pattern typecode-cache-Pattern-58 typecode-cache-Pattern-67 kore-exists-is-pattern kore-valid-is-pattern sorting-cache-281 sorting-rearrange-76 rule-imp-transitivity ) ADHFECIGJFEEACKADGADABCLBMNACOABCPQ $. $}
