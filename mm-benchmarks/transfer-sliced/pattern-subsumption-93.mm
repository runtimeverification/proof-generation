$c "1" \kore-symbol-Lbl'-LT-'T'-GT-' "12345" \top \kore-sort-SortAExp "210" \kore-symbol-kseq \kore-implies "90" \imp "0" ) \kore-and #SetVariable \kore-top #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' "ret" \kore-inj \kore-sort-SortInt \kore-sort-SortGeneratedCounterCell "addressTo" \kore-sort-SortTCell \in-sort "balanceTo" ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "amount" "balanceSender" \kore-symbol-Lbl'-LT-'state'-GT-' \kore-sort-SortStmt #Variable "10" \kore-dv |- \kore-sort-SortId \kore-valid \kore-symbol-Lbl'-LT-'k'-GT-' \and \kore-sort-SortKCell \kore-sort-SortGeneratedTopCell #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' \kore-sort-SortKItem \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-symbol-dotk \kore-sort-SortStateCell $.
$v ph0 ph2 th0 ptn0 ph1 ptn1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
th0-is-pattern $f #Pattern th0 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-and-sorting $a |- ( \imp ( \and ( \in-sort ph1 ph0 ) ( \in-sort ph2 ph0 ) ) ( \in-sort ( \kore-and ph0 ph1 ph2 ) ph0 ) ) $.
${ kore-implies-reflexivity-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-implies-reflexivity-alt $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph1 ) ) ) $. $}
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
IMP-sort-7-is-pattern $a #Pattern \kore-sort-SortKCell $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-30-is-pattern $a #Pattern \kore-sort-SortTCell $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-126-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn0 ptn1 ) $.
IMP-symbol-126-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKCell ) ( \in-sort ptn1 \kore-sort-SortStateCell ) ) ( \in-sort ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn0 ptn1 ) \kore-sort-SortTCell ) ) $.
IMP-symbol-128-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ptn0 ) $.
IMP-symbol-129-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn0 ptn1 ) $.
IMP-symbol-129-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortTCell ) ( \in-sort ptn1 \kore-sort-SortGeneratedCounterCell ) ) ( \in-sort ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn0 ptn1 ) \kore-sort-SortGeneratedTopCell ) ) $.
IMP-symbol-131-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn0 ) $.
IMP-symbol-132-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-4-is-pattern $a #Pattern "1" $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
sorting-cache-0 $a |- ( \imp \top ( \in-sort ( \kore-top \kore-sort-SortGeneratedTopCell ) \kore-sort-SortGeneratedTopCell ) ) $.
sorting-cache-50 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) \kore-sort-SortGeneratedCounterCell ) ) $.
string-literal-19-is-pattern $a #Pattern "90" $.
string-literal-20-is-pattern $a #Pattern "210" $.
sorting-cache-246 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) \kore-sort-SortKCell ) ) $.
sorting-cache-249 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) \kore-sort-SortStateCell ) ) $.
${ pattern-subsumption-93 $p |- ( \imp \top ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-implies \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-top \kore-sort-SortGeneratedTopCell ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-top \kore-sort-SortGeneratedTopCell ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( kore-dv-is-pattern IMP-sort-23-is-pattern kore-inj-is-pattern BASIC-K-sort-1-is-pattern IMP-sort-17-is-pattern IMP-symbol-218-is-pattern IMP-symbol-194-is-pattern IMP-sort-8-is-pattern string-literal-11-is-pattern string-literal-1-is-pattern in-sort-is-pattern kore-top-is-pattern IMP-sort-31-is-pattern IMP-sort-13-is-pattern string-literal-4-is-pattern IMP-symbol-185-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern IMP-symbol-131-is-pattern string-literal-17-is-pattern string-literal-20-is-pattern string-literal-10-is-pattern string-literal-19-is-pattern string-literal-18-is-pattern string-literal-12-is-pattern string-literal-14-is-pattern string-literal-13-is-pattern IMP-symbol-132-is-pattern IMP-symbol-126-is-pattern IMP-symbol-128-is-pattern top-is-pattern kore-and-is-pattern IMP-symbol-129-is-pattern and-is-pattern rule-and-intro-alt2-sugar rule-imp-transitivity IMP-sort-30-is-pattern sorting-cache-0 kore-and-sorting IMP-sort-10-is-pattern IMP-sort-7-is-pattern IMP-sort-9-is-pattern sorting-cache-246 sorting-cache-249 IMP-symbol-126-sorting sorting-cache-50 IMP-symbol-129-sorting kore-implies-reflexivity-alt ) HHHHLHLULMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHUIBJAUJUMULUKUKHHLHLULHKMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHUIBJAUJUMHKUNHHHLHLULMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHUIBJAUJUMULHKUKHHLHLULHKMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHUIBJAUJUMHKUKHLHKHLHKUNHHLHLULHKUKHLHKHLHKURURUOHHLHLUSUPUKMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHUIUQKBJAUJUTKUNMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHUIBJAUJUMHKUKMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHUIUQKBJAUJUTKUKMDEIABNBOACPCQRSVAKEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHVBKUNMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHUIUQKUKMDEIABNBOACPCQRSVAKEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHVBKVCVDUOMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHVEUPVFUOMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHUIBJAUJVGUPUOHHHLHLULMDEIABNBOACPCQRSEDETACBDBUAACFEDEIACBDBJACFEDEUBACBDBUCACFEDEUDACBDBUEACFEDEUFACBDBUGACFGGGGUHUIBJAUJUMUSUPVH $. $}
