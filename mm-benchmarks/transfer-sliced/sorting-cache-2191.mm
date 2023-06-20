$c \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' \top "balanceSender" #Variable "90" \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortInt \in-sort \kore-sort-SortMap ( $.
$v kore-sort-var-R ph0 ph2 ptn1 kore-element-var-K3 ptn0 ph1 $.
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
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
IMP-symbol-218-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKItem ) ( \in-sort ptn1 \kore-sort-SortKItem ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) \kore-sort-SortMap ) ) $.
kore-element-var-K3-elementvariable $f #ElementVariable kore-element-var-K3 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-19-is-pattern $a #Pattern "90" $.
typecode-cache-Pattern-215 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) $.
sorting-cache-1033 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) \kore-sort-SortKItem ) ) $.
sorting-cache-2190 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) \kore-sort-SortKItem ) ) $.
${ sorting-cache-2191 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) \kore-sort-SortMap ) ) $= ( BASIC-K-sort-1-is-pattern IMP-sort-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern in-sort-is-pattern string-literal-10-is-pattern string-literal-19-is-pattern typecode-cache-Pattern-215 and-is-pattern IMP-symbol-218-is-pattern IMP-sort-14-is-pattern sorting-cache-1033 sorting-cache-2190 rule-and-intro-alt2-sugar IMP-symbol-218-sorting rule-imp-transitivity ) ABKDCDIEFCHGCGJEFCHLDCDIEFGCGJEFMNHABKDCDIEFCHGCGJEFCHABOABPQDCDIEFGCGJEFRS $. $}
