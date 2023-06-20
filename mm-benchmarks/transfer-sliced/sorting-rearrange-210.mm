$c \top "balanceSender" \kore-sort-SortAExp #Variable \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \and #SetVariable #ElementVariable #Symbol #Pattern \kore-exists \kore-inj \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \in-sort ( $.
$v kore-sort-var-R ph0 ph2 x ptn1 kore-element-var-Val ph3 ptn0 kore-element-var-K1 ph1 $.
$d kore-element-var-K1 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-K1 x $.
$d kore-sort-var-R kore-element-var-K1 $.
$d kore-element-var-Val x $.
$d kore-sort-var-R x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
x-is-element-var $f #ElementVariable x $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
typecode-cache-Pattern-86 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) $.
sorting-cache-315 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ) $.
sorting-rearrange-208 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortAExp kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortAExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) kore-element-var-K1 ) ) ) ) ) $.
${ sorting-rearrange-210 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortAExp kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortAExp kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) kore-element-var-K1 ) ) ) ) ) $= ( typecode-cache-Pattern-0 IMP-sort-13-is-pattern and-is-pattern top-is-pattern typecode-cache-Pattern-49 IMP-sort-17-is-pattern kore-is-sort-is-pattern in-sort-is-pattern typecode-cache-Pattern-86 typecode-cache-Pattern-31 string-literal-10-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-symbol-164-is-pattern kore-equals-is-pattern kore-exists-is-pattern kore-valid-is-pattern sorting-cache-315 sorting-rearrange-208 rule-imp-transitivity ) ADJGFCHEKGFFACLADEADEADBMIEINOPCHQRBSTACUAABCUBUC $. $}
