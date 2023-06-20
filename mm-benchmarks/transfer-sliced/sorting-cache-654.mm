$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern "200" \kore-sort-SortIds \and \imp \kore-dv |- ) \kore-sort-SortInt \in-sort ( $.
$v kore-element-var-VE4 ph0 ph1 $.
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
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
string-literal-15-is-pattern $a #Pattern "200" $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
${ sorting-cache-654 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortInt "200" ) \kore-sort-SortInt ) ) $= ( IMP-sort-23-is-pattern in-sort-is-pattern string-literal-15-is-pattern kore-dv-is-pattern typecode-cache-Pattern-179 IMP-sort-0-is-pattern top-is-pattern and-is-pattern imp-is-pattern proof-rule-prop-1 kore-dv-sorting proof-rule-mp ) BDEBCAFGCHIBDEBCJBDEBCAFGCHIKBDLM $. $}
