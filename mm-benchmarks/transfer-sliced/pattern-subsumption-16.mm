$c "1" \kore-symbol-Lbl'-LT-'T'-GT-' "12345" \top \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-symbol-kseq \kore-implies \kore-sort-SortK \imp "0" ) \kore-and #SetVariable #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' "ret" "100" \kore-inj \kore-sort-SortInt \kore-sort-SortGeneratedCounterCell "addressTo" \kore-sort-SortTCell \in-sort "balanceTo" ( "amount" \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "balanceSender" \kore-sort-SortBExp \kore-symbol-Lbl'-LT-'state'-GT-' \kore-symbol-dotk \kore-sort-SortStmt #Variable "10" \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt "200" \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid \kore-symbol-Lbl'-LT-'k'-GT-' \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \and \kore-sort-SortKCell \kore-sort-SortGeneratedTopCell #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block \kore-sort-SortBlock \kore-sort-SortKItem \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \kore-top \kore-sort-SortMap \kore-sort-SortStateCell $.
$v ph0 ph2 th0 ptn1 ptn2 ph3 ptn0 ph4 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
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
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-and-sorting $a |- ( \imp ( \and ( \in-sort ph1 ph0 ) ( \in-sort ph2 ph0 ) ) ( \in-sort ( \kore-and ph0 ph1 ph2 ) ph0 ) ) $.
kore-top-valid $a |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $.
${ kore-weakening.0 $e |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $.
   kore-weakening $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $. $}
${ kore-implies-reflexivity-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-implies-reflexivity-alt $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph1 ) ) ) $. $}
${ kore-imp-conj-simplify.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-imp-conj-simplify.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
   kore-imp-conj-simplify.2 $e |- ( \imp th0 ( \in-sort ph4 ph0 ) ) $.
   kore-imp-conj-simplify.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
   kore-imp-conj-simplify.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph3 ( \kore-and ph0 ph1 ph4 ) ) ) ) $.
   kore-imp-conj-simplify $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph3 ( \kore-and ph0 ph2 ph4 ) ) ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
