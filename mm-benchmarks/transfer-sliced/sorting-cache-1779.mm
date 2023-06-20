$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \kore-sort-SortBool \and \kore-sort-SortKItem \imp \kore-is-sort |- ) \in-sort ( $.
$v kore-element-var-VE6 ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-element-var-VE6-elementvariable $f #ElementVariable kore-element-var-VE6 $.
typecode-cache-Pattern-356 $a #Pattern kore-element-var-VE6 $.
sorting-cache-1777 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ( \kore-is-sort \kore-sort-SortBool ) ) $.
sorting-cache-1778 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ( \kore-is-sort \kore-sort-SortKItem ) ) $.
${ sorting-cache-1779 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ( \and ( \kore-is-sort \kore-sort-SortBool ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $= ( kore-is-sort-is-pattern typecode-cache-Pattern-356 IMP-sort-18-is-pattern in-sort-is-pattern top-is-pattern and-is-pattern IMP-sort-32-is-pattern BASIC-K-sort-1-is-pattern sorting-cache-1777 sorting-cache-1778 rule-and-intro-alt2-sugar ) ACDEFGHBIBAJAKL $. $}
