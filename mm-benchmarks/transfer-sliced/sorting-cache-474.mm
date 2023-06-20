$c \top #SetVariable \kore-sort-SortKConfigVar #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) ( $.
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
IMP-sort-20-is-pattern $a #Pattern \kore-sort-SortKConfigVar $.
IMP-sort-20-sort $a |- ( \kore-is-sort \kore-sort-SortKConfigVar ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
${ sorting-cache-474 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ( \kore-is-sort \kore-sort-SortKConfigVar ) ) $= ( kore-is-sort-is-pattern top-is-pattern and-is-pattern IMP-sort-20-is-pattern typecode-cache-Pattern-0 imp-is-pattern proof-rule-prop-1 IMP-sort-20-sort proof-rule-mp ) EBAFBCDCDEBGEBAFBCDCDHIJ $. $}
