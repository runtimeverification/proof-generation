$c \kore-sort-SortKResult "balanceSender" #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \kore-inj \in-sort ( $.
$v ph0 ph2 kore-element-var-VE2 ptn1 ptn2 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
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
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
sorting-cache-1585 $a |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \and ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortKItem ) ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceSender" ) \kore-sort-SortId ) ) ) $.
${ sorting-cache-1586 $p |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) \kore-sort-SortKItem ) ) $= ( IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern in-sort-is-pattern string-literal-10-is-pattern kore-dv-is-pattern kore-is-sort-is-pattern and-is-pattern typecode-cache-Pattern-177 IMP-sort-28-is-pattern kore-inj-is-pattern sorting-cache-1585 INJ-symbol-0-sorting rule-imp-transitivity ) AIJDBGCGHBEFBDHBCBEFKCDALBCBEFMN $. $}
