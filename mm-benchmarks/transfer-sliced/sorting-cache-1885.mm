$c \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "12345" \top #Variable \imp \kore-dv |- \kore-sort-SortId ) \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortBlock \kore-sort-SortKItem \kore-inj \kore-sort-SortInt "addressTo" \in-sort \kore-sort-SortMap ( $.
$v ph0 ph2 ptn1 kore-element-var-VE4 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
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
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
IMP-symbol-218-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKItem ) ( \in-sort ptn1 \kore-sort-SortKItem ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) \kore-sort-SortMap ) ) $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
sorting-cache-1881 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) \kore-sort-SortKItem ) ) $.
sorting-cache-1884 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) \kore-sort-SortKItem ) ) $.
${ sorting-cache-1885 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) \kore-sort-SortMap ) ) $= ( BASIC-K-sort-1-is-pattern IMP-sort-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern in-sort-is-pattern string-literal-18-is-pattern string-literal-12-is-pattern and-is-pattern typecode-cache-Pattern-179 IMP-sort-18-is-pattern top-is-pattern IMP-symbol-218-is-pattern IMP-sort-14-is-pattern sorting-cache-1881 sorting-cache-1884 rule-and-intro-alt2-sugar IMP-symbol-218-sorting rule-imp-transitivity ) AKLGMJCBCHDEBGFBFIDEBGJCBCHDEFBFIDENOGAKLGMJCBCHDEBGFBFIDEBGAPAQRCBCHDEFBFIDEST $. $}
