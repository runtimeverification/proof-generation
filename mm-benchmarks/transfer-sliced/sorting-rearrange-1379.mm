$c \top #Variable \kore-sort-SortK \imp \kore-is-sort |- \kore-valid ) \kore-equals \and \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' #SetVariable #ElementVariable #Symbol #Pattern \kore-exists \kore-sort-SortKItem \in-sort ( $.
$v kore-sort-var-R ph0 ph2 x kore-element-var-K0 kore-element-var-Val ph1 $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-K0 x $.
$d kore-sort-var-R kore-element-var-K0 $.
$d kore-element-var-Val x $.
$d kore-sort-var-R x $.
$d kore-element-var-Val kore-element-var-K0 $.
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
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K0-elementvariable $f #ElementVariable kore-element-var-K0 $.
IMP-axiom-2681 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortK ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' kore-element-var-K0 ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-51 $a #Pattern kore-element-var-K0 $.
sorting-cache-1384 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortK ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortK ) \top ) ) ) $.
typecode-cache-Pattern-316 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortK ) \top ) ) $.
typecode-cache-Pattern-459 $a #Pattern ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' kore-element-var-K0 ) ) $.
${ sorting-rearrange-1379 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K0 \kore-sort-SortK ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' kore-element-var-K0 ) ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-51 BASIC-K-sort-0-is-pattern in-sort-is-pattern typecode-cache-Pattern-316 BASIC-K-sort-1-is-pattern typecode-cache-Pattern-459 kore-exists-is-pattern kore-valid-is-pattern sorting-cache-1384 IMP-axiom-2681 rule-imp-transitivity ) ADGFECHIJFEEACKADLADABCMBNOACPABCQR $. $}
