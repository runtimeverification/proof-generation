$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-sort-SortK |- ) \in-sort \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE3 kore-element-var-VE2 kore-element-var-VE5 kore-element-var-VE4 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
typecode-cache-Pattern-324 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) $.
sorting-cache-1499 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) \top ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ) $.
sorting-cache-1501 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) $.
${ sorting-cache-1502 $p |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) $= ( in-sort-is-pattern and-is-pattern top-is-pattern typecode-cache-Pattern-178 IMP-sort-9-is-pattern typecode-cache-Pattern-324 typecode-cache-Pattern-177 BASIC-K-sort-0-is-pattern typecode-cache-Pattern-179 IMP-sort-13-is-pattern typecode-cache-Pattern-253 BASIC-K-sort-1-is-pattern sorting-cache-1499 sorting-cache-1501 rule-and-intro-alt2-sugar ) BHIECDJFAKLEGFFCMNEDOPEGFABCDQABCDRS $. $}
