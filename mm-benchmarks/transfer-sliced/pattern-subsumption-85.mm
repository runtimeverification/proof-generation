$c "1" #Substitution \kore-symbol-Lbl'-LT-'T'-GT-' "12345" \top \kore-sort-SortAExp \kore-symbol-kseq \kore-implies "90" \imp "0" ) \kore-and #SetVariable #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp1'Unds' \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' "ret" \kore-inj \kore-sort-SortInt "addressTo" \in-sort "balanceTo" ( \exists \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "amount" "balanceSender" \kore-symbol-Lbl'-LT-'state'-GT-' \kore-symbol-dotk \kore-sort-SortStmt #Variable "10" "200" \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid \kore-symbol-Lbl'-LT-'k'-GT-' \kore-equals \and \unit-sort \kore-symbol-Lbl'Hash'freezer'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp1'Unds' \kore-sort-SortGeneratedTopCell #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' \eq \kore-sort-SortKItem \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-top \kore-sort-SortMap $.
$v z xX0 sg0 th2 th0 ph6 kore-sort-var-x0 kore-element-var-x0 th1 ptn3 ptn2 ph8 ph3 ptn0 ph1 th3 kore-sort-var-R ph0 ph2 xX x ptn4 ptn1 y ph7 ph4 ph5 $.
$d y z $.
$d kore-sort-var-R kore-sort-var-x0 $.
$d z x $.
$d kore-element-var-x0 kore-sort-var-x0 $.
$d z kore-sort-var-x0 $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-sort-var-x0 $.
$d kore-element-var-x0 z $.
$d x kore-sort-var-x0 $.
$d kore-sort-var-R z $.
$d y kore-sort-var-R $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
ph7-is-pattern $f #Pattern ph7 $.
ph8-is-pattern $f #Pattern ph8 $.
th0-is-pattern $f #Pattern th0 $.
th1-is-pattern $f #Pattern th1 $.
th2-is-pattern $f #Pattern th2 $.
th3-is-pattern $f #Pattern th3 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
z-is-element-var $f #ElementVariable z $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
element-var-is-var $a #Variable x $.
symbol-is-pattern $a #Pattern sg0 $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
unit-sort-is-symbol $a #Symbol \unit-sort $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-implies-is-pattern $a #Pattern ( \kore-implies ph0 ph1 ph2 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
${ substitution-kore-and.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-and.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-and.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-and $a #Substitution ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph3 ph4 ph5 ) ph6 xX $. $}
${ substitution-kore-implies.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-implies.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-implies.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-implies $a #Substitution ( \kore-implies ph0 ph1 ph2 ) ( \kore-implies ph3 ph4 ph5 ) ph6 xX $. $}
${ substitution-kore-equals.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-equals.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-equals.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-equals.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-equals $a #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $. $}
unit-sort-is-functional $a |- ( \exists x ( \eq x \unit-sort ) ) $.
${ $d z ph0 $.
   $d z ph1 $.
   $d z ph2 $.
   $d z y $.
   $d z x $.
   $d z th1 $.
   $d z th2 $.
   $d x ph0 $.
   $d y th0 $.
   functional-substitution-alt.0 $e |- ( \imp th0 ( \exists x ( \eq x ph0 ) ) ) $.
   functional-substitution-alt.1 $e |- ( \imp ( \and th0 th1 ) ph1 ) $.
   functional-substitution-alt.2 $e #Substitution ( \imp th2 ph2 ) ( \imp th1 ph1 ) ph0 y $.
   functional-substitution-alt.3 $e #Substitution ( \imp th3 ph3 ) ( \imp th1 ph1 ) z y $.
   functional-substitution-alt $a |- ( \imp ( \and th0 th2 ) ph2 ) $. $}
${ kore-equals-elim-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-equals-elim-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
   kore-equals-elim-alt.2 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-equals ph0 \unit-sort ph1 ph2 ) ) ) $.
   kore-equals-elim-alt.3 $e |- ( \imp th0 ( \kore-valid ph6 ph3 ) ) $.
   kore-equals-elim-alt.4 $e #Substitution ( \kore-valid ph6 ph3 ) ph4 ph1 x $.
   kore-equals-elim-alt.5 $e #Substitution ( \kore-valid ph7 ph5 ) ph4 ph2 x $.
   kore-equals-elim-alt $a |- ( \imp th0 ( \kore-valid ph7 ph5 ) ) $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-80-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp1'Unds' ptn0 ) $.
