$c \top #SetVariable "balanceSender" \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortIds \and \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \kore-inj \in-sort ( $.
$v ph0 ph2 ptn1 kore-element-var-VE4 ptn2 ptn0 ph1 $.
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
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
sorting-cache-663 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ( \and ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortAExp ) ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceSender" ) \kore-sort-SortId ) ) ) $.
${ sorting-cache-664 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) \kore-sort-SortAExp ) ) $= ( IMP-sort-17-is-pattern IMP-sort-13-is-pattern in-sort-is-pattern and-is-pattern string-literal-10-is-pattern kore-dv-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-179 IMP-sort-0-is-pattern top-is-pattern kore-inj-is-pattern sorting-cache-663 INJ-symbol-0-sorting rule-imp-transitivity ) AIJDKEBHCHEBFGBDEBCBFGLCDAMBCBFGNO $. $}
