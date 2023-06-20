$c \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "amount" \top "balanceSender" \kore-symbol-Lbl'-LT-'state'-GT-' #Variable \imp \kore-dv "0" |- \kore-sort-SortId ) \and \kore-symbol-Lbl'Stop'Map #SetVariable #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortInt "addressTo" \in-sort \kore-sort-SortMap \kore-sort-SortStateCell "balanceTo" ( $.
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
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
IMP-symbol-132-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) $.
IMP-symbol-132-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) \kore-sort-SortStateCell ) ) $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
IMP-symbol-194-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ptn1 \kore-sort-SortMap ) ) ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) \kore-sort-SortMap ) ) $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
sorting-cache-44 $a |- ( \imp \top ( \in-sort \kore-symbol-Lbl'Stop'Map \kore-sort-SortMap ) ) $.
sorting-cache-47 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-53 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-56 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-59 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
${ sorting-cache-790 $p |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) \kore-symbol-Lbl'Stop'Map ) ) \kore-sort-SortStateCell ) ) $= ( IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern string-literal-1-is-pattern IMP-symbol-218-is-pattern IMP-symbol-194-is-pattern in-sort-is-pattern IMP-sort-14-is-pattern string-literal-17-is-pattern string-literal-14-is-pattern string-literal-18-is-pattern string-literal-10-is-pattern top-is-pattern IMP-symbol-124-is-pattern rule-imp-transitivity and-is-pattern rule-and-intro-alt2-sugar IMP-symbol-194-sorting IMP-symbol-132-is-pattern IMP-sort-9-is-pattern sorting-cache-56 sorting-cache-47 sorting-cache-59 sorting-cache-53 sorting-cache-44 IMP-symbol-132-sorting ) OABANCDEBEFCDGABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHHPHJIABANCDEBEFCDGABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHHPHUAUBIOABANCDEBEFCDGABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHHJIPJIRABANCDEBEFCDGABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHHPHJIOABANCDEBEFCDGABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHHJIPJIOABANCDEBEFCDGJIABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHJIRABANCDEBEFCDGABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHHJIOABANCDEBEFCDGJIABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHJIUCOABAMCDEBEFCDGJIABAKCDEBEFCDGABALCDEBEFCDGHJIRABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHJIOABAMCDEBEFCDGJIABAKCDEBEFCDGABALCDEBEFCDGHJIUDOABAKCDEBEFCDGJIABALCDEBEFCDGJIRABAKCDEBEFCDGABALCDEBEFCDGHJIOABAKCDEBEFCDGJIABALCDEBEFCDGJIUEUFSABAKCDEBEFCDGABALCDEBEFCDGTQSABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHTQSABANCDEBEFCDGABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHTQUGSABANCDEBEFCDGABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHHPTQABANCDEBEFCDGABAMCDEBEFCDGABAKCDEBEFCDGABALCDEBEFCDGHHHPHUHQ $. $}
