$c \kore-sort-SortBExp \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \and \kore-sort-SortKItem \imp |- ) \in-sort \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE3 kore-element-var-VE6 kore-element-var-VE5 kore-element-var-VE4 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE6 kore-element-var-VE3 $.
$d kore-element-var-VE6 kore-element-var-VE5 $.
$d kore-element-var-VE6 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
kore-element-var-VE6-elementvariable $f #ElementVariable kore-element-var-VE6 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
typecode-cache-Pattern-356 $a #Pattern kore-element-var-VE6 $.
typecode-cache-Pattern-357 $a #Pattern ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) $.
sorting-cache-1742 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ) ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ) $.
sorting-cache-1744 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) $.
${ sorting-cache-1745 $p |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) $= ( in-sort-is-pattern and-is-pattern top-is-pattern typecode-cache-Pattern-179 IMP-sort-22-is-pattern typecode-cache-Pattern-357 typecode-cache-Pattern-178 IMP-sort-9-is-pattern typecode-cache-Pattern-253 BASIC-K-sort-1-is-pattern typecode-cache-Pattern-356 IMP-sort-18-is-pattern sorting-cache-1742 sorting-cache-1744 rule-and-intro-alt2-sugar ) BHIECDJFAKLEGFFCMNEDOPEGFABCDQABCDRS $. $}
