$c "amount" \top "balanceSender" \kore-sort-SortAExp #Variable \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortBlock \kore-inj \in-sort ( $.
$v kore-sort-var-R ph0 ph2 ptn1 ptn2 ptn0 kore-element-var-K1 ph1 kore-element-var-K2 $.
$d kore-element-var-K1 kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
kore-element-var-K2-elementvariable $f #ElementVariable kore-element-var-K2 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
typecode-cache-Pattern-121 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) ) $.
sorting-cache-365 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortAExp ) ) ( \in-sort ( \kore-dv \kore-sort-SortId "amount" ) \kore-sort-SortId ) ) ) $.
sorting-cache-366 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortAExp ) ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceSender" ) \kore-sort-SortId ) ) ) $.
${ sorting-cache-367 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-sort-SortAExp ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) \kore-sort-SortAExp ) ) ) $= ( IMP-sort-17-is-pattern IMP-sort-13-is-pattern kore-dv-is-pattern in-sort-is-pattern string-literal-14-is-pattern kore-inj-is-pattern string-literal-10-is-pattern kore-is-sort-is-pattern and-is-pattern typecode-cache-Pattern-121 INJ-symbol-0-sorting rule-imp-transitivity sorting-cache-365 sorting-cache-366 rule-and-intro-alt2-sugar ) ABCMDEDHFIEGDEDJFIEGABCMDKEKLDHFDGLDEDHFIEGABCPDEDHFNOABCMDKEKLDJFDGLDEDJFIEGABCQDEDJFNOR $. $}
