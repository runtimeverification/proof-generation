$c \top #SetVariable \kore-symbol-Lbl'Unds'-Int'Unds' #ElementVariable #Symbol #Variable #Pattern "10" \and \kore-sort-SortKItem \imp \kore-dv \kore-is-sort |- "100" ) \kore-inj \kore-sort-SortInt \in-sort ( $.
$v ph0 ph2 ptn1 ptn2 ptn0 ph1 $.
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
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-162-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-Int'Unds' ptn0 ptn1 ) $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-16-is-pattern $a #Pattern "100" $.
sorting-cache-2 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortKItem ) ) $.
sorting-cache-13 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortInt ) ) $.
sorting-cache-204 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Unds'-Int'Unds' ( \kore-dv \kore-sort-SortInt "100" ) ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-sort-SortInt ) ) $.
${ sorting-cache-205 $p |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds'-Int'Unds' ( \kore-dv \kore-sort-SortInt "100" ) ( \kore-dv \kore-sort-SortInt "10" ) ) ) \kore-sort-SortKItem ) ) $= ( IMP-sort-23-is-pattern kore-dv-is-pattern kore-is-sort-is-pattern BASIC-K-sort-1-is-pattern string-literal-16-is-pattern string-literal-13-is-pattern IMP-symbol-162-is-pattern top-is-pattern and-is-pattern in-sort-is-pattern rule-and-intro-alt2-sugar kore-inj-is-pattern sorting-cache-13 sorting-cache-2 sorting-cache-204 INJ-symbol-0-sorting rule-imp-transitivity ) HACDCIAEBAFBGAJIADAEBAFBGLDJHACDCIAEBAFBGAJHACDCMNKOKADAEBAFBGPQ $. $}
