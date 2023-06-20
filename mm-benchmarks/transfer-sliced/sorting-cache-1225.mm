$c \top #SetVariable #ElementVariable #Symbol \kore-symbol-LblnotBool'Unds' #Variable #Pattern \kore-sort-SortBool \imp \kore-dv |- ) \in-sort "false" ( $.
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
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-297-is-pattern $a #Pattern ( \kore-symbol-LblnotBool'Unds' ptn0 ) $.
IMP-symbol-297-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortBool ) ( \in-sort ( \kore-symbol-LblnotBool'Unds' ptn0 ) \kore-sort-SortBool ) ) $.
string-literal-5-is-pattern $a #Pattern "false" $.
sorting-cache-179 $a |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortBool "false" ) \kore-sort-SortBool ) ) $.
${ sorting-cache-1225 $p |- ( \imp \top ( \in-sort ( \kore-symbol-LblnotBool'Unds' ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-sort-SortBool ) ) $= ( IMP-sort-32-is-pattern string-literal-5-is-pattern kore-dv-is-pattern in-sort-is-pattern top-is-pattern IMP-symbol-297-is-pattern sorting-cache-179 IMP-symbol-297-sorting rule-imp-transitivity ) EABCADABCFADGABCHI $. $}
