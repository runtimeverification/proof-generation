$c "amount" \top \kore-symbol-kseq #Variable \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-inj \in-sort \kore-symbol-dotk ( $.
$v kore-sort-var-R ph0 ph2 ptn1 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
string-literal-14-is-pattern $a #Pattern "amount" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-1352 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
${ sorting-cache-1353 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-symbol-dotk ) \kore-sort-SortK ) \top ) ) $= ( top-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern and-is-pattern IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern string-literal-14-is-pattern kore-dv-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern BASIC-K-sort-0-is-pattern in-sort-is-pattern sorting-cache-1352 top-intro rule-weakening rule-and-intro-alt2-sugar ) ACDBEFGFHIJKLMNBAOACDBEBPQR $. $}
