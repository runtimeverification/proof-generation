$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern "90" \and \imp \kore-dv \kore-is-sort |- ) \kore-sort-SortInt \in-sort ( $.
$v kore-sort-var-R ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
string-literal-19-is-pattern $a #Pattern "90" $.
sorting-cache-2094 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortInt "90" ) \kore-sort-SortInt ) ) $.
${ sorting-cache-2095 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort ( \kore-dv \kore-sort-SortInt "90" ) \kore-sort-SortInt ) \top ) ) $= ( top-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern and-is-pattern IMP-sort-23-is-pattern string-literal-19-is-pattern kore-dv-is-pattern in-sort-is-pattern sorting-cache-2094 top-intro rule-weakening rule-and-intro-alt2-sugar ) ACDBEFGHFIBAJACDBEBKLM $. $}
