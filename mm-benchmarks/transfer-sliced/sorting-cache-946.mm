$c \top #SetVariable #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern \and \imp \kore-is-sort |- ) ( $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-sort-31-sort $a |- ( \kore-is-sort \kore-sort-SortStmt ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
${ sorting-cache-946 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-is-sort \kore-sort-SortStmt ) ) $= ( kore-is-sort-is-pattern IMP-sort-31-is-pattern typecode-cache-Pattern-0 top-is-pattern and-is-pattern imp-is-pattern proof-rule-prop-1 IMP-sort-31-sort proof-rule-mp ) CBADBEFCBGCBADBEFHIJ $. $}
