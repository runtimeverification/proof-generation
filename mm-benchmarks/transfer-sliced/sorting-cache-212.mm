$c \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "12345" \top "balanceSender" "amount" \kore-symbol-Lbl'-LT-'state'-GT-' #Variable "10" "90" "200" \imp \kore-dv "0" |- \kore-sort-SortId ) \and #SetVariable #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol #Pattern \kore-sort-SortKItem "ret" \kore-inj \kore-sort-SortInt "addressTo" \in-sort \kore-sort-SortMap \kore-sort-SortStateCell "balanceTo" ( $.
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
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-132-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) $.
IMP-symbol-132-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) \kore-sort-SortStateCell ) ) $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
IMP-symbol-194-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ptn1 \kore-sort-SortMap ) ) ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) \kore-sort-SortMap ) ) $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-15-is-pattern $a #Pattern "200" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
sorting-cache-62 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-75 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-78 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-85 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) \kore-sort-SortMap ) ) $.
string-literal-19-is-pattern $a #Pattern "90" $.
sorting-cache-211 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) \kore-sort-SortMap ) ) $.
${ sorting-cache-212 $p |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) \kore-sort-SortStateCell ) ) $= ( IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern IMP-symbol-218-is-pattern IMP-symbol-194-is-pattern in-sort-is-pattern IMP-sort-14-is-pattern string-literal-17-is-pattern string-literal-15-is-pattern string-literal-14-is-pattern string-literal-13-is-pattern string-literal-18-is-pattern string-literal-12-is-pattern string-literal-11-is-pattern string-literal-1-is-pattern top-is-pattern string-literal-10-is-pattern string-literal-19-is-pattern rule-imp-transitivity and-is-pattern rule-and-intro-alt2-sugar IMP-symbol-194-sorting IMP-symbol-132-is-pattern IMP-sort-9-is-pattern sorting-cache-211 sorting-cache-62 sorting-cache-75 sorting-cache-85 sorting-cache-78 IMP-symbol-132-sorting ) RABASCDEBETCDFABAPCDEBEQCDFABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGGGIHABASCDEBETCDFABAPCDEBEQCDFABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGGGUEUFHRABASCDEBETCDFIHABAPCDEBEQCDFABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGGIHUBABASCDEBETCDFABAPCDEBEQCDFABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGGGIHRABASCDEBETCDFIHABAPCDEBEQCDFABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGGIHUGRABAPCDEBEQCDFIHABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGIHUBABAPCDEBEQCDFABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGGIHRABAPCDEBEQCDFIHABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGIHUHRABANCDEBEOCDFIHABAJCDEBEKCDFABALCDEBEMCDFGIHUBABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGIHRABANCDEBEOCDFIHABAJCDEBEKCDFABALCDEBEMCDFGIHUIRABAJCDEBEKCDFIHABALCDEBEMCDFIHUBABAJCDEBEKCDFABALCDEBEMCDFGIHRABAJCDEBEKCDFIHABALCDEBEMCDFIHUJUKUCABAJCDEBEKCDFABALCDEBEMCDFUDUAUCABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGUDUAUCABAPCDEBEQCDFABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGUDUAUCABASCDEBETCDFABAPCDEBEQCDFABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGGUDUAABASCDEBETCDFABAPCDEBEQCDFABANCDEBEOCDFABAJCDEBEKCDFABALCDEBEMCDFGGGGULUA $. $}
