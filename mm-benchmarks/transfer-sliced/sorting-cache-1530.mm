$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) "addressTo" \in-sort ( $.
$v kore-element-var-VE5 kore-element-var-VE4 ph0 ph2 ph1 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
BASIC-K-sort-1-sort $a |- ( \kore-is-sort \kore-sort-SortKItem ) $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-17-sort $a |- ( \kore-is-sort \kore-sort-SortId ) $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
typecode-cache-Pattern-324 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) $.
${ sorting-cache-1530 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ( \and ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortKItem ) ) ( \in-sort ( \kore-dv \kore-sort-SortId "addressTo" ) \kore-sort-SortId ) ) ) $= ( IMP-sort-17-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-324 BASIC-K-sort-1-is-pattern string-literal-18-is-pattern kore-dv-is-pattern in-sort-is-pattern imp-is-pattern proof-rule-prop-1 proof-rule-mp rule-and-intro-alt2-sugar and-is-pattern IMP-sort-17-sort BASIC-K-sort-1-sort kore-dv-sorting ) ABECDFDNCGHCIABECDFDCDABECDJCDABEKOLFDABEFDJFDABEKPLMCGHCIABECGHCIJCGHCIABEKCGQLM $. $}
