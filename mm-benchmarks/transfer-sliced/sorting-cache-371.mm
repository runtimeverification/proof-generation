$c \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-dv "0" \kore-is-sort |- ) \kore-sort-SortInt \in-sort ( $.
$v kore-sort-var-R ph0 ph2 ph1 $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
string-literal-1-is-pattern $a #Pattern "0" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-318 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \kore-is-sort \kore-sort-SortAExp ) ) ) $.
sorting-cache-369 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortInt "0" ) \kore-sort-SortInt ) ) $.
${ sorting-cache-371 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \kore-is-sort \kore-sort-SortAExp ) ) ( \in-sort ( \kore-dv \kore-sort-SortInt "0" ) \kore-sort-SortInt ) ) ) $= ( kore-is-sort-is-pattern IMP-sort-23-is-pattern and-is-pattern typecode-cache-Pattern-0 top-is-pattern IMP-sort-13-is-pattern string-literal-1-is-pattern kore-dv-is-pattern in-sort-is-pattern sorting-cache-318 sorting-cache-369 rule-and-intro-alt2-sugar ) AEBFDCBGBDCHICJAKALM $. $}