IMP-symbol-91-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezer'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp1'Unds' ptn0 ) $.
IMP-symbol-126-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn0 ptn1 ) $.
${ IMP-symbol-126-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-126-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-126-substitution $a #Substitution ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn1 ptn2 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-128-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ptn0 ) $.
IMP-symbol-129-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn0 ptn1 ) $.
${ IMP-symbol-129-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-129-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-129-substitution $a #Substitution ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn1 ptn2 ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-131-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn0 ) $.
IMP-symbol-132-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) $.
${ IMP-symbol-132-substitution.0 $e #Substitution ptn1 ptn2 ptn0 xX0 $.
   IMP-symbol-132-substitution $a #Substitution ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn1 ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn2 ) ptn0 xX0 $. $}
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
IMP-symbol-194-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ptn1 \kore-sort-SortMap ) ) ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) \kore-sort-SortMap ) ) $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-4-is-pattern $a #Pattern "1" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
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
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
typecode-cache-Pattern-22 $a #Pattern ( \eq x \unit-sort ) $.
sorting-cache-129 $a |- ( \imp \top ( \and ( \kore-is-sort \unit-sort ) \top ) ) $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
sorting-cache-136 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
substitution-83 $a #Substitution ( \and ( \kore-is-sort \unit-sort ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \unit-sort kore-sort-var-R $.
substitution-87 $a #Substitution ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) kore-sort-var-x0 kore-sort-var-R $.
string-literal-19-is-pattern $a #Pattern "90" $.
sorting-cache-211 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) \kore-sort-SortMap ) ) $.
substitution-140 $a #Substitution \kore-sort-SortMap \kore-sort-SortMap \unit-sort kore-sort-var-R $.
substitution-144 $a #Substitution \kore-sort-SortMap \kore-sort-SortMap kore-sort-var-x0 kore-sort-var-R $.
sorting-rearrange-1501 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ) ) ) ) ) ) $.
equality-elim-49 $a |- ( \imp \top ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-implies \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-top \kore-sort-SortGeneratedTopCell ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-top \kore-sort-SortGeneratedTopCell ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $.
${ pattern-subsumption-85 $p |- ( \imp \top ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-implies \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-top \kore-sort-SortGeneratedTopCell ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-top \kore-sort-SortGeneratedTopCell ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( IMP-sort-23-is-pattern kore-dv-is-pattern kore-inj-is-pattern BASIC-K-sort-1-is-pattern IMP-sort-17-is-pattern IMP-symbol-218-is-pattern IMP-symbol-194-is-pattern KSEQ-symbol-0-is-pattern string-literal-17-is-pattern string-literal-15-is-pattern string-literal-11-is-pattern string-literal-1-is-pattern IMP-sort-8-is-pattern string-literal-13-is-pattern string-literal-18-is-pattern string-literal-12-is-pattern string-literal-10-is-pattern string-literal-19-is-pattern KSEQ-symbol-1-is-pattern string-literal-14-is-pattern kore-top-is-pattern IMP-sort-14-is-pattern kore-and-is-pattern top-is-pattern kore-sort-var-R-elementvariable kore-element-var-x0-elementvariable element-var-is-var in-sort-is-pattern IMP-symbol-80-is-pattern IMP-symbol-91-is-pattern IMP-sort-31-is-pattern IMP-sort-13-is-pattern string-literal-4-is-pattern IMP-symbol-185-is-pattern IMP-symbol-131-is-pattern IMP-symbol-132-is-pattern IMP-symbol-128-is-pattern IMP-symbol-126-is-pattern IMP-symbol-129-is-pattern and-is-pattern typecode-cache-Pattern-0 unit-sort-is-symbol symbol-is-pattern kore-sort-var-x0-elementvariable substitution-disjoint typecode-cache-Pattern-14 kore-is-sort-is-pattern typecode-cache-Pattern-25 kore-equals-is-pattern kore-valid-is-pattern rule-and-intro-alt2-sugar rule-imp-transitivity IMP-symbol-194-sorting kore-implies-is-pattern substitution-var-same x-is-element-var substitution-kore-valid rule-weakening sorting-cache-62 sorting-cache-211 sorting-cache-75 sorting-cache-85 sorting-cache-78 top-intro substitution-kore-equals substitution-imp IMP-symbol-132-substitution IMP-symbol-126-substitution IMP-symbol-129-substitution substitution-kore-and substitution-kore-implies sorting-cache-129 typecode-cache-Pattern-22 exists-is-pattern unit-sort-is-functional sorting-cache-136 sorting-rearrange-1501 substitution-83 substitution-140 substitution-87 substitution-144 functional-substitution-alt equality-elim-49 kore-equals-elim-alt ) UBEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUPURALBUQUSUCVNMMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPURALBUQUSUCVNVJMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUPURALBUQUSUCVNMMUDUFUDEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGUBUHEDETBCADANBCFUBUHUTEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUBUHUDEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGUBUHEDETBCADANBCFUBUHUDEDEKBCADALBCFUBUHEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGUBUHUTEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGUBUHUDEDEKBCADALBCFUBUHEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGUBUHVSUDEDEQBCADARBCFUBUHEDEOBCADAPBCFEDEIBCADAJBCFGUBUHUTEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGUBUHUDEDEQBCADARBCFUBUHEDEOBCADAPBCFEDEIBCADAJBCFGUBUHVTUDEDEOBCADAPBCFUBUHEDEIBCADAJBCFUBUHUTEDEOBCADAPBCFEDEIBCADAJBCFGUBUHUDEDEOBCADAPBCFUBUHEDEIBCADAJBCFUBUHWAWBVKEDEOBCADAPBCFEDEIBCADAJBCFVMVLVKEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGVMVLVKEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGVMVLWCVKEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFVMVLUDEDETBCADANBCFUBUHEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGUBUHUTEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUBUHUDEDETBCADANBCFUBUHEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGUBUHWCUDEDEKBCADALBCFUBUHEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGUBUHUTEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGUBUHUDEDEKBCADALBCFUBUHEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGUBUHVSUDEDEQBCADARBCFUBUHEDEOBCADAPBCFEDEIBCADAJBCFGUBUHUTEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGUBUHUDEDEQBCADARBCFUBUHEDEOBCADAPBCFEDEIBCADAJBCFGUBUHVTUDEDEOBCADAPBCFUBUHEDEIBCADAJBCFUBUHUTEDEOBCADAPBCFEDEIBCADAJBCFGUBUHUDEDEOBCADAPBCFUBUHEDEIBCADAJBCFUBUHWAWBVKEDEOBCADAPBCFEDEIBCADAJBCFVMVLVKEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGVMVLVKEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGVMVLVKEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGVMVLUDUDVBVCVGUDUTUTVBVCUBVBVCEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVJUDUDVBVCVGUDUTUDUDWDVRWLVKVBVCUEVAUBUEVAEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVJVBVCUBVBVCEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVJVDVFUBVDVFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVJUDUEVAVGUDUTVBVCVGUDUTVDVFVGUDUTVPUEVDUDVPWMVPWNVPWOVRUDUEVAVGUDUTUTUEVAVGUDUTUEVAUBUEVAEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVJUDUEVAVGUDUTUTUEVAVGUDUEWPUDUEVAVGUDUTUTUDWDVRVKUEWQVLVBVCVBVCVGUDUTVBVCUBVBVCEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVJUEVAVGUDUTUEVAUBUEVAEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVJUEUGUEWRVBVCUBVBVCEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIUEVAUBUEVAEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVBVCUEUGVBVCUEUGVOUBVBVCEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUBUEVAEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVBVCUEUGUEWSVBVCUEUGVOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGVBVCUEUGVEEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVBVCUEUGVEWEVQWFVDVFVDVFVGUDUTVDVFUBVDVFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVJUEVAVGUDUTUEVAUBUEVAEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVJUEUGUEVDWTVDVFUBVDVFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIUEVAUBUEVAEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVIVDVFUEUGVDVFUEUGVOUBVDVFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUBUEVAEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVDVFUEUGUEVDXAVDVFUEUGVOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGVDVFUEUGVEEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGVDVFUEUGVEWEVQWFXBVLXCMMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUPURALBUQUSUCVNMMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPURALBUQUSUCVNEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGMEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGVEMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUPURALBUQUSUCMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPURALBUQUSUCEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGMEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGVEMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGVEMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUPURALBUQUSMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPURALBUQUSEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGMEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGVEMMUAMUAUCEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGVEUFUGEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUPURALBUQADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPURALBUQUFUGEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUPADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGVEUFUGEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFVHEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGVOWGWHALBUQEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGEDETBCADANBCFGUFUGVEWIWJWKVQMMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUPURALBUQUSUCVNMMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPURALBUQUSUCVNEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGMEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGVEMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUPURALBUQUSUCMMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPURALBUQUSUCEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGMEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGVEMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFEDETBCADANBCFGGGGUPURALBUQUSUCEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGVEMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUPURALBUQUSMMMUAMUAUCADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPURALBUQUSEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGMEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGVEMMUAMUAUCEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGVEUFUGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUPURALBUQADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPURALBUQUFUGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUPADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOUFVHUPADANBCADAJBCSHUIEDEIBCSHUJUKDEKBAULAUMBCUNCSHHHHUOEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGVEUFUGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFVHEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGVOWGWHALBUQEDETBCADANBCFEDEKBCADALBCFEDEQBCADARBCFEDEOBCADAPBCFEDEIBCADAJBCFGGGGUFUGVEWIWJWKVQXD $. $}
