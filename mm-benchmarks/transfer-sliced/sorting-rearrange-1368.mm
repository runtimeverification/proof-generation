$c \top \kore-symbol-kseq #Variable \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-forall \and \kore-and \kore-sort-SortKResult #SetVariable \kore-top #ElementVariable #Symbol #Pattern \kore-not \kore-sort-SortKItem \kore-in \kore-inj \in-sort \kore-symbol-dotk "balanceTo" ( $.
$v kore-sort-var-R ph0 ph2 x th0 kore-element-var-VE2 ptn1 ph3 ptn0 ph1 $.
$d kore-sort-var-R x $.
$d kore-sort-var-R kore-element-var-VE2 $.
$d kore-element-var-VE2 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-not-is-pattern $a #Pattern ( \kore-not ph0 ph1 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-forall-is-pattern $a #Pattern ( \kore-forall ph0 ph1 x ph2 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ $d x th0 $.
   $d x ph0 $.
   kore-forall-intro-alt.0 $e |- ( \imp ( \and ( \in-sort x ph2 ) th0 ) ( \kore-valid ph0 ph1 ) ) $.
   kore-forall-intro-alt $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-forall ph2 ph0 x ph1 ) ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-284 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) \top ) ) $.
typecode-cache-Pattern-285 $a #Pattern ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
sorting-cache-1219 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) \top ) ) ) $.
sorting-rearrange-1366 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-not kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) ) $.
${ sorting-rearrange-1368 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-forall \kore-sort-SortKResult kore-sort-var-R kore-element-var-VE2 ( \kore-not kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern kore-top-is-pattern IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern kore-and-is-pattern IMP-sort-28-is-pattern rule-imp-transitivity BASIC-K-sort-0-is-pattern string-literal-17-is-pattern kore-dv-is-pattern typecode-cache-Pattern-177 kore-in-is-pattern kore-not-is-pattern kore-valid-is-pattern and-elim-left-sugar kore-forall-is-pattern imp-reflexivity top-intro rule-weakening rule-and-intro-alt2-sugar typecode-cache-Pattern-285 typecode-cache-Pattern-284 sorting-cache-1219 sorting-rearrange-1366 kore-forall-intro-alt ) ACFEDACFEDEDDACFEDACNACACACACGACPACHIHQRJKLNIBSJKLTACGMMUABUDUBACFEDACFEDEDDACFEACFEDACFEDEDDACFEDACFACFEDACFEDEDUCACFEDACFACFACFEUCACFUEOOACFEDACFEDEDDEUFUGUHACACACACGACPACHIHQRJKLNIBSJKLTACGMMUANACFEDBABUIABUJACACACACGACPACHIHQRJKLNIBSJKLTACGMMUAUBABUKABULOUMO $. $}
