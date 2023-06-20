$c #Substitution \kore-symbol-Lbl'-LT-'T'-GT-' \top \kore-symbol-kseq \imp \kore-sort-SortPgm "0" ) \kore-and #SetVariable \kore-top #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' \kore-inj \kore-sort-SortInt "addressTo" \in-sort ( \exists "amount" \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' \kore-symbol-Lbl'-LT-'state'-GT-' \kore-sort-SortStmt #Variable \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt \kore-sort-SortIds \kore-dv |- \kore-sort-SortId \kore-valid \kore-symbol-Lbl'-LT-'k'-GT-' \and \kore-symbol-Lbl'Stop'Map \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' \eq \kore-sort-SortKItem \kore-symbol-dotk $.
$v z xX0 th2 kore-element-var-VE3 th0 kore-element-var-VE2 ph6 kore-element-var-x0 th1 kore-element-var-VE4 ptn3 ptn2 kore-element-var-x1 ph3 ptn0 ph1 th3 ph0 ph2 xX x ptn4 ptn1 y ph4 ph5 $.
$d y z $.
$d y kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-x1 x $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d y kore-element-var-x1 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-x1 $.
$d kore-element-var-x1 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-x1 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-VE3 z $.
$d kore-element-var-x0 kore-element-var-VE3 $.
$d z kore-element-var-VE2 $.
$d kore-element-var-VE4 z $.
$d y kore-element-var-VE4 $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d z kore-element-var-x1 $.
$d kore-element-var-VE4 x $.
$d kore-element-var-x0 kore-element-var-VE4 $.
$d kore-element-var-x0 z $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-x0 kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-x1 $.
$d kore-element-var-VE2 x $.
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
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
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
kore-dv-sorting $a |- ( \in-sort ( \kore-dv ph0 ph1 ) ph0 ) $.
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
${ substitution-kore-inj.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-inj.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-inj.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-inj $a #Substitution ( \kore-inj ph0 ph1 ph2 ) ( \kore-inj ph3 ph4 ph5 ) ph6 xX $. $}
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
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
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
${ IMP-symbol-131-substitution.0 $e #Substitution ptn1 ptn2 ptn0 xX0 $.
   IMP-symbol-131-substitution $a #Substitution ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn1 ) ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn2 ) ptn0 xX0 $. $}
IMP-symbol-132-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) $.
${ IMP-symbol-132-substitution.0 $e #Substitution ptn1 ptn2 ptn0 xX0 $.
   IMP-symbol-132-substitution $a #Substitution ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn1 ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn2 ) ptn0 xX0 $. $}
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
${ IMP-symbol-194-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-194-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-194-substitution $a #Substitution ( \kore-symbol-Lbl'Unds'Map'Unds' ptn1 ptn2 ) ( \kore-symbol-Lbl'Unds'Map'Unds' ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
${ IMP-symbol-218-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-218-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-218-substitution $a #Substitution ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn1 ptn2 ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-247-is-pattern $a #Pattern ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ptn0 ptn1 ) $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-180 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) $.
typecode-cache-Pattern-181 $a #Pattern ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-VE2 kore-element-var-VE4 ) $.
typecode-cache-Pattern-183 $a #Pattern ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt kore-element-var-VE4 kore-element-var-VE3 ) $.
sorting-cache-630 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) $.
typecode-cache-Pattern-186 $a #Pattern ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-x0 kore-element-var-VE4 ) $.
substitution-545 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortId ) \top ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) \top ) kore-element-var-x0 kore-element-var-VE2 $.
substitution-546 $a #Substitution \kore-sort-SortGeneratedTopCell \kore-sort-SortGeneratedTopCell kore-element-var-x0 kore-element-var-VE2 $.
substitution-556 $a #Substitution ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-x0 kore-element-var-VE4 ) kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-VE2 kore-element-var-VE4 ) kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) kore-element-var-x0 kore-element-var-VE2 $.
substitution-558 $a #Substitution ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-x0 ) ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE2 ) kore-element-var-x0 kore-element-var-VE2 $.
sorting-cache-631 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) $.
sorting-rearrange-332 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-VE2 kore-element-var-VE4 ) kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-symbol-Lbl'Stop'Map ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt kore-element-var-VE4 kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE2 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $.
sorting-rearrange-333 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ( \exists kore-element-var-x1 ( \eq kore-element-var-x1 ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) $.
typecode-cache-Pattern-203 $a #Pattern ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "amount" ) kore-element-var-VE4 ) kore-element-var-VE3 ) $.
substitution-633 $a #Substitution ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "amount" ) kore-element-var-VE4 ) kore-element-var-VE3 ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids kore-element-var-VE2 kore-element-var-VE4 ) kore-element-var-VE3 ) ) \kore-symbol-dotk ) ( \kore-dv \kore-sort-SortId "amount" ) kore-element-var-VE2 $.
${ sorting-rearrange-334 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortIds ) \top ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "amount" ) kore-element-var-VE4 ) kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) \kore-symbol-Lbl'Stop'Map ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt kore-element-var-VE4 kore-element-var-VE3 ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "addressTo" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( kore-dv-is-pattern BASIC-K-sort-1-is-pattern kore-inj-is-pattern IMP-sort-23-is-pattern IMP-sort-17-is-pattern string-literal-1-is-pattern IMP-sort-8-is-pattern kore-element-var-VE2-elementvariable IMP-symbol-218-is-pattern string-literal-18-is-pattern IMP-symbol-194-is-pattern IMP-sort-27-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern IMP-symbol-131-is-pattern IMP-symbol-132-is-pattern string-literal-14-is-pattern IMP-symbol-128-is-pattern element-var-is-var IMP-symbol-126-is-pattern kore-element-var-x0-elementvariable kore-top-is-pattern IMP-symbol-129-is-pattern typecode-cache-Pattern-177 kore-and-is-pattern typecode-cache-Pattern-25 IMP-symbol-124-is-pattern typecode-cache-Pattern-183 in-sort-is-pattern substitution-disjoint typecode-cache-Pattern-178 IMP-symbol-247-is-pattern top-is-pattern and-is-pattern typecode-cache-Pattern-180 typecode-cache-Pattern-181 kore-rewrites-is-pattern typecode-cache-Pattern-203 kore-valid-is-pattern typecode-cache-Pattern-186 rule-imp-transitivity IMP-symbol-126-substitution IMP-symbol-129-substitution substitution-kore-and substitution-546 rule-and-intro-alt2-sugar kore-element-var-x1-elementvariable substitution-var-same IMP-symbol-218-substitution IMP-symbol-194-substitution IMP-symbol-132-substitution substitution-kore-rewrites substitution-kore-valid substitution-imp sorting-cache-631 imp-is-pattern proof-rule-prop-1 kore-dv-sorting proof-rule-mp top-intro rule-weakening sorting-rearrange-333 and-elim-right-sugar and-elim-left-sugar imp-reflexivity sorting-cache-630 sorting-rearrange-332 substitution-in-sort substitution-and substitution-633 IMP-symbol-131-substitution substitution-kore-inj substitution-545 substitution-556 substitution-558 functional-substitution-alt ) ABUQABUQGSCGUKUOUPUPIIIIUDNDABUTEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDGSCEFDFHCEKMRUBFHCTUEUGUSVAABUQABUQGSCGUKUOUPABVQABUQGSCGUKUOGSCGUKABUQGSCGUKVRGSCGUKABUQVSGSVTWAABUQUOWBWCVHVHGSCIIIIUDNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTUEUGUSVAIIIIUDNDABUTEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDGSCEFDFHCEKMRUBFHCTUEUGUSVAIIIIUDNDBUCVBAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDUCUHEFDFHCEKMRUBFHCTUEUGUSVAABUQJUFGUKUOUPGSCGUKUOUPUCUHGUKUOUPVIJUCABVIWDABUQJUFGUKUOUPUPJUFGUKABUQUPIIIIUDNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTUEUGUSVAABUQJUFGUKUOUPUPJUFGUKABUQABUQJUFGUKUOUPUPJUFGUKUOUPJUFGUKABUQJUFGUKUOUPWEJUFGUKUOUPJUFGUKJUFGUKJUFGUKUOWFJUFGUKWGVCVCJABWHVHJABWIVCGSCGSCGUKUOUPIIIIUDNDABUTEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDGSCEFDFHCEKMRUBFHCTUEUGUSVAJUFGUKUOUPIIIIUDNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTUEUGUSVAJUAGSCGSCGUKUOJUFGUKUOJUAGSCGSCGJUFGJUAGSCJUAVJGGSCJUAULWJUOGSCJUAULWKIIIIUDNDABUTEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDGSCEFDFHCEKMRUBFHCTUEUGUSIIIIUDNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTUEUGUSGSCJUAIGSCJUAULIIIUDNDABUTEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDGSCEFDFHCEKMRUBFHCTUEUGIIIUDNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTUEUGGSCJUAIGSCJUAULIIUDNDABUTEOPQGDGLCEFDFHCEKUIMRUBFHCTUEIIUDNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEGSCJUAIGSCJUAULIUDGSCJUAULJUAGSCNDABUTEOPQGDGLCEFDFHCEKUIMRUBFHCTNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTJUAGSCNDABUTEOPQGDGLCEFDFHCEKUIMRNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRJUAGSCNDABUTEOPNDJBURAUMUNEOPJABWLWMGDGLCEFDFHCEKUIMRGSCJUAULVDFHCTGSCJUAULVEVFIIUDNDABUJEOPQGDGLCEFDFHCEKGDGSCEFDFHCEKMRUBFHCTUEIIUDNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTUEGSCJUAIGSCJUAULIUDGSCJUAULJUAGSCNDABUJEOPQGDGLCEFDFHCEKGDGSCEFDFHCEKMRUBFHCTNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTJUAGSCNDABUJEOPQGDGLCEFDFHCEKGDGSCEFDFHCEKMRNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRNDABUJEOPQGSCJUAULJUAGSCGDGLCEFDFHCEKGDGSCEFDFHCEKMGDGLCEFDFHCEKGDJUFEFDFHCEKMJUAGSCGDGLCEFDFHCEKGDGSCEFDFHCEKGDGLCEFDFHCEKGDJUFEFDFHCEKGDGLCEFDFHCEKGSCJUAULJUAGSCGDGSCEFDFHCEGDJUFEFDFHCEGDGSCGDJUFGSCJUAGGSCJUAULDGSCJUAULGSCJUAVJWNFDFHCEGSCJUAULVKVLVMVDFHCTGSCJUAULVEVFVNVOVPUCUHUCUHGUKUOUPIIIIUDNDBUCVBAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDUCUHEFDFHCEKMRUBFHCTUEUGUSVAJUFGUKUOUPIIIIUDNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTUEUGUSVAJUAJUCWOIIIIUDNDBUCVBAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDUCUHEFDFHCEKMRUBFHCTUEUGUSIIIIUDNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTUEUGUSUCUHJUAJUCVGIIIUDNDBUCVBAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDUCUHEFDFHCEKMRUBFHCTUEUGIIIUDNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUGIIUDNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTUEUGUCUHJUAJUCVGIIUDNDBUCVBAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEIIUDNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTUEUCUHJUAJUCVGIUDUCUHJUAULJUAUCUHNDBUCVBAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRUBFHCTJUAUCUHNDBUCVBAUMUNEOPQGDGLCEFDFHCEKUIMRNDJBURAUMUNEOPQGDGLCEFDFHCEKUIMRJABUCWPGDGLCEFDFHCEKUIMRUCUHJUAULVDFHCTUCUHJUAULVEVFIIUDNDABUJEOPQGDGLCEFDFHCEKGDUCUHEFDFHCEKMRUBFHCTUEIIUDNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTUEUCUHJUAJUCVGIUDUCUHJUAULJUAUCUHNDABUJEOPQGDGLCEFDFHCEKGDUCUHEFDFHCEKMRUBFHCTNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRUBFHCTJUAUCUHNDABUJEOPQGDGLCEFDFHCEKGDUCUHEFDFHCEKMRNDABUJEOPQGDGLCEFDFHCEKGDJUFEFDFHCEKMRNDABUJEOPQUCUHJUAULJUAUCUHGDGLCEFDFHCEKGDUCUHEFDFHCEKMGDGLCEFDFHCEKGDJUFEFDFHCEKMJUAUCUHGDGLCEFDFHCEKGDUCUHEFDFHCEKGDGLCEFDFHCEKGDJUFEFDFHCEKGDGLCEFDFHCEKUCUHJUAULJUAUCUHGDUCUHEFDFHCEGDJUFEFDFHCEJUCWQFDFHCEUCUHJUAULVKVLVMVDFHCTUCUHJUAULVEVFVNVOVPWRVC $. $}
