$c "amount" \kore-symbol-kseq #Variable \kore-sort-SortK \imp \kore-dv |- \kore-sort-SortId ) \and \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-inj \in-sort \kore-symbol-dotk ( $.
$v ph0 ph2 kore-element-var-VE2 ptn1 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-0-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKItem ) ( \in-sort ptn1 \kore-sort-SortK ) ) ( \in-sort ( \kore-symbol-kseq ptn0 ptn1 ) \kore-sort-SortK ) ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
string-literal-14-is-pattern $a #Pattern "amount" $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
sorting-cache-1357 $a |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \and ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-sort-SortKItem ) ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) ) $.
${ sorting-cache-1358 $p |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $= ( IMP-sort-17-is-pattern in-sort-is-pattern BASIC-K-sort-1-is-pattern string-literal-14-is-pattern kore-dv-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern BASIC-K-sort-0-is-pattern typecode-cache-Pattern-177 IMP-sort-28-is-pattern and-is-pattern KSEQ-symbol-0-is-pattern sorting-cache-1357 KSEQ-symbol-0-sorting rule-imp-transitivity ) AJKCBDBEFGDCHICLBDBEFGHMICANBDBEFGHOP $. $}
