$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \kore-sort-SortBool \and \kore-sort-SortKItem \imp \kore-dv \kore-is-sort |- ) \kore-inj \in-sort "false" ( $.
$v ph0 ph2 ptn1 kore-element-var-VE6 ptn2 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-element-var-VE6-elementvariable $f #ElementVariable kore-element-var-VE6 $.
string-literal-5-is-pattern $a #Pattern "false" $.
typecode-cache-Pattern-356 $a #Pattern kore-element-var-VE6 $.
sorting-cache-1781 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ( \and ( \and ( \kore-is-sort \kore-sort-SortBool ) ( \kore-is-sort \kore-sort-SortKItem ) ) ( \in-sort ( \kore-dv \kore-sort-SortBool "false" ) \kore-sort-SortBool ) ) ) $.
${ sorting-cache-1782 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-sort-SortKItem ) ) $= ( IMP-sort-32-is-pattern BASIC-K-sort-1-is-pattern in-sort-is-pattern and-is-pattern string-literal-5-is-pattern kore-dv-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-356 IMP-sort-18-is-pattern top-is-pattern kore-inj-is-pattern sorting-cache-1781 INJ-symbol-0-sorting rule-imp-transitivity ) AIJDKEBHCHEBFGBDEBCBFGLCDAMBCBFGNO $. $}
