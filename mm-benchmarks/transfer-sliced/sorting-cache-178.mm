$c \top #Variable "10" \kore-sort-SortBool \imp \kore-dv \kore-is-sort \kore-symbol-Lbl'Unds-GT-'Int'Unds' |- ) \and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem "100" \kore-inj \kore-sort-SortInt \in-sort ( $.
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
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-190-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' ptn0 ptn1 ) $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-16-is-pattern $a #Pattern "100" $.
sorting-cache-2 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortKItem ) ) $.
sorting-cache-176 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortBool ) ) $.
sorting-cache-177 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' ( \kore-dv \kore-sort-SortInt "10" ) ( \kore-dv \kore-sort-SortInt "100" ) ) \kore-sort-SortBool ) ) $.
${ sorting-cache-178 $p |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' ( \kore-dv \kore-sort-SortInt "10" ) ( \kore-dv \kore-sort-SortInt "100" ) ) ) \kore-sort-SortKItem ) ) $= ( IMP-sort-23-is-pattern kore-dv-is-pattern IMP-sort-32-is-pattern kore-is-sort-is-pattern BASIC-K-sort-1-is-pattern string-literal-13-is-pattern string-literal-16-is-pattern IMP-symbol-190-is-pattern top-is-pattern and-is-pattern in-sort-is-pattern rule-and-intro-alt2-sugar kore-inj-is-pattern sorting-cache-176 sorting-cache-2 sorting-cache-177 INJ-symbol-0-sorting rule-imp-transitivity ) ICDEDJAFBAGBHCKJCEAFBAGBHMEKICDEDJAFBAGBHCKICDEDNOLPLCEAFBAGBHQR $. $}
