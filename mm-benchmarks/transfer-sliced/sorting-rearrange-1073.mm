$c #Substitution \kore-symbol-Lbl'-LT-'T'-GT-' "12345" \top \kore-sort-SortAExp \kore-symbol-LblisKResult \kore-symbol-kseq \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' \kore-sort-SortBool \imp "0" ) \kore-and #SetVariable \kore-top #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' "ret" "true" "100" \kore-inj \kore-sort-SortInt "addressTo" \in-sort "balanceTo" ( \exists \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' \kore-sort-SortBExp "balanceSender" "amount" \kore-symbol-Lbl'-LT-'state'-GT-' \kore-sort-SortStmt #Variable "10" "200" \kore-dv |- \kore-sort-SortId \kore-valid \kore-equals \kore-symbol-Lbl'-LT-'k'-GT-' \and \unit-sort \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' \eq \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block \kore-sort-SortBlock \kore-exists \kore-sort-SortKItem \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-symbol-Lbl'Unds'andBool'Unds' \kore-symbol-dotk \kore-sort-SortMap \kore-sort-SortStateCell $.
$v z xX0 th2 kore-element-var-VE3 th0 ph6 kore-element-var-VE6 kore-element-var-VE5 kore-element-var-VE4 kore-element-var-x0 ptn2 kore-element-var-Val ph3 ptn0 ptn3 th1 ph1 th3 ph0 ph2 xX x ptn4 ptn1 y ph4 ph5 $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE3 kore-element-var-Val $.
$d kore-element-var-VE6 kore-element-var-x0 $.
$d kore-element-var-VE6 kore-element-var-Val $.
$d kore-element-var-VE6 kore-element-var-VE3 $.
$d z x $.
$d kore-element-var-VE6 kore-element-var-VE5 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-VE3 z $.
$d kore-element-var-VE6 kore-element-var-VE4 $.
$d kore-element-var-x0 kore-element-var-VE3 $.
$d kore-element-var-Val x $.
$d kore-element-var-VE4 z $.
$d y kore-element-var-VE4 $.
$d kore-element-var-VE6 x $.
$d kore-element-var-x0 kore-element-var-VE5 $.
$d z kore-element-var-Val $.
$d y x $.
$d kore-element-var-VE4 kore-element-var-Val $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-VE4 x $.
$d y kore-element-var-Val $.
$d kore-element-var-VE5 y $.
$d kore-element-var-x0 kore-element-var-VE4 $.
$d kore-element-var-x0 z $.
$d kore-element-var-VE5 x $.
$d kore-element-var-VE6 y $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
$d kore-element-var-VE5 z $.
$d kore-element-var-VE6 z $.
$d kore-element-var-VE5 kore-element-var-Val $.
$d y kore-element-var-VE3 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
th0-is-pattern $f #Pattern th0 $.
th1-is-pattern $f #Pattern th1 $.
th2-is-pattern $f #Pattern th2 $.
th3-is-pattern $f #Pattern th3 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
z-is-element-var $f #ElementVariable z $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
${ substitution-and.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-and.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-and $a #Substitution ( \and ph1 ph2 ) ( \and ph3 ph4 ) ph0 xX $. $}
${ substitution-in-sort.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-in-sort.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-in-sort $a #Substitution ( \in-sort ph1 ph2 ) ( \in-sort ph3 ph4 ) ph0 xX $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-rewrites-is-pattern $a #Pattern ( \kore-rewrites ph0 ph1 ph2 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
${ substitution-kore-and.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-and.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-and.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-and $a #Substitution ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph3 ph4 ph5 ) ph6 xX $. $}
${ substitution-kore-rewrites.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-rewrites.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-rewrites.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-rewrites $a #Substitution ( \kore-rewrites ph0 ph1 ph2 ) ( \kore-rewrites ph3 ph4 ph5 ) ph6 xX $. $}
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
${ $d x ph0 $.
   $d x ph1 $.
   kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
   kore-functional $a |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-96-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ptn0 ptn1 ) $.
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
IMP-symbol-132-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) \kore-sort-SortStateCell ) ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
IMP-symbol-194-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ptn1 \kore-sort-SortMap ) ) ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) \kore-sort-SortMap ) ) $.
IMP-symbol-205-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'andBool'Unds' ptn0 ptn1 ) $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
IMP-symbol-241-is-pattern $a #Pattern ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) $.
IMP-symbol-271-is-pattern $a #Pattern ( \kore-symbol-LblisKResult ptn0 ) $.
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
string-literal-0-is-pattern $a #Pattern "true" $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
kore-element-var-VE6-elementvariable $f #ElementVariable kore-element-var-VE6 $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-15-is-pattern $a #Pattern "200" $.
string-literal-16-is-pattern $a #Pattern "100" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
sorting-cache-93 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "100" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) \kore-sort-SortStateCell ) ) $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
substitution-563 $a #Substitution \kore-sort-SortGeneratedTopCell \kore-sort-SortGeneratedTopCell kore-element-var-x0 kore-element-var-VE3 $.
substitution-711 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortStateCell ) \top ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) kore-element-var-x0 kore-element-var-VE3 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
sorting-rearrange-739 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortStateCell \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortStateCell \unit-sort kore-element-var-Val ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "100" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) ) ) ) ) $.
typecode-cache-Pattern-356 $a #Pattern kore-element-var-VE6 $.
typecode-cache-Pattern-357 $a #Pattern ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) $.
typecode-cache-Pattern-365 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block kore-element-var-VE4 ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) kore-element-var-VE6 ) ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) $.
sorting-rearrange-1072 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-equals \kore-sort-SortBool \kore-sort-SortGeneratedTopCell ( \kore-symbol-Lbl'Unds'andBool'Unds' ( \kore-dv \kore-sort-SortBool "true" ) ( \kore-symbol-LblisKResult ( \kore-symbol-kseq kore-element-var-VE5 \kore-symbol-dotk ) ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-and \kore-sort-SortKItem ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE5 ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE6 ) \kore-symbol-dotk ) ) \kore-symbol-dotk ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block kore-element-var-VE4 ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) kore-element-var-VE6 ) ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $.
sorting-cache-1745 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) $.
typecode-cache-Pattern-367 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block kore-element-var-VE4 ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) kore-element-var-VE6 ) ) \kore-symbol-dotk ) ) kore-element-var-x0 ) $.
sorting-cache-1747 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) $.
sorting-cache-1752 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-1755 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "100" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-1765 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) \kore-sort-SortMap ) ) $.
${ sorting-rearrange-1073 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE6 \kore-sort-SortBlock ) \top ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-equals \kore-sort-SortBool \kore-sort-SortGeneratedTopCell ( \kore-symbol-Lbl'Unds'andBool'Unds' ( \kore-dv \kore-sort-SortBool "true" ) ( \kore-symbol-LblisKResult ( \kore-symbol-kseq kore-element-var-VE5 \kore-symbol-dotk ) ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-and \kore-sort-SortKItem ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE5 ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE6 ) \kore-symbol-dotk ) ) \kore-symbol-dotk ) ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "100" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block kore-element-var-VE4 ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) kore-element-var-VE6 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "ret" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "100" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( kore-dv-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern BASIC-K-sort-1-is-pattern IMP-sort-17-is-pattern IMP-symbol-218-is-pattern IMP-symbol-194-is-pattern KSEQ-symbol-0-is-pattern string-literal-1-is-pattern KSEQ-symbol-1-is-pattern IMP-sort-8-is-pattern string-literal-11-is-pattern kore-element-var-VE3-elementvariable typecode-cache-Pattern-179 in-sort-is-pattern IMP-sort-32-is-pattern IMP-sort-22-is-pattern kore-and-is-pattern string-literal-10-is-pattern string-literal-16-is-pattern string-literal-18-is-pattern string-literal-12-is-pattern string-literal-17-is-pattern string-literal-15-is-pattern string-literal-14-is-pattern string-literal-13-is-pattern IMP-sort-18-is-pattern typecode-cache-Pattern-253 IMP-symbol-128-is-pattern and-is-pattern IMP-symbol-132-is-pattern string-literal-0-is-pattern IMP-sort-13-is-pattern IMP-symbol-185-is-pattern IMP-symbol-354-is-pattern typecode-cache-Pattern-356 IMP-symbol-131-is-pattern element-var-is-var IMP-symbol-129-is-pattern kore-element-var-x0-elementvariable typecode-cache-Pattern-178 IMP-sort-9-is-pattern IMP-symbol-126-is-pattern IMP-symbol-96-is-pattern typecode-cache-Pattern-357 top-is-pattern typecode-cache-Pattern-25 IMP-symbol-271-is-pattern IMP-symbol-205-is-pattern kore-equals-is-pattern kore-top-is-pattern substitution-disjoint IMP-sort-31-is-pattern IMP-symbol-241-is-pattern kore-rewrites-is-pattern typecode-cache-Pattern-365 IMP-sort-14-is-pattern rule-imp-transitivity kore-valid-is-pattern rule-and-intro-alt2-sugar typecode-cache-Pattern-367 kore-element-var-Val-elementvariable substitution-var-same and-elim-left-sugar IMP-symbol-126-substitution IMP-symbol-129-substitution substitution-kore-and substitution-563 imp-reflexivity IMP-symbol-194-sorting top-intro rule-weakening substitution-kore-rewrites substitution-kore-valid substitution-imp sorting-cache-1747 sorting-cache-1752 sorting-cache-1755 sorting-cache-1765 IMP-symbol-132-sorting typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern sorting-cache-93 sorting-rearrange-739 kore-functional and-elim-right-sugar sorting-cache-1745 sorting-rearrange-1072 substitution-in-sort substitution-and substitution-711 functional-substitution-alt ) AQTRBCVHUMAQTRBCVHUMHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVERVIUMUMNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBUANNVNVPGAQHODFUPFLDEUQURCUSVQEMKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBUAVRWBAQTRBCVHUMAQTRBCVHUMHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVERVIUMAQTRBCVHUMAQTRBCVHAQTRBCVHUMAQTRAQTRAQTRBCVHWGAQTRWLWAABCWSWCAQTRBCVHUMHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVERVIAQTRBCVHUMHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJVTRHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVERAQTRBCVHUMHGHODEFGFLDEIVTRHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJVTRUMHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJVTRAQTRBCVHUMHGHODEFGFLDEIVTRHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJVTRABCWTAQTRBCVHUMHGHUBDEFGFUCDEIVTRHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJVTRUMHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJVTRAQTRBCVHUMHGHUBDEFGFUCDEIVTRHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJVTRABCXAABCXBWCHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJWMWAWCHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJWMWAHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJXCWAAQTRBCVHUMVIWNWOWCWCHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULVBUANNVNPACVSFLDULVBUAVRWBNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBUANNVNVPGAQHODFUPFLDEUQURCUSVQEMKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBUAVRWBNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTVCVJVFFLDULVBUANNVNACVCWDFLDULVBUAVRWBAQTRBCVHUMPVDVERVIUMHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVERVIUMVCVJVERVIUMWEPVCAQTRBCVHUMVIWEXDHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNXEWEXFAQTRBCVHUMVIWNWOVEHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVIWEXGWEXHXIWAAQTRBCVHUMPVDVERVIUMUMPVDVERAQTRBCVHUMUMNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULVBUANNVNPACVSFLDULVBUAVRWBAQTRBCVHUMPVDVERVIUMUMPVDVERAQTRBCVHUMAQTRBCVHUMPVDVERVIUMUMPVDVERVIUMPVDVERAQTRBCVHUMPVDVERVIUMXJPVDVERVIUMPVDVERPVDVERPVDVERVIWGPVDVERWLWAWAAQTRBCVHUMPVDVERVIUMUMAQTRBCVHAQTRBCVHUMPVDVERVIUMUMAQTRBCVHUMAQTRAQTRBCVHUMPVDVERVIUMWGAQTRBCVHWGWAPABCXKWCWCPABCXLWAHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVERVIUMNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBUANNVNVPGAQHODFUPFLDEUQURCUSVQEMKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBUAVRWBPVDVERVIUMNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULVBUANNVNPACVSFLDULVBUAVRWBPVAHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVERVIPVDVERVIPVAHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVEPVDVEPVAHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAWFVEHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVOXMVIHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVOXNNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBUANNVNVPGAQHODFUPFLDEUQURCUSVQEMKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBUAVRNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULVBUANNVNPACVSFLDULVBUAVRHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVANHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVONNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBUANNVNVPGAQHODFUPFLDEUQURCUSVQEMKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBUANNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULVBUANNVNPACVSFLDULVBUAHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVANHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVONSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULVBHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVANHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVOSNSUODBUKMKVKVLSUODVMHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVOPVAHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULPVAHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVOHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAWFWHFLDULHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVOWIWJNNVNVPGAQHODFUPFLDEUQURCUSVQEMKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULVBNNVNPACVSFLDULVBHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVANHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVONVNHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVOPVAHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVPGAQHODFUPFLDEUQURCUSVQEMKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVFFLDULPACVSFLDULPVAHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVPGAQHODFUPFLDEUQURCUSVQEMKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNVPGAQHODFUPFLDEUQURCUSVQEMKUTPVDVPGAQHODFUPFLDEUQURCUSVQEMKUTHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVOHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAWFWHFLDULHGHODEFGFLDEIHGHUBDEFGFUCDEIHGHUDDEFGFUEDEIHGHUFDEFGFUGDEIHGHUHDEFGFUIDEIJJJJUNPVAVOWIWJWPWQWRVCVJVCVJVERVIUMNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTVCVJVFFLDULVBUANNVNACVCWDFLDULVBUAVRWBPVDVERVIUMNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULVBUANNVNPACVSFLDULVBUAVRWBPVAPVCXONNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTVCVJVFFLDULVBUANNVNACVCWDFLDULVBUAVRNNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULVBUANNVNPACVSFLDULVBUAVRVCVJPVAPVCWKNNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTVCVJVFFLDULVBUANNVNACVCWDFLDULVBUANNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULVBUANNVNPACVSFLDULVBUAVCVJPVAPVCWKNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTVCVJVFFLDULVBNSNSUODBUKMKVKVLSUODVMGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULVBVCVJPVAPVCWKSNSUODBUKMKVKVLSUODVMVCVJPVAVOPVAVCVJGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTVCVJVFFLDULGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDVFFLDULPVAVCVJGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTVCVJGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTPVDGTGAQEBUKUAUJGHODFUPFLDEUQUREMKUJGCUSEMKVGMKKUTVCVJPVAVOVCVJPVAWFWHFLDULVCVJPVAVOWIWJNNVNACVCWDFLDULVBNNVNPACVSFLDULVBVCVJPVAPVCWKNVNVCVJPVAVOPVAVCVJACVCWDFLDULPACVSFLDULPVAVCVJVPGAQHODFUPFLDEUQURCUSVQEMKUTVCVJVPGAQHODFUPFLDEUQURCUSVQEMKUTPVDVPGAQHODFUPFLDEUQURCUSVQEMKUTVCVJPVAVOVCVJPVAWFWHFLDULVCVJPVAVOWIWJWPWQWRXPWA $. $}
