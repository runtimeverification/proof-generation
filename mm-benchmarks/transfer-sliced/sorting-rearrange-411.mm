$c #Substitution \kore-symbol-Lbl'-LT-'T'-GT-' \top \kore-symbol-kseq \imp \kore-sort-SortPgm "0" ) \kore-and #SetVariable \kore-top #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' \kore-inj \kore-sort-SortInt "addressTo" \in-sort "balanceTo" ( \exists \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' "amount" "balanceSender" \kore-symbol-Lbl'-LT-'state'-GT-' \kore-sort-SortStmt #Variable \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt \kore-sort-SortIds \kore-dv |- \kore-sort-SortId \kore-valid \kore-symbol-Lbl'-LT-'k'-GT-' \kore-equals \and \unit-sort \kore-symbol-Lbl'Stop'Map \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' \eq \kore-exists \kore-sort-SortKItem \kore-symbol-dotk \kore-sort-SortMap $.
$v kore-element-var-V0 xX0 z kore-element-var-VE1 th2 kore-element-var-VE3 th0 kore-element-var-VE2 ph6 kore-element-var-x0 th1 kore-element-var-VE4 ptn3 ptn2 ph3 ptn0 ph1 th3 ph0 ph2 xX x ptn4 ptn1 y ph4 ph5 $.
$d kore-element-var-V0 z $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d y z $.
$d kore-element-var-V0 x $.
$d y kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE4 kore-element-var-V0 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-V0 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-VE3 z $.
$d x kore-element-var-VE1 $.
$d kore-element-var-x0 kore-element-var-VE3 $.
$d z kore-element-var-VE2 $.
$d kore-element-var-VE4 z $.
$d y kore-element-var-VE4 $.
$d kore-element-var-V0 kore-element-var-VE2 $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d z kore-element-var-VE1 $.
$d y kore-element-var-VE1 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE4 x $.
$d kore-element-var-x0 kore-element-var-VE4 $.
$d kore-element-var-x0 z $.
$d kore-element-var-V0 kore-element-var-VE1 $.
$d kore-element-var-VE4 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-x0 kore-element-var-VE2 $.
$d kore-element-var-x0 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-V0 $.
$d kore-element-var-VE2 x $.
$d y kore-element-var-VE3 $.
$d y kore-element-var-V0 $.
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
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-27-is-pattern $a #Pattern \kore-sort-SortPgm $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
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
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
${ IMP-symbol-194-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-194-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-194-substitution $a #Substitution ( \kore-symbol-Lbl'Unds'Map'Unds' ptn1 ptn2 ) ( \kore-symbol-Lbl'Unds'Map'Unds' ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-194-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortMap ) ( \in-sort ptn1 \kore-sort-SortMap ) ) ( \in-sort ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) \kore-sort-SortMap ) ) $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
IMP-symbol-247-is-pattern $a #Pattern ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ptn0 ptn1 ) $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
sorting-cache-47 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-53 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-56 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-59 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-39 $a #Pattern kore-element-var-V0 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
substitution-445 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortMap ) \top ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) kore-element-var-x0 kore-element-var-VE1 $.
substitution-448 $a #Substitution \kore-sort-SortGeneratedTopCell \kore-sort-SortGeneratedTopCell kore-element-var-x0 kore-element-var-VE1 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-180 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) $.
typecode-cache-Pattern-181 $a #Pattern ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-VE2 kore-element-var-VE4 ) $.
typecode-cache-Pattern-182 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-VE2 kore-element-var-VE4 ) kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-VE1 \kore-symbol-Lbl'Stop'Map ) ) ) $.
typecode-cache-Pattern-183 $a #Pattern ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt kore-element-var-VE4 kore-element-var-VE3 ) $.
sorting-rearrange-298 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-VE2 kore-element-var-VE4 ) kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-VE1 \kore-symbol-Lbl'Stop'Map ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt kore-element-var-VE4 kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-VE1 ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE2 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $.
sorting-cache-627 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) $.
typecode-cache-Pattern-184 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-VE2 kore-element-var-VE4 ) kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-x0 \kore-symbol-Lbl'Stop'Map ) ) ) $.
substitution-536 $a #Substitution ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-x0 \kore-symbol-Lbl'Stop'Map ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' kore-element-var-VE1 \kore-symbol-Lbl'Stop'Map ) ) kore-element-var-x0 kore-element-var-VE1 $.
sorting-cache-629 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) $.
sorting-cache-708 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-727 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-cache-758 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
sorting-rearrange-410 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortMap \unit-sort kore-element-var-V0 ( \kore-equals \kore-sort-SortMap \unit-sort kore-element-var-V0 ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) ) ) ) $.
sorting-cache-783 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ( \in-sort ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-sort-SortMap ) ) $.
${ sorting-rearrange-411 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-VE2 kore-element-var-VE4 ) kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) \kore-symbol-Lbl'Stop'Map ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt kore-element-var-VE4 kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE2 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( IMP-sort-23-is-pattern BASIC-K-sort-1-is-pattern kore-inj-is-pattern kore-dv-is-pattern IMP-sort-17-is-pattern string-literal-1-is-pattern IMP-symbol-218-is-pattern IMP-symbol-194-is-pattern IMP-sort-8-is-pattern kore-element-var-VE1-elementvariable in-sort-is-pattern string-literal-17-is-pattern string-literal-14-is-pattern string-literal-18-is-pattern typecode-cache-Pattern-177 string-literal-10-is-pattern IMP-sort-14-is-pattern and-is-pattern IMP-symbol-128-is-pattern element-var-is-var kore-top-is-pattern IMP-sort-27-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern IMP-symbol-131-is-pattern kore-element-var-x0-elementvariable typecode-cache-Pattern-146 IMP-symbol-129-is-pattern IMP-symbol-132-is-pattern kore-and-is-pattern top-is-pattern IMP-symbol-126-is-pattern typecode-cache-Pattern-180 typecode-cache-Pattern-183 typecode-cache-Pattern-25 substitution-disjoint IMP-symbol-124-is-pattern typecode-cache-Pattern-181 typecode-cache-Pattern-178 IMP-symbol-247-is-pattern kore-rewrites-is-pattern rule-imp-transitivity typecode-cache-Pattern-182 rule-and-intro-alt2-sugar kore-valid-is-pattern IMP-symbol-194-sorting typecode-cache-Pattern-184 kore-element-var-V0-elementvariable and-elim-left-sugar substitution-var-same IMP-symbol-126-substitution IMP-symbol-129-substitution substitution-kore-and substitution-448 IMP-symbol-194-substitution IMP-symbol-132-substitution imp-reflexivity top-intro rule-weakening substitution-kore-rewrites substitution-kore-valid substitution-imp sorting-cache-629 sorting-cache-758 sorting-cache-708 sorting-cache-783 sorting-cache-727 typecode-cache-Pattern-39 eq-is-pattern exists-is-pattern sorting-cache-56 sorting-cache-47 sorting-cache-59 sorting-cache-53 sorting-rearrange-410 kore-functional and-elim-right-sugar sorting-cache-627 sorting-rearrange-298 substitution-in-sort substitution-and substitution-445 substitution-536 functional-substitution-alt ) ARHNBCUPUAARHNBCUPUAHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKTNUNUAUALLLLUDUEEACVABVBVCFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUTKULUODIGUBUKUMLLUDUEEBCUQFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEARFDEDIGFJKULUODIGUBUKUMVDVHARHNBCUPUAARHNBCUPUAHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKTNUNUAARHNBCUPUAARHNBCUPARHNBCUPUAARHNARHNARHNBCUPVLARHNVTVEABCWFVGARHNBCUPUAHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKTNUNARHNBCUPUAHEHSGFDEDIGFJTNHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKTNUAHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKTNARHNBCUPUAHEHSGFDEDIGFJTNHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKTNABCWGARHNBCUPUAHEHQGFDEDIGFJTNHEHOGFDEDIGFJHEHPGFDEDIGFJKTNUAHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKTNARHNBCUPUAHEHQGFDEDIGFJTNHEHOGFDEDIGFJHEHPGFDEDIGFJKTNABCWHARHNBCUPUAHEHOGFDEDIGFJTNHEHPGFDEDIGFJTNUAHEHOGFDEDIGFJHEHPGFDEDIGFJKTNARHNBCUPUAHEHOGFDEDIGFJTNHEHPGFDEDIGFJTNABCWIABCWJVGHEHOGFDEDIGFJHEHPGFDEDIGFJVIVEVGHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKVIVEVGHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKVIVEARHNBCUPUAUNWAWBVGVGHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKLLLLUDAMBCVFDIGUBUKUMLLUDUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBUKUMVDVHLLLLUDUEEACVABVBVCFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUTKULUODIGUBUKUMLLUDUEEBCUQFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEARFDEDIGFJKULUODIGUBUKUMVDVHLLLLUDABCUIVJDIGUBUKUMLLUDUEEBCUQFUFUGUHUIURHEARFDEDIGFJKULUODIGUBUKUMVDVHARHNBCUPUAMUJTNUNUAHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKTNUNUAUIURTNUNUAVKMUIARHNBCUPUAUNVKWKHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKWLVKWMARHNBCUPUAUNWAWBTHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUNVKUNHEHSGFDEDIGFJTNHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKTNUAHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKTNUNHEHSGFDEDIGFJTNHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKTNWNUNHEHQGFDEDIGFJTNHEHOGFDEDIGFJHEHPGFDEDIGFJKTNUAHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKTNUNHEHQGFDEDIGFJTNHEHOGFDEDIGFJHEHPGFDEDIGFJKTNWOUNHEHOGFDEDIGFJTNHEHPGFDEDIGFJTNUAHEHOGFDEDIGFJHEHPGFDEDIGFJKTNUNHEHOGFDEDIGFJTNHEHPGFDEDIGFJTNWPWQVGHEHOGFDEDIGFJHEHPGFDEDIGFJVIVEVGHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKVIVEVGHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKVIVEVKWRWSVEARHNBCUPUAMUJTNUNUAUAMUJTNARHNBCUPUAUALLLLUDAMBCVFDIGUBUKUMLLUDUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBUKUMVDVHARHNBCUPUAMUJTNUNUAUAMUJTNARHNBCUPUAARHNBCUPUAMUJTNUNUAUAMUJTNUNUAMUJTNARHNBCUPUAMUJTNUNUAWTMUJTNUNUAMUJTNMUJTNMUJTNUNVLMUJTNVTVEVEARHNBCUPUAMUJTNUNUAUAARHNBCUPARHNBCUPUAMUJTNUNUAUAARHNBCUPUAARHNARHNBCUPUAMUJTNUNUAVLARHNBCUPVLVEAMBCXAVGVGAMBCXBVEHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKTNUNUALLLLUDUEEACVABVBVCFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUTKULUODIGUBUKUMLLUDUEEBCUQFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEARFDEDIGFJKULUODIGUBUKUMVDVHMUJTNUNUALLLLUDAMBCVFDIGUBUKUMLLUDUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBUKUMVDVHMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKTNUNMUJTNUNMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKTMUJTMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCVMTHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSXCUNHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSXDLLLLUDUEEACVABVBVCFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUTKULUODIGUBUKUMLLUDUEEBCUQFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEARFDEDIGFJKULUODIGUBUKUMVDLLLLUDAMBCVFDIGUBUKUMLLUDUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBUKUMVDHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCLHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSLLLUDUEEACVABVBVCFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUTKULUODIGUBUKUMLLUDUEEBCUQFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEARFDEDIGFJKULUODIGUBUKUMLLLUDAMBCVFDIGUBUKUMLLUDUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBUKUMHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCLHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSLLUDUEEACVABVBVCFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUTKULUODIGUBUKLLUDAMBCVFDIGUBUKHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCLHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSLUDHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUEEACVABVBVCFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUTKULUODIGUBAMBCVFDIGUBMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUEEACVABVBVCFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUTKULUEEACVABVBVCFUFUGUHMUJUTKULUEEACVABVBVCFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUTKMUJUTKMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUTMUJUTHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCVMUTHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSVRVSVNDIGUBHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSVOVPLLUDUEEBCUQFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEARFDEDIGFJKULUODIGUBUKLLUDUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBUKHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCLHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSLUDHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUEEBCUQFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEARFDEDIGFJKULUODIGUBUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKUEEBCUQFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEARFDEDIGFJKULUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUEEBCUQFUFUGUHHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEARFDEDIGFJKMUJHEARFDEDIGFJKMUCHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKHEARFDEDIGFJMUJHEARFDEDIGFJHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCVMHEARFDEDIGFJHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSVRVSVNDIGUBHEHSGFDEDIGFJHEHQGFDEDIGFJHEHOGFDEDIGFJHEHPGFDEDIGFJKKKMUCUSVOVPWCWDWEUIURUIURTNUNUALLLLUDABCUIVJDIGUBUKUMLLUDUEEBCUQFUFUGUHUIURHEARFDEDIGFJKULUODIGUBUKUMVDVHMUJTNUNUALLLLUDAMBCVFDIGUBUKUMLLUDUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBUKUMVDVHMUCMUIXELLLLUDABCUIVJDIGUBUKUMLLUDUEEBCUQFUFUGUHUIURHEARFDEDIGFJKULUODIGUBUKUMVDLLLLUDAMBCVFDIGUBUKUMLLUDUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBUKUMVDUIURMUCMUIVQLLLUDABCUIVJDIGUBUKUMLLUDUEEBCUQFUFUGUHUIURHEARFDEDIGFJKULUODIGUBUKUMLLLUDAMBCVFDIGUBUKUMLLUDUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBUKUMUIURMUCMUIVQLLUDABCUIVJDIGUBUKLLUDAMBCVFDIGUBUKUIURMUCMUIVQLUDUIURMUCUSMUCUIURABCUIVJDIGUBAMBCVFDIGUBMUCUIURUEEACVABVBVCFUFUGUHUIURUTKULUEEACVABVBVCFUFUGUHMUJUTKULUEEACVABVBVCFUFUGUHUIURMUCUSMUIXFVNDIGUBUIURMUCUSVOVPLLUDUEEBCUQFUFUGUHUIURHEARFDEDIGFJKULUODIGUBUKLLUDUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBUKUIURMUCMUIVQLUDUIURMUCUSMUCUIURUEEBCUQFUFUGUHUIURHEARFDEDIGFJKULUODIGUBUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUODIGUBMUCUIURUEEBCUQFUFUGUHUIURHEARFDEDIGFJKULUEEBCUQFUFUGUHMUJHEARFDEDIGFJKULUEEBCUQFUFUGUHUIURMUCUSMUCUIURUIURHEARFDEDIGFJKMUJHEARFDEDIGFJKMUCUIURUIURHEARFDEDIGFJMUJHEARFDEDIGFJUIURMUCVMHEARFDEDIGFJUIURMUCUSVRVSVNDIGUBUIURMUCUSVOVPWCWDWEXGVE $. $}
