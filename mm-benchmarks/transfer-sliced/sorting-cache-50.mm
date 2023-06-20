$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \imp \kore-dv \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' "0" |- ) \kore-sort-SortInt \kore-sort-SortGeneratedCounterCell \in-sort ( $.
$v ph0 ph2 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
ptn0-pattern $f #Pattern ptn0 $.
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-128-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ptn0 ) $.
IMP-symbol-128-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortInt ) ( \in-sort ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ptn0 ) \kore-sort-SortGeneratedCounterCell ) ) $.
string-literal-1-is-pattern $a #Pattern "0" $.
sorting-cache-32 $a |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortInt "0" ) \kore-sort-SortInt ) ) $.
${ sorting-cache-50 $p |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) \kore-sort-SortGeneratedCounterCell ) ) $= ( IMP-sort-23-is-pattern string-literal-1-is-pattern kore-dv-is-pattern in-sort-is-pattern top-is-pattern IMP-symbol-128-is-pattern IMP-sort-10-is-pattern sorting-cache-32 IMP-symbol-128-sorting rule-imp-transitivity ) EABCADABCFGDHABCIJ $. $}
