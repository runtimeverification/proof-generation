$c \top #SetVariable \kore-sort-SortKConfigVar #ElementVariable "%24PGM" #Symbol #Variable #Pattern \and \imp \kore-dv \kore-is-sort |- ) \in-sort ( $.
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
IMP-sort-20-is-pattern $a #Pattern \kore-sort-SortKConfigVar $.
string-literal-9-is-pattern $a #Pattern "%24PGM" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
${ sorting-cache-477 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortKConfigVar "%24PGM" ) \kore-sort-SortKConfigVar ) ) $= ( IMP-sort-20-is-pattern string-literal-9-is-pattern top-is-pattern and-is-pattern kore-dv-is-pattern in-sort-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern imp-is-pattern proof-rule-prop-1 kore-dv-sorting proof-rule-mp ) BCFBGAHIDEDEBCFBGJBCFBGAHIDEDEKBCLM $. $}
