$c \top #Variable "200" \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortInt \in-sort \kore-sort-SortMap "balanceTo" ( $.
$v kore-sort-var-R ph0 ph2 ptn1 kore-element-var-K3 ptn2 ptn0 ph1 kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K2 $.
$d kore-element-var-K3 kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K3 $.
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-K2-elementvariable $f #ElementVariable kore-element-var-K2 $.
kore-element-var-K3-elementvariable $f #ElementVariable kore-element-var-K3 $.
string-literal-15-is-pattern $a #Pattern "200" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-210 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) $.
sorting-cache-784 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) ( \and ( \and ( \kore-is-sort \kore-sort-SortId ) ( \kore-is-sort \kore-sort-SortKItem ) ) ( \in-sort ( \kore-dv \kore-sort-SortId "balanceTo" ) \kore-sort-SortId ) ) ) $.
sorting-cache-1230 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) ( \and ( \and ( \kore-is-sort \kore-sort-SortInt ) ( \kore-is-sort \kore-sort-SortKItem ) ) ( \in-sort ( \kore-dv \kore-sort-SortInt "200" ) \kore-sort-SortInt ) ) ) $.
${ sorting-cache-1231 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) ( \and ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-sort-SortKItem ) ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) \kore-sort-SortKItem ) ) ) $= ( BASIC-K-sort-1-is-pattern IMP-sort-17-is-pattern IMP-sort-23-is-pattern kore-dv-is-pattern in-sort-is-pattern string-literal-17-is-pattern kore-inj-is-pattern string-literal-15-is-pattern kore-is-sort-is-pattern and-is-pattern typecode-cache-Pattern-210 INJ-symbol-0-sorting rule-imp-transitivity sorting-cache-784 sorting-cache-1230 rule-and-intro-alt2-sugar ) ABCNEDEIGJDHFDFKGJDHABCNELDLMEIGEHMEDEIGJDHABCQEDEIGOPABCNFLDLMFKGFHMFDFKGJDHABCRFDFKGOPS $. $}
