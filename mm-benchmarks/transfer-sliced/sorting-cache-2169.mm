$c \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp \kore-dv \kore-sort-SortK |- \kore-sort-SortId ) \kore-inj \in-sort \kore-symbol-dotk "balanceTo" ( $.
$v ph0 ph2 ph1 kore-element-var-VE2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
sorting-cache-1207 $a |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) $.
sorting-cache-2168 $a |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-sort-SortKItem ) ) $.
${ sorting-cache-2169 $p |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \and ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-sort-SortKItem ) ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) ) $= ( in-sort-is-pattern IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern typecode-cache-Pattern-177 IMP-sort-28-is-pattern string-literal-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern BASIC-K-sort-0-is-pattern sorting-cache-2168 sorting-cache-1207 rule-and-intro-alt2-sugar ) AEFBCDCGHIDBJKBALAMN $. $}
