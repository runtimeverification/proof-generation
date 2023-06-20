$c \top #SetVariable #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-is-sort |- \kore-sort-SortId ) \in-sort ( $.
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
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
sorting-cache-897 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ( \kore-is-sort \kore-sort-SortId ) ) $.
sorting-cache-898 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ( \kore-is-sort \kore-sort-SortKItem ) ) $.
${ sorting-cache-899 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $= ( kore-is-sort-is-pattern typecode-cache-Pattern-179 IMP-sort-31-is-pattern in-sort-is-pattern top-is-pattern and-is-pattern IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern sorting-cache-897 sorting-cache-898 rule-and-intro-alt2-sugar ) ACDEFGHBIBAJAKL $. $}
