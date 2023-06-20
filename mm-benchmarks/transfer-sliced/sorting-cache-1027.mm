$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-dv "0" \kore-is-sort |- ) \kore-sort-SortInt \in-sort \kore-sort-SortMap ( $.
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
sorting-cache-1025 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $.
sorting-cache-1026 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ( \in-sort ( \kore-dv \kore-sort-SortInt "0" ) \kore-sort-SortInt ) ) $.
${ sorting-cache-1027 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ( \and ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \kore-is-sort \kore-sort-SortKItem ) ) ( \in-sort ( \kore-dv \kore-sort-SortInt "0" ) \kore-sort-SortInt ) ) ) $= ( IMP-sort-23-is-pattern in-sort-is-pattern and-is-pattern kore-is-sort-is-pattern typecode-cache-Pattern-253 IMP-sort-14-is-pattern top-is-pattern BASIC-K-sort-1-is-pattern string-literal-1-is-pattern kore-dv-is-pattern sorting-cache-1025 sorting-cache-1026 rule-and-intro-alt2-sugar ) AFGCHDBEIEDBJKBCALAMN $. $}
