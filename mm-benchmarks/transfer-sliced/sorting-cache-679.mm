$c "1" \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \kore-sort-SortIds \and \imp \kore-dv \kore-is-sort |- ) \kore-sort-SortInt \in-sort ( $.
$v kore-element-var-VE4 ph0 ph2 ph1 $.
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
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
string-literal-4-is-pattern $a #Pattern "1" $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
sorting-cache-637 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \kore-is-sort \kore-sort-SortAExp ) ) ) $.
sorting-cache-678 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortInt "1" ) \kore-sort-SortInt ) ) $.
${ sorting-cache-679 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ( \and ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \kore-is-sort \kore-sort-SortAExp ) ) ( \in-sort ( \kore-dv \kore-sort-SortInt "1" ) \kore-sort-SortInt ) ) ) $= ( IMP-sort-23-is-pattern in-sort-is-pattern and-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-179 IMP-sort-0-is-pattern top-is-pattern IMP-sort-13-is-pattern string-literal-4-is-pattern kore-dv-is-pattern sorting-cache-637 sorting-cache-678 rule-and-intro-alt2-sugar ) AFGCHDBEIEDBJKBCALAMN $. $}
