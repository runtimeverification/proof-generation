$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-dv |- \kore-sort-SortId ) \in-sort \kore-sort-SortMap "balanceTo" ( $.
$v kore-element-var-VE5 ph0 ph1 $.
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
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
${ sorting-cache-2187 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceTo" ) \kore-sort-SortId ) ) $= ( IMP-sort-17-is-pattern in-sort-is-pattern string-literal-17-is-pattern kore-dv-is-pattern typecode-cache-Pattern-253 IMP-sort-14-is-pattern top-is-pattern and-is-pattern imp-is-pattern proof-rule-prop-1 kore-dv-sorting proof-rule-mp ) BDEBCAFGCHIBDEBCJBDEBCAFGCHIKBDLM $. $}
