$c \top #SetVariable "balanceSender" \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \and \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \in-sort ( $.
$v kore-element-var-VE5 ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
sorting-cache-1159 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortBlock ) \top ) ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortAExp ) ) ) $.
sorting-cache-1163 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortBlock ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceSender" ) \kore-sort-SortId ) ) $.
${ sorting-cache-1164 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortBlock ) \top ) ( \and ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortAExp ) ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceSender" ) \kore-sort-SortId ) ) ) $= ( IMP-sort-17-is-pattern in-sort-is-pattern and-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-253 IMP-sort-18-is-pattern top-is-pattern IMP-sort-13-is-pattern string-literal-10-is-pattern kore-dv-is-pattern sorting-cache-1159 sorting-cache-1163 rule-and-intro-alt2-sugar ) AFGCHDBEIEDBJKBCALAMN $. $}
