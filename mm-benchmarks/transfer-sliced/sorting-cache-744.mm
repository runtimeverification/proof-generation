$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-is-sort |- \kore-sort-SortId ) \in-sort \kore-sort-SortMap ( $.
$v kore-sort-var-R ph0 kore-element-var-K3 ph2 ph1 $.
$d kore-sort-var-R kore-element-var-K3 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
BASIC-K-sort-1-sort $a |- ( \kore-is-sort \kore-sort-SortKItem ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-17-sort $a |- ( \kore-is-sort \kore-sort-SortId ) $.
kore-element-var-K3-elementvariable $f #ElementVariable kore-element-var-K3 $.
typecode-cache-Pattern-215 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) $.
${ sorting-cache-744 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $= ( kore-is-sort-is-pattern typecode-cache-Pattern-215 IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern imp-is-pattern proof-rule-prop-1 proof-rule-mp IMP-sort-17-sort BASIC-K-sort-1-sort rule-and-intro-alt2-sugar ) ABDECFCECABDECGECABDHJIFCABDFCGFCABDHKIL $. $}
