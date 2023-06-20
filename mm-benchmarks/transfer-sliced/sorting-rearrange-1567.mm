$c "1" #Substitution \kore-symbol-Lbl'-LT-'T'-GT-' \top \kore-sort-SortAExp "210" \kore-symbol-kseq \imp "0" ) \kore-and #SetVariable \kore-top #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' "ret" \kore-inj \kore-sort-SortInt \in-sort ( \exists \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' \kore-symbol-Lbl'-LT-'state'-GT-' \kore-sort-SortStmt #Variable \kore-dv |- \kore-sort-SortId \kore-valid \kore-symbol-Lbl'-LT-'k'-GT-' \and \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' \eq \kore-sort-SortKItem \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-symbol-dotk \kore-sort-SortMap $.
$v z xX0 th2 kore-element-var-VE3 th0 kore-element-var-VE2 ph6 kore-element-var-x0 kore-element-var-VE5 kore-element-var-VE4 ptn3 ptn2 kore-element-var-x1 ph3 ptn0 th1 ph1 th3 ph0 ph2 xX x ptn4 ptn1 y ph4 ph5 $.
$d y z $.
$d y kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-x1 x $.
$d kore-element-var-VE5 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d y kore-element-var-x1 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-x1 $.
$d kore-element-var-x1 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-x1 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-VE5 kore-element-var-x1 $.
$d kore-element-var-VE3 z $.
$d kore-element-var-x0 kore-element-var-VE3 $.
$d z kore-element-var-VE2 $.
$d kore-element-var-VE4 z $.
$d y kore-element-var-VE4 $.
$d kore-element-var-x0 kore-element-var-VE5 $.
$d y x $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d z kore-element-var-x1 $.
$d kore-element-var-VE4 x $.
$d kore-element-var-VE5 y $.
$d kore-element-var-x0 kore-element-var-VE4 $.
$d kore-element-var-x0 z $.
$d kore-element-var-VE5 x $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-x0 kore-element-var-VE2 $.
$d kore-element-var-VE5 z $.
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
${ KSEQ-symbol-0-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   KSEQ-symbol-0-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   KSEQ-symbol-0-substitution $a #Substitution ( \kore-symbol-kseq ptn1 ptn2 ) ( \kore-symbol-kseq ptn3 ptn4 ) ptn0 xX0 $. $}
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
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
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
IMP-symbol-218-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ptn0 ptn1 ) $.
kore-element-var-x1-elementvariable $f #ElementVariable kore-element-var-x1 $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
string-literal-4-is-pattern $a #Pattern "1" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-11-is-pattern $a #Pattern "ret" $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
string-literal-20-is-pattern $a #Pattern "210" $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
substitution-546 $a #Substitution \kore-sort-SortGeneratedTopCell \kore-sort-SortGeneratedTopCell kore-element-var-x0 kore-element-var-VE2 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
typecode-cache-Pattern-254 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) $.
typecode-cache-Pattern-255 $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp kore-element-var-VE3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-VE2 ) ) $.
typecode-cache-Pattern-256 $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) kore-element-var-VE4 ) $.
typecode-cache-Pattern-257 $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-VE2 ) ) kore-element-var-VE5 ) $.
sorting-cache-1016 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortInt ) \top ) ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-260 $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp kore-element-var-VE3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-x0 ) ) $.
typecode-cache-Pattern-261 $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-x0 ) ) kore-element-var-VE5 ) $.
substitution-743 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortInt ) \top ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortInt ) \top ) kore-element-var-x0 kore-element-var-VE2 $.
substitution-747 $a #Substitution ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp kore-element-var-VE3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-x0 ) ) ) ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp kore-element-var-VE3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-VE2 ) ) ) kore-element-var-x0 kore-element-var-VE2 $.
substitution-750 $a #Substitution ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-x0 ) ) kore-element-var-VE5 ) ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-VE2 ) ) kore-element-var-VE5 ) kore-element-var-x0 kore-element-var-VE2 $.
sorting-cache-1018 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) $.
sorting-rearrange-1565 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortInt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp kore-element-var-VE3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-VE2 ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) kore-element-var-VE4 ) kore-element-var-VE5 ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-VE2 ) ) kore-element-var-VE5 ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $.
sorting-rearrange-1566 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ( \exists kore-element-var-x1 ( \eq kore-element-var-x1 ( \kore-dv \kore-sort-SortInt "210" ) ) ) ) $.
substitution-1280 $a #Substitution ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp kore-element-var-VE3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "210" ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp kore-element-var-VE3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-VE2 ) ) ( \kore-dv \kore-sort-SortInt "210" ) kore-element-var-VE2 $.
substitution-1282 $a #Substitution ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) ) kore-element-var-VE5 ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem kore-element-var-VE2 ) ) kore-element-var-VE5 ) ) ( \kore-dv \kore-sort-SortInt "210" ) kore-element-var-VE2 $.
${ sorting-rearrange-1567 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp kore-element-var-VE3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "210" ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) kore-element-var-VE4 ) kore-element-var-VE5 ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE3 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) ) kore-element-var-VE5 ) ) ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( IMP-sort-23-is-pattern kore-dv-is-pattern kore-inj-is-pattern BASIC-K-sort-1-is-pattern IMP-sort-8-is-pattern kore-element-var-VE2-elementvariable IMP-sort-31-is-pattern IMP-sort-17-is-pattern KSEQ-symbol-0-is-pattern IMP-sort-13-is-pattern IMP-symbol-185-is-pattern string-literal-11-is-pattern string-literal-4-is-pattern KSEQ-symbol-1-is-pattern string-literal-20-is-pattern in-sort-is-pattern IMP-symbol-131-is-pattern IMP-symbol-132-is-pattern string-literal-1-is-pattern IMP-symbol-128-is-pattern IMP-symbol-126-is-pattern element-var-is-var typecode-cache-Pattern-178 and-is-pattern kore-top-is-pattern kore-element-var-x0-elementvariable IMP-symbol-129-is-pattern typecode-cache-Pattern-253 IMP-symbol-194-is-pattern kore-and-is-pattern typecode-cache-Pattern-256 typecode-cache-Pattern-254 top-is-pattern substitution-disjoint typecode-cache-Pattern-177 typecode-cache-Pattern-25 typecode-cache-Pattern-255 typecode-cache-Pattern-257 kore-rewrites-is-pattern kore-valid-is-pattern typecode-cache-Pattern-260 IMP-symbol-218-is-pattern typecode-cache-Pattern-261 rule-imp-transitivity rule-and-intro-alt2-sugar and-elim-left-sugar IMP-symbol-126-substitution IMP-symbol-129-substitution substitution-kore-and substitution-546 imp-reflexivity kore-element-var-x1-elementvariable KSEQ-symbol-0-substitution IMP-symbol-131-substitution substitution-kore-rewrites substitution-kore-valid substitution-imp sorting-cache-1018 imp-is-pattern proof-rule-prop-1 kore-dv-sorting proof-rule-mp top-intro rule-weakening sorting-rearrange-1566 and-elim-right-sugar sorting-cache-1016 sorting-rearrange-1565 substitution-var-same substitution-in-sort substitution-and substitution-1280 substitution-kore-inj substitution-1282 substitution-743 substitution-747 substitution-750 IMP-symbol-132-substitution functional-substitution-alt ) AUFKSBCUOUGAUFKSBCUOUGDREDSUPUGUGHHHHUHJGAUFDMDREFNFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTKGAUFFDGDREFVECUKULUAUDDUBEUCUJUMVBVCAUFKSBCUOUGAUFKSBCUOUGDREDSUPUGAUFKSBCUOUGAUFKSBCUOAUFKSBCUOUGAUFKSAUFKSAUFKSBCUOVIAUFKSVNVGABCWAVHAUFKSBCUOUGDREDSUPDREDSAUFKSBCUOUGDREDSWBDREDSAUFKSBCUOUGWCDRWDWEAUFKSBCUOUGUPWFWGVHVHDREHHHHUHJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCUJUMVBVCHHHHUHJGAUFDMDREFNFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTKGAUFFDGDREFVECUKULUAUDDUBEUCUJUMVBVCHHHHUHJGAUIVDFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTACUIVFUAUDDUBEUCUJUMVBVCAUFKSBCUOUGIURDSUPUGDREDSUPUGUIUSDSUPUGVOIUIABVOCWHAUFKSBCUOUGIURDSUPUGUGIURDSAUFKSBCUOUGUGHHHHUHJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCUJUMVBVCAUFKSBCUOUGIURDSUPUGUGIURDSAUFKSBCUOUGAUFKSBCUOUGIURDSUPUGUGIURDSUPUGIURDSAUFKSBCUOUGIURDSUPUGWIIURDSUPUGIURDSIURDSIURDSUPVIIURDSVNVGVGAUFKSBCUOUGIURDSUPUGUGAUFKSBCUOAUFKSBCUOUGIURDSUPUGUGAUFKSBCUOUGAUFKSAUFKSBCUOUGIURDSUPUGVIAUFKSBCUOVIVGIABCWJVHVHIABCWKVGDREDREDSUPUGHHHHUHJGAUFDMDREFNFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTKGAUFFDGDREFVECUKULUAUDDUBEUCUJUMVBVCIURDSUPUGHHHHUHJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCUJUMVBVCIUEDREDREDSUPIURDSUPIUEDREDREDIURDIUEDREIUEWLDDREIUEUQWMUPDREIUEUQWNHHHHUHJGAUFDMDREFNFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTKGAUFFDGDREFVECUKULUAUDDUBEUCUJUMVBHHHHUHJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCUJUMVBDREIUEHDREIUEUQHHHUHJGAUFDMDREFNFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTKGAUFFDGDREFVECUKULUAUDDUBEUCUJUMHHHUHJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCUJUMDREIUEHDREIUEUQHHUHJGAUFDMDREFNFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJHHUHJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJDREIUEHDREIUEUQHUHDREIUEUQIUEDREJGAUFDMDREFNFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCIUEDREJGAUFDMDREFNFJGKOEDMDPEFNFQLLTABUNCUKULUAJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAIUEDREJGAUFDMDREFNFJGKOEDMDPEFNFQLLJGIAUTFJGKOEDMDPEFNFQLLIUEDREJGAUFDMDREFNFJGKOEDMDPEFNFQLJGIAUTFJGKOEDMDPEFNFQLJGAUFDMDREFNJGIAUTDREIUEJDREIUEUQGDREIUEUQIAWOWPJGKOEDMDPEFNFQLDREIUEUQVPVQABUNCUKULUADREIUEUQVJDUBEUCDREIUEUQVKVLHHUHJGKOEDMDPEFNFQLTKGAUFFDGDREFVECUKULUAUDDUBEUCUJHHUHJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCUJDREIUEHDREIUEUQHUHDREIUEUQIUEDREJGKOEDMDPEFNFQLTKGAUFFDGDREFVECUKULUAUDDUBEUCJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCIUEDREJGKOEDMDPEFNFQLTKGAUFFDGDREFVECUKULUAJGKOEDMDPEFNFQLTIACVAUAJGKOEDMDPEFNFQLTDREIUEUQIACWQVJDUBEUCDREIUEUQVKVLVRVSVTUIUSUIUSDSUPUGHHHHUHJGAUIVDFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTACUIVFUAUDDUBEUCUJUMVBVCIURDSUPUGHHHHUHJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCUJUMVBVCIUEIUIWRHHHHUHJGAUIVDFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTACUIVFUAUDDUBEUCUJUMVBHHHHUHJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCUJUMVBUIUSIUEIUIVMHHHUHJGAUIVDFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTACUIVFUAUDDUBEUCUJUMHHHUHJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUMHHUHJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCUJUMUIUSIUEIUIVMHHUHJGAUIVDFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJHHUHJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCUJUIUSIUEIUIVMHUHUIUSIUEUQIUEUIUSJGAUIVDFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAUDDUBEUCIUEUIUSJGAUIVDFJGKOEDMDPEFNFQLLTABUNCUKULUAJGIAUTFJGKOEDMDPEFNFQLLTABUNCUKULUAIUEUIUSJGAUIVDFJGKOEDMDPEFNFQLLJGIAUTFJGKOEDMDPEFNFQLLIUEUIUSJGAUIVDFJGKOEDMDPEFNFQLJGIAUTFJGKOEDMDPEFNFQLIAUIWSJGKOEDMDPEFNFQLUIUSIUEUQVPVQABUNCUKULUAUIUSIUEUQVJDUBEUCUIUSIUEUQVKVLHHUHJGKOEDMDPEFNFQLTACUIVFUAUDDUBEUCUJHHUHJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCUJUIUSIUEIUIVMHUHUIUSIUEUQIUEUIUSJGKOEDMDPEFNFQLTACUIVFUAUDDUBEUCJGKOEDMDPEFNFQLTIACVAUAUDDUBEUCIUEUIUSJGKOEDMDPEFNFQLTACUIVFUAJGKOEDMDPEFNFQLTIACVAUAJGKOEDMDPEFNFQLTUIUSIUEUQIUEUIUSACUIVFIACVAIACUIWTXAVJDUBEUCUIUSIUEUQVKVLVRVSVTXBVG $. $}
