$c \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "12345" \top "balanceSender" "amount" #Variable "10" "90" \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \and #SetVariable #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortInt "addressTo" \in-sort \kore-sort-SortMap ( $.
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
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
IMP-symbol-194-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ptn1 \kore-sort-SortMap ) ) ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) \kore-sort-SortMap ) ) $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
string-literal-19-is-pattern $a #Pattern "90" $.
sorting-cache-1041 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-1056 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-2126 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) \kore-sort-SortMap ) ) $.
${ sorting-cache-2189 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) \kore-sort-SortMap ) ) $= ( IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern IMP-symbol-218-is-pattern IMP-sort-14-is-pattern in-sort-is-pattern string-literal-18-is-pattern string-literal-12-is-pattern string-literal-14-is-pattern string-literal-13-is-pattern and-is-pattern IMP-symbol-194-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern top-is-pattern string-literal-10-is-pattern string-literal-19-is-pattern rule-and-intro-alt2-sugar IMP-symbol-194-sorting rule-imp-transitivity sorting-cache-2126 sorting-cache-1041 sorting-cache-1056 ) APQRNBCBSDEFCFTDEGHIBCBJDEFCFKDEGBCBLDEFCFMDEGOHINBCBSDEFCFTDEGBCBJDEFCFKDEGBCBLDEFCFMDEGOOHIAPQRNBCBSDEFCFTDEGHIBCBJDEFCFKDEGBCBLDEFCFMDEGOHIAUDAPQRNBCBJDEFCFKDEGHIBCBLDEFCFMDEGHINBCBJDEFCFKDEGBCBLDEFCFMDEGOHIAPQRNBCBJDEFCFKDEGHIBCBLDEFCFMDEGHIAUEAUFUABCBJDEFCFKDEGBCBLDEFCFMDEGUBUCUABCBSDEFCFTDEGBCBJDEFCFKDEGBCBLDEFCFMDEGOUBUC $. $}
