$c \top #SetVariable \kore-sort-SortKConfigVar #ElementVariable "%24PGM" #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-dv \kore-is-sort |- ) \kore-inj \in-sort ( $.
$v kore-sort-var-R ph0 ph2 ptn1 ptn2 ptn0 ph1 $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-20-is-pattern $a #Pattern \kore-sort-SortKConfigVar $.
string-literal-9-is-pattern $a #Pattern "%24PGM" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-432 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort \kore-sort-SortKConfigVar ) ( \kore-is-sort \kore-sort-SortKItem ) ) ( \in-sort ( \kore-dv \kore-sort-SortKConfigVar "%24PGM" ) \kore-sort-SortKConfigVar ) ) ) $.
${ sorting-cache-433 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortKConfigVar \kore-sort-SortKItem ( \kore-dv \kore-sort-SortKConfigVar "%24PGM" ) ) \kore-sort-SortKItem ) ) $= ( IMP-sort-20-is-pattern BASIC-K-sort-1-is-pattern kore-is-sort-is-pattern and-is-pattern string-literal-9-is-pattern kore-dv-is-pattern in-sort-is-pattern typecode-cache-Pattern-0 top-is-pattern kore-inj-is-pattern sorting-cache-432 INJ-symbol-0-sorting rule-imp-transitivity ) AIDJEBDCDEBFGBHEBCBFGKCHALBCBFGMN $. $}
