$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortBlock \and \imp \kore-is-sort |- ) \in-sort ( $.
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
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-13-sort $a |- ( \kore-is-sort \kore-sort-SortAExp ) $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
${ sorting-cache-1158 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortBlock ) \top ) ( \kore-is-sort \kore-sort-SortAExp ) ) $= ( IMP-sort-13-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-253 IMP-sort-18-is-pattern in-sort-is-pattern top-is-pattern and-is-pattern imp-is-pattern proof-rule-prop-1 IMP-sort-13-sort proof-rule-mp ) BCADEFGHBCIBCADEFGHJKL $. $}
