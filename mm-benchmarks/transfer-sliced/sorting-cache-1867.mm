$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \and \kore-sort-SortKItem \imp \kore-is-sort |- ) \kore-sort-SortInt \in-sort ( $.
$v kore-element-var-VE4 ph0 ph2 ph1 $.
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
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
sorting-cache-1861 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ( \kore-is-sort \kore-sort-SortKItem ) ) $.
sorting-cache-1866 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ( \kore-is-sort \kore-sort-SortInt ) ) $.
${ sorting-cache-1867 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $= ( kore-is-sort-is-pattern typecode-cache-Pattern-179 IMP-sort-18-is-pattern in-sort-is-pattern top-is-pattern and-is-pattern IMP-sort-23-is-pattern BASIC-K-sort-1-is-pattern sorting-cache-1866 sorting-cache-1861 rule-and-intro-alt2-sugar ) ACDEFGHBIBAJAKL $. $}
