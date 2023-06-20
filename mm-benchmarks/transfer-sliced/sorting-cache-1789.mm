$c \top \kore-symbol-kseq #Variable \kore-sort-SortBool \kore-sort-SortK \imp \kore-dv \kore-is-sort |- ) "false" \and \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-inj \in-sort \kore-symbol-dotk ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-VE1 ptn1 ptn0 ph1 $.
$d kore-sort-var-R kore-element-var-VE1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-0-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKItem ) ( \in-sort ptn1 \kore-sort-SortK ) ) ( \in-sort ( \kore-symbol-kseq ptn0 ptn1 ) \kore-sort-SortK ) ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
KSEQ-symbol-1-sorting $a |- ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
string-literal-5-is-pattern $a #Pattern "false" $.
typecode-cache-Pattern-327 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortKResult ) \top ) ) $.
sorting-cache-1788 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortKResult ) \top ) ) ( \in-sort ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-sort-SortKItem ) ) $.
${ sorting-cache-1789 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortKResult ) \top ) ) ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $= ( IMP-sort-32-is-pattern in-sort-is-pattern KSEQ-symbol-1-is-pattern BASIC-K-sort-1-is-pattern BASIC-K-sort-0-is-pattern typecode-cache-Pattern-327 string-literal-5-is-pattern kore-dv-is-pattern kore-inj-is-pattern and-is-pattern KSEQ-symbol-0-is-pattern sorting-cache-1788 imp-is-pattern proof-rule-prop-1 KSEQ-symbol-1-sorting proof-rule-mp rule-and-intro-alt2-sugar KSEQ-symbol-0-sorting rule-imp-transitivity ) ABHCFCIJKFDEGDLCFCIJKEMGDABHCFCIJKFDEGDABNEGDABHEGDOEGDABHPQRSCFCIJKETUA $. $}
