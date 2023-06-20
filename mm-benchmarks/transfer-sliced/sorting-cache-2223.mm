$c \top \kore-symbol-kseq #Variable "200" \kore-sort-SortK \imp \kore-dv \kore-is-sort |- ) \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortInt \in-sort \kore-symbol-dotk ( $.
$v kore-sort-var-R ph0 ph2 ptn1 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-0-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKItem ) ( \in-sort ptn1 \kore-sort-SortK ) ) ( \in-sort ( \kore-symbol-kseq ptn0 ptn1 ) \kore-sort-SortK ) ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
string-literal-15-is-pattern $a #Pattern "200" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-2222 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) \kore-sort-SortKItem ) ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) ) $.
${ sorting-cache-2223 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $= ( IMP-sort-23-is-pattern BASIC-K-sort-1-is-pattern string-literal-15-is-pattern kore-dv-is-pattern kore-inj-is-pattern in-sort-is-pattern KSEQ-symbol-1-is-pattern and-is-pattern BASIC-K-sort-0-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern top-is-pattern KSEQ-symbol-0-is-pattern sorting-cache-2222 KSEQ-symbol-0-sorting rule-imp-transitivity ) AKLMIBCBDEFCGHJGIBCBDEFHNJGAOBCBDEFHPQ $. $}
