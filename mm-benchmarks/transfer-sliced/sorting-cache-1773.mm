$c \kore-sort-SortBExp \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \kore-sort-SortBool \and \kore-sort-SortKItem \imp \kore-dv \kore-is-sort |- ) \in-sort "false" ( $.
$v kore-element-var-VE6 kore-element-var-VE5 ph0 ph2 ph1 $.
$d kore-element-var-VE6 kore-element-var-VE5 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-dv-sorting $a |- ( \in-sort ( \kore-dv ph0 ph1 ) ph0 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
IMP-sort-22-sort $a |- ( \kore-is-sort \kore-sort-SortBExp ) $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-sort-32-sort $a |- ( \kore-is-sort \kore-sort-SortBool ) $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
kore-element-var-VE6-elementvariable $f #ElementVariable kore-element-var-VE6 $.
string-literal-5-is-pattern $a #Pattern "false" $.
typecode-cache-Pattern-357 $a #Pattern ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) $.
${ sorting-cache-1773 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ( \and ( \and ( \kore-is-sort \kore-sort-SortBool ) ( \kore-is-sort \kore-sort-SortBExp ) ) ( \in-sort ( \kore-dv \kore-sort-SortBool "false" ) \kore-sort-SortBool ) ) ) $= ( IMP-sort-32-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-357 IMP-sort-22-is-pattern string-literal-5-is-pattern kore-dv-is-pattern in-sort-is-pattern imp-is-pattern proof-rule-prop-1 proof-rule-mp rule-and-intro-alt2-sugar and-is-pattern IMP-sort-32-sort IMP-sort-22-sort kore-dv-sorting ) ABECDFDNCGHCIABECDFDCDABECDJCDABEKOLFDABEFDJFDABEKPLMCGHCIABECGHCIJCGHCIABEKCGQLM $. $}
