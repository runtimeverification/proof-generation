$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-is-sort |- ) ( $.
$v kore-sort-var-R ph0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
BASIC-K-sort-1-sort $a |- ( \kore-is-sort \kore-sort-SortKItem ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
${ sorting-cache-425 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-is-sort \kore-sort-SortKItem ) ) $= ( kore-is-sort-is-pattern BASIC-K-sort-1-is-pattern typecode-cache-Pattern-0 top-is-pattern and-is-pattern imp-is-pattern proof-rule-prop-1 BASIC-K-sort-1-sort proof-rule-mp ) CBADBEFCBGCBADBEFHIJ $. $}
