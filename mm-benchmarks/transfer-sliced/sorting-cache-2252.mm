$c \kore-sort-SortKResult \top #SetVariable #ElementVariable #Symbol "210" #Variable #Pattern \and \imp \kore-dv \kore-is-sort |- ) \kore-inj \kore-sort-SortInt \in-sort ( $.
$v ph0 ph2 ptn1 ptn2 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
sorting-cache-13 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortInt ) ) $.
string-literal-20-is-pattern $a #Pattern "210" $.
sorting-cache-241 $a |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortInt "210" ) \kore-sort-SortInt ) ) $.
sorting-cache-1560 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortKResult ) ) $.
${ sorting-cache-2252 $p |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortKResult ( \kore-dv \kore-sort-SortInt "210" ) ) \kore-sort-SortKResult ) ) $= ( IMP-sort-23-is-pattern kore-is-sort-is-pattern IMP-sort-28-is-pattern string-literal-20-is-pattern kore-dv-is-pattern top-is-pattern and-is-pattern in-sort-is-pattern rule-and-intro-alt2-sugar kore-inj-is-pattern sorting-cache-13 sorting-cache-1560 sorting-cache-241 INJ-symbol-0-sorting rule-imp-transitivity ) FABCBGADEAHGACADEJCHFABCBGADEAHFABCBKLIMIACADENO $. $}
