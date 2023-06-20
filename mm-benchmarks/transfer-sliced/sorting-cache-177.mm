$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern "10" \kore-sort-SortBool \and \imp \kore-dv \kore-symbol-Lbl'Unds-GT-'Int'Unds' |- "100" ) \kore-sort-SortInt \in-sort ( $.
$v ph0 ph2 ptn0 ph1 ptn1 $.
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
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-190-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' ptn0 ptn1 ) $.
IMP-symbol-190-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortInt ) ( \in-sort ptn1 \kore-sort-SortInt ) ) ( \in-sort ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' ptn0 ptn1 ) \kore-sort-SortBool ) ) $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-16-is-pattern $a #Pattern "100" $.
sorting-cache-18 $a |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortInt "10" ) \kore-sort-SortInt ) ) $.
sorting-cache-22 $a |- ( \imp \top ( \in-sort ( \kore-dv \kore-sort-SortInt "100" ) \kore-sort-SortInt ) ) $.
${ sorting-cache-177 $p |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' ( \kore-dv \kore-sort-SortInt "10" ) ( \kore-dv \kore-sort-SortInt "100" ) ) \kore-sort-SortBool ) ) $= ( IMP-sort-23-is-pattern kore-dv-is-pattern in-sort-is-pattern string-literal-13-is-pattern string-literal-16-is-pattern top-is-pattern and-is-pattern IMP-symbol-190-is-pattern IMP-sort-32-is-pattern sorting-cache-18 sorting-cache-22 rule-and-intro-alt2-sugar IMP-symbol-190-sorting rule-imp-transitivity ) FADBACAEBACGADBAEBHICFADBACAEBACJKLADBAEBMN $. $}
