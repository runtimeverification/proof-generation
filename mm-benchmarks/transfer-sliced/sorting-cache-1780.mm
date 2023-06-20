$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \kore-sort-SortBool \and \imp \kore-dv |- ) \in-sort "false" ( $.
$v kore-element-var-VE6 ph0 ph1 $.
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
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
kore-element-var-VE6-elementvariable $f #ElementVariable kore-element-var-VE6 $.
string-literal-5-is-pattern $a #Pattern "false" $.
typecode-cache-Pattern-356 $a #Pattern kore-element-var-VE6 $.
${ sorting-cache-1780 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortBool "false" ) \kore-sort-SortBool ) ) $= ( IMP-sort-32-is-pattern in-sort-is-pattern string-literal-5-is-pattern kore-dv-is-pattern typecode-cache-Pattern-356 IMP-sort-18-is-pattern top-is-pattern and-is-pattern imp-is-pattern proof-rule-prop-1 kore-dv-sorting proof-rule-mp ) BDEBCAFGCHIBDEBCJBDEBCAFGCHIKBDLM $. $}