ptn2-pattern $f #Pattern ptn2 $.
KSEQ-symbol-0-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKItem ) ( \in-sort ptn1 \kore-sort-SortK ) ) ( \in-sort ( \kore-symbol-kseq ptn0 ptn1 ) \kore-sort-SortK ) ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-7-is-pattern $a #Pattern \kore-sort-SortKCell $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-30-is-pattern $a #Pattern \kore-sort-SortTCell $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-126-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn0 ptn1 ) $.
IMP-symbol-126-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKCell ) ( \in-sort ptn1 \kore-sort-SortStateCell ) ) ( \in-sort ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn0 ptn1 ) \kore-sort-SortTCell ) ) $.
IMP-symbol-128-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ptn0 ) $.
IMP-symbol-129-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn0 ptn1 ) $.
IMP-symbol-129-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortTCell ) ( \in-sort ptn1 \kore-sort-SortGeneratedCounterCell ) ) ( \in-sort ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn0 ptn1 ) \kore-sort-SortGeneratedTopCell ) ) $.
IMP-symbol-131-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn0 ) $.
IMP-symbol-131-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortK ) ( \in-sort ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn0 ) \kore-sort-SortKCell ) ) $.
IMP-symbol-132-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) $.
IMP-symbol-132-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) \kore-sort-SortStateCell ) ) $.
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-192-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
IMP-symbol-194-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ptn1 \kore-sort-SortMap ) ) ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) \kore-sort-SortMap ) ) $.
IMP-symbol-204-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) $.
IMP-symbol-204-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortStmt ) ( \in-sort ptn1 \kore-sort-SortStmt ) ) ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) \kore-sort-SortStmt ) ) $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
IMP-symbol-241-is-pattern $a #Pattern ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) $.
IMP-symbol-241-sorting $a |- ( \imp ( \and ( \and ( \in-sort ptn0 \kore-sort-SortBExp ) ( \in-sort ptn1 \kore-sort-SortBlock ) ) ( \in-sort ptn2 \kore-sort-SortBlock ) ) ( \in-sort ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) \kore-sort-SortStmt ) ) $.
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
IMP-symbol-354-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortStmt ) ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) \kore-sort-SortBlock ) ) $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-4-is-pattern $a #Pattern "1" $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-15-is-pattern $a #Pattern "200" $.
string-literal-16-is-pattern $a #Pattern "100" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
sorting-cache-0 $a |- ( \imp \top ( \in-sort ( \kore-top \kore-sort-SortGeneratedTopCell ) \kore-sort-SortGeneratedTopCell ) ) $.
sorting-cache-2 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortKItem ) ) $.
sorting-cache-31 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) \kore-sort-SortBExp ) ) $.
sorting-cache-35 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) \kore-sort-SortBlock ) ) $.
sorting-cache-39 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-42 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-43 $a |- ( \imp \top ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) $.
sorting-cache-47 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-50 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) \kore-sort-SortGeneratedCounterCell ) ) $.
sorting-cache-53 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-56 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-59 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-62 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-63 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortStmt ) ) $.
sorting-cache-66 $a |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) ) ) \kore-sort-SortKItem ) ) $.
sorting-cache-67 $a |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) \kore-sort-SortKItem ) ) $.
${ pattern-subsumption-16 $p |- ( \imp \top ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-implies \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-top \kore-sort-SortGeneratedTopCell ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) \kore-symbol-dotk ) ) ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) \kore-symbol-dotk ) ) ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( IMP-sort-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern IMP-sort-13-is-pattern BASIC-K-sort-1-is-pattern IMP-symbol-185-is-pattern string-literal-1-is-pattern string-literal-14-is-pattern string-literal-10-is-pattern string-literal-17-is-pattern IMP-symbol-218-is-pattern IMP-symbol-204-is-pattern string-literal-11-is-pattern IMP-symbol-194-is-pattern IMP-sort-31-is-pattern in-sort-is-pattern IMP-symbol-354-is-pattern KSEQ-symbol-0-is-pattern string-literal-18-is-pattern IMP-symbol-164-is-pattern IMP-symbol-160-is-pattern string-literal-4-is-pattern IMP-sort-8-is-pattern IMP-symbol-192-is-pattern top-is-pattern IMP-symbol-241-is-pattern KSEQ-symbol-1-is-pattern string-literal-15-is-pattern IMP-sort-14-is-pattern string-literal-12-is-pattern string-literal-13-is-pattern string-literal-16-is-pattern kore-top-is-pattern and-is-pattern rule-imp-transitivity rule-and-intro-alt2-sugar IMP-symbol-131-is-pattern IMP-symbol-132-is-pattern BASIC-K-sort-0-is-pattern IMP-symbol-126-is-pattern IMP-symbol-128-is-pattern kore-and-is-pattern kore-is-sort-is-pattern IMP-sort-18-is-pattern IMP-symbol-129-is-pattern IMP-symbol-194-sorting IMP-sort-30-is-pattern IMP-sort-7-is-pattern IMP-sort-9-is-pattern IMP-sort-22-is-pattern KSEQ-symbol-0-sorting sorting-cache-0 IMP-sort-10-is-pattern kore-and-sorting sorting-cache-66 sorting-cache-67 sorting-cache-63 sorting-cache-2 sorting-cache-31 sorting-cache-35 sorting-cache-39 sorting-cache-42 IMP-symbol-204-sorting IMP-symbol-354-sorting IMP-symbol-241-sorting INJ-symbol-0-sorting sorting-cache-43 IMP-symbol-131-sorting sorting-cache-62 sorting-cache-56 sorting-cache-47 sorting-cache-59 sorting-cache-53 IMP-symbol-132-sorting IMP-symbol-126-sorting sorting-cache-50 IMP-symbol-129-sorting kore-valid-is-pattern kore-top-valid rule-weakening kore-weakening kore-implies-reflexivity-alt kore-imp-conj-simplify ) UDUDUDUNUDUNVCUDUNUDUDUDUNUDUNVCPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBVFVCPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBVFUFUFUDUNUDQUDUNUDQUOUDUDUNUDUNVCUDQUFUDUNUDQUDUNUDQVMVMUQUDUDUNUDUNVOUPVMUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVAVHQDHBVBVNQUOPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBVFUDQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVAVHQDHBVBVNQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURVIQAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVJQUOPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVAVHQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURVIQAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVJQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSUTQPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURVIQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCFQPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSUTQUOPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSUTQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCFQPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSUTQVPUFPFAKBDEDUIBCGCFQPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSUTQUOPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSUTQUFPFAKBDEDUIBCGCFQPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSUTQVQUFPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCFQUHUTQUOPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSUTQUFPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCFQUHUTQUFPVDFVDUOAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGPQUOPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCFQUFPVDFVDUOAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGPQUFPVDFVDVRVSUQUFAEAIBCAEAJBCUEVKQANBDEDHBCGRVEQUOAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRVEQUOAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGPQUFAEAIBCAEAJBCUEVKQANBDEDHBCGRVEQUOAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRVEQUFAEAIBCAEAJBCUEVKQANBDEDHBCGRVEQVTWAUQUFAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMPQAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRVEQUFAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMPQANBDEDUCBCGPQUOAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMPQUFAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMPQANBDEDUCBCGPQWBWCUQAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGWDUPAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMWEUPUQAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRWFUPUQPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGWGUPWHUQPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHVLUPUQPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSVLUPUQPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSVLUPPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSWIUPUFAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUJQAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVJQUFAFANBCDFDHBCLUJQAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOUJQUOAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUJQUFAFANBCDFDHBCLUJQAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOUJQWJUFAFAJBCDFDHBCLUJQAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOUJQUOAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOUJQUFAFAJBCDFDHBCLUJQAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOUJQWKUFAFATBCDFDHBCLUJQAFAKBCDFDHBCLAFAIBCDFDHBCLOUJQUOAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOUJQUFAFATBCDFDHBCLUJQAFAKBCDFDHBCLAFAIBCDFDHBCLOUJQWLUFAFAKBCDFDHBCLUJQAFAIBCDFDHBCLUJQUOAFAKBCDFDHBCLAFAIBCDFDHBCLOUJQUFAFAKBCDFDHBCLUJQAFAIBCDFDHBCLUJQWMWNUQAFAKBCDFDHBCLAFAIBCDFDHBCLVGUPUQAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOVGUPUQAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOVGUPUQAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOVGUPAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOWOUPUQPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSWPUPWQUQPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBWRUPUDUDUDUNUDUNVCUDUNUFUFUDUDUNWSUDWTXAXBUDUDUDUDUNUDUNVCPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBVFVCUFUFUDUDUNUDUNVCUDQPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBVFUDQUOUDUDUDUNUDUNVCPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBVFVCUDQUFUDUDUNUDUNVCUDQPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBVFUDQUFUDUNUDQUDUNUDQUOUDUDUNUDUNVCUDQUFUDUNUDQUDUNUDQVMVMUQUDUDUNUDUNVOUPUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVAVHQDHBVBVNQUOPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBVFUDQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVAVHQDHBVBVNQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURVIQAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVJQUOPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVAVHQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURVIQAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVJQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSUTQPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURVIQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCFQPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSUTQUOPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSUTQUFPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCFQPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSUTQVPUFPFAKBDEDUIBCGCFQPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSUTQUOPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSUTQUFPFAKBDEDUIBCGCFQPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSUTQVQUFPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCFQUHUTQUOPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSUTQUFPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCFQUHUTQUFPVDFVDUOAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGPQUOPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCFQUFPVDFVDUOAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGPQUFPVDFVDVRVSUQUFAEAIBCAEAJBCUEVKQANBDEDHBCGRVEQUOAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRVEQUOAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGPQUFAEAIBCAEAJBCUEVKQANBDEDHBCGRVEQUOAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRVEQUFAEAIBCAEAJBCUEVKQANBDEDHBCGRVEQVTWAUQUFAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMPQAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRVEQUFAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMPQANBDEDUCBCGPQUOAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMPQUFAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMPQANBDEDUCBCGPQWBWCUQAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGWDUPAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMWEUPUQAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRWFUPUQPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGWGUPWHUQPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHVLUPUQPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSVLUPUQPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSVLUPPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSWIUPUFAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUJQAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVJQUFAFANBCDFDHBCLUJQAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOUJQUOAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUJQUFAFANBCDFDHBCLUJQAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOUJQWJUFAFAJBCDFDHBCLUJQAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOUJQUOAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOUJQUFAFAJBCDFDHBCLUJQAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOUJQWKUFAFATBCDFDHBCLUJQAFAKBCDFDHBCLAFAIBCDFDHBCLOUJQUOAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOUJQUFAFATBCDFDHBCLUJQAFAKBCDFDHBCLAFAIBCDFDHBCLOUJQWLUFAFAKBCDFDHBCLUJQAFAIBCDFDHBCLUJQUOAFAKBCDFDHBCLAFAIBCDFDHBCLOUJQUFAFAKBCDFDHBCLUJQAFAIBCDFDHBCLUJQWMWNUQAFAKBCDFDHBCLAFAIBCDFDHBCLVGUPUQAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOVGUPUQAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOVGUPUQAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOVGUPAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOWOUPUQPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSWPUPWQUQPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBWRUPUQUDUDUDUNUDUNVCPFATBDEDUKBCGAIBDEDULBCGMAJBDEDUMBCGMCPFAKBDEDUIBCGCPFAEAIBCAEAJBCUEANBDEDHBCGRAJBAEAJBCAEAIBCUAGAKBAEAKBCAEAIBCUBGMANBDEDUCBCGMRUGCUHSSSURAFANBCDFDHBCLAFAJBCDFDHBCLAFATBCDFDHBCLAFAKBCDFDHBCLAFAIBCDFDHBCLOOOOUSVADHBVBVFVOUPXCXD $. $}
