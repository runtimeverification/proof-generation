$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern "10" \and \imp \kore-dv \kore-is-sort |- ) \kore-sort-SortInt \in-sort ( $.
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
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-dv-sorting $a |- ( \in-sort ( \kore-dv ph0 ph1 ) ph0 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
string-literal-13-is-pattern $a #Pattern "10" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
${ sorting-cache-499 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortInt "10" ) \kore-sort-SortInt ) ) $= ( IMP-sort-23-is-pattern string-literal-13-is-pattern top-is-pattern and-is-pattern kore-dv-is-pattern in-sort-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern imp-is-pattern proof-rule-prop-1 kore-dv-sorting proof-rule-mp ) BCFBGAHIDEDEBCFBGJBCFBGAHIDEDEKBCLM $. $}
