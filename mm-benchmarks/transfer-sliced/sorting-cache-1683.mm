$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \kore-sort-SortInt \in-sort "balanceTo" ( $.
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
sorting-cache-1661 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $.
sorting-cache-1682 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceTo" ) \kore-sort-SortId ) ) $.
${ sorting-cache-1683 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ( \and ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortKItem ) ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceTo" ) \kore-sort-SortId ) ) ) $= ( IMP-sort-17-is-pattern in-sort-is-pattern and-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-179 IMP-sort-23-is-pattern top-is-pattern BASIC-K-sort-1-is-pattern string-literal-17-is-pattern kore-dv-is-pattern sorting-cache-1661 sorting-cache-1682 rule-and-intro-alt2-sugar ) AFGCHDBEIEDBJKBCALAMN $. $}
