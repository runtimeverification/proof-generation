$c "1" #Substitution \kore-symbol-Lbl'-LT-'T'-GT-' \top \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-symbol-kseq \kore-sort-SortK \imp "0" ) \kore-and #SetVariable \kore-top #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' "ret" \kore-inj \kore-sort-SortInt \in-sort "balanceTo" ( \exists "amount" "balanceSender" \kore-sort-SortStmt #Variable \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt "200" \kore-dv |- \kore-sort-SortId \kore-valid \kore-symbol-Lbl'-LT-'k'-GT-' \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \and \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable \eq \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block \kore-sort-SortKItem \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \kore-symbol-dotk \kore-sort-SortStateCell $.
$v kore-element-var-V0 xX0 z kore-element-var-VE1 th2 kore-element-var-VE3 th0 kore-element-var-VE2 ph6 kore-element-var-x0 th1 kore-element-var-VE4 ptn2 ptn3 ph3 ptn0 ph1 th3 ph0 ph2 xX x ptn4 ptn1 y ph4 ph5 $.
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
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
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
KSEQ-symbol-0-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKItem ) ( \in-sort ptn1 \kore-sort-SortK ) ) ( \in-sort ( \kore-symbol-kseq ptn0 ptn1 ) \kore-sort-SortK ) ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
KSEQ-symbol-1-sorting $a |- ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
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
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-192-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-204-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) $.
IMP-symbol-241-is-pattern $a #Pattern ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) $.
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-4-is-pattern $a #Pattern "1" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-15-is-pattern $a #Pattern "200" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
substitution-448 $a #Substitution \kore-sort-SortGeneratedTopCell \kore-sort-SortGeneratedTopCell kore-element-var-x0 kore-element-var-VE1 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
substitution-681 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortK ) \top ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) kore-element-var-x0 kore-element-var-VE1 $.
substitution-683 $a #Substitution kore-element-var-VE3 kore-element-var-VE3 kore-element-var-x0 kore-element-var-VE1 $.
typecode-cache-Pattern-239 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) $.
typecode-cache-Pattern-240 $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-VE2 kore-element-var-VE4 ) $.
typecode-cache-Pattern-241 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-VE2 kore-element-var-VE4 ) ) kore-element-var-VE1 ) ) kore-element-var-VE3 ) $.
typecode-cache-Pattern-242 $a #Pattern ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE1 ) $.
sorting-rearrange-463 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-VE2 kore-element-var-VE4 ) ) kore-element-var-VE1 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE2 ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE1 ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $.
sorting-cache-881 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) $.
typecode-cache-Pattern-243 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-VE2 kore-element-var-VE4 ) ) kore-element-var-x0 ) ) kore-element-var-VE3 ) $.
typecode-cache-Pattern-244 $a #Pattern ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-x0 ) $.
substitution-714 $a #Substitution ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-VE2 kore-element-var-VE4 ) ) kore-element-var-x0 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-VE2 kore-element-var-VE4 ) ) kore-element-var-VE1 ) ) kore-element-var-VE3 ) kore-element-var-x0 kore-element-var-VE1 $.
substitution-715 $a #Substitution ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE2 ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-x0 ) ) ) ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE2 ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE1 ) ) ) kore-element-var-x0 kore-element-var-VE1 $.
sorting-cache-882 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) $.
sorting-cache-944 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) ( \in-sort ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) \kore-sort-SortKItem ) ) $.
sorting-rearrange-487 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) ( \exists kore-element-var-V0 ( \eq kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) \kore-symbol-dotk ) ) ) ) ) $.
sorting-cache-952 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) ( \in-sort ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) \kore-sort-SortKItem ) ) $.
${ sorting-rearrange-488 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-VE2 kore-element-var-VE4 ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) \kore-symbol-dotk ) ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE2 ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE4 ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) \kore-symbol-dotk ) ) ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( IMP-sort-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-13-is-pattern IMP-sort-23-is-pattern IMP-symbol-185-is-pattern IMP-sort-31-is-pattern string-literal-14-is-pattern string-literal-10-is-pattern string-literal-17-is-pattern BASIC-K-sort-1-is-pattern KSEQ-symbol-0-is-pattern string-literal-11-is-pattern IMP-symbol-354-is-pattern IMP-symbol-204-is-pattern string-literal-1-is-pattern IMP-sort-8-is-pattern kore-element-var-VE1-elementvariable in-sort-is-pattern KSEQ-symbol-1-is-pattern IMP-symbol-192-is-pattern IMP-symbol-164-is-pattern IMP-symbol-160-is-pattern string-literal-4-is-pattern IMP-symbol-241-is-pattern typecode-cache-Pattern-177 string-literal-15-is-pattern IMP-symbol-128-is-pattern and-is-pattern kore-top-is-pattern element-var-is-var IMP-symbol-129-is-pattern BASIC-K-sort-0-is-pattern typecode-cache-Pattern-178 IMP-symbol-131-is-pattern kore-element-var-x0-elementvariable kore-and-is-pattern IMP-symbol-126-is-pattern typecode-cache-Pattern-239 typecode-cache-Pattern-146 top-is-pattern substitution-disjoint typecode-cache-Pattern-242 typecode-cache-Pattern-240 typecode-cache-Pattern-25 typecode-cache-Pattern-179 kore-rewrites-is-pattern typecode-cache-Pattern-241 kore-valid-is-pattern rule-imp-transitivity rule-and-intro-alt2-sugar typecode-cache-Pattern-244 typecode-cache-Pattern-243 and-elim-left-sugar IMP-symbol-129-substitution substitution-kore-and substitution-448 substitution-var-same KSEQ-symbol-0-substitution IMP-symbol-126-substitution imp-reflexivity KSEQ-symbol-0-sorting kore-element-var-V0-elementvariable IMP-symbol-131-substitution substitution-kore-rewrites substitution-kore-valid substitution-imp sorting-cache-882 sorting-cache-952 sorting-cache-944 imp-is-pattern proof-rule-prop-1 KSEQ-symbol-1-sorting proof-rule-mp top-intro rule-weakening sorting-rearrange-487 and-elim-right-sugar sorting-cache-881 sorting-rearrange-463 substitution-in-sort substitution-and substitution-681 substitution-714 substitution-715 substitution-683 functional-substitution-alt ) AUIJUBBCVBULAUIJUBBCVBULJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUPUBVDULULTTTTUMJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOURBUQVAHSEUKUOUTTTUMJNAUIFJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOOURBUQVAHSEUKUOUTVJVLAUIJUBBCVBULAUIJUBBCVBULJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUPUBVDULAUIJUBBCVBULAUIJUBBCVBAUIJUBBCVBULAUIJUBAUIJUBAUIJUBBCVBVQAUIJUBWDVMABCWKVNAUIJUBBCVBULJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUPUBVDAUIJUBBCVBULJNDMEHGHUJEFIFNUBJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOUPUBULJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUPUBAUIJUBBCVBULJNDMEHGHUJEFIFNUBJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOUPUBABCWLAUIJUBBCVBULJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFNUBUCUPUBULJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOUPUBAUIJUBBCVBULJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFNUBUCUPUBABCWMUCUPUBAUIJUBBCVBULUCUPUBWNUCUPUBAUIJUBBCVBULWOWPWQVNJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCWEVMVNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOWEVMAUIJUBBCVBULVDWRWSVNVNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOTTTTUMAUABCVKHSEUKUOUTTTUMJNAUIFUACVFOURBUQVAHSEUKUOUTVJVLTTTTUMJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOURBUQVAHSEUKUOUTTTUMJNAUIFJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOOURBUQVAHSEUKUOUTVJVLTTTTUMABCUSVPHSEUKUOUTTTUMJNAUIFCUSVOOURBUQVAHSEUKUOUTVJVLAUIJUBBCVBULUAVCUPUBVDULJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUPUBVDULUSVHUPUBVDULWFUAUSABCWFWTAUIJUBBCVBULUAVCUPUBVDULULUAVCUPUBAUIJUBBCVBULULTTTTUMAUABCVKHSEUKUOUTTTUMJNAUIFUACVFOURBUQVAHSEUKUOUTVJVLAUIJUBBCVBULUAVCUPUBVDULULUAVCUPUBAUIJUBBCVBULAUIJUBBCVBULUAVCUPUBVDULULUAVCUPUBVDULUAVCUPUBAUIJUBBCVBULUAVCUPUBVDULXAUAVCUPUBVDULUAVCUPUBUAVCUPUBUAVCUPUBVDVQUAVCUPUBWDVMVMAUIJUBBCVBULUAVCUPUBVDULULAUIJUBBCVBAUIJUBBCVBULUAVCUPUBVDULULAUIJUBBCVBULAUIJUBAUIJUBBCVBULUAVCUPUBVDULVQAUIJUBBCVBVQVMAUABCXBVNVNAUABCXCVMJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUPUBVDULTTTTUMJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOURBUQVAHSEUKUOUTTTUMJNAUIFJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOOURBUQVAHSEUKUOUTVJVLUAVCUPUBVDULTTTTUMAUABCVKHSEUKUOUTTTUMJNAUIFUACVFOURBUQVAHSEUKUOUTVJVLUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUPUBVDUAVCUPUBVDUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUPUAVCUPUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNWAUPJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEXDVDJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEXETTTTUMJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOURBUQVAHSEUKUOUTTTUMJNAUIFJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOOURBUQVAHSEUKUOUTVJTTTTUMAUABCVKHSEUKUOUTTTUMJNAUIFUACVFOURBUQVAHSEUKUOUTVJJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNTJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVETTTUMJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOURBUQVAHSEUKUOUTTTUMJNAUIFJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOOURBUQVAHSEUKUOUTTTTUMAUABCVKHSEUKUOUTTTUMJNAUIFUACVFOURBUQVAHSEUKUOUTJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNTJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVETTUMJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOURBUQVAHSEUKUOTTUMAUABCVKHSEUKUOJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNTJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVETUMJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOURBUQVAHSEUKAUABCVKHSEUKUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOURBUQJNACVGFUAVCOURBUQUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOJNACVGFUAVCOUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNACVGFUAVCJNACVGFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNWAWBWGBUQJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEWCHSEUKJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEVRVSTTUMJNAUIFJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOOURBUQVAHSEUKUOTTUMJNAUIFUACVFOURBUQVAHSEUKUOJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNTJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVETUMJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNAUIFJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOOURBUQVAHSEUKJNAUIFUACVFOURBUQVAHSEUKUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNAUIFJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOOURBUQJNAUIFUACVFOURBUQUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNAUIFJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOOJNAUIFUACVFOUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNAUIFJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOOJNAUIFUACVFJNAUIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEUAUNJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOJNCVIFUAVCJNCVIFJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNWAWBWBWGBUQJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEWCHSEUKJNDMEHGHUJEFIFJNDGDKEFDGDLEFUDDPEHGHSEFIQDLEDGDLEFDGDKEFUEIDMEDGDMEFDGDKEFUFIRDPEHGHUGEFIRQUHFUCOOUAUNVEVRVSWHWIWJUSVHUSVHUPUBVDULTTTTUMABCUSVPHSEUKUOUTTTUMJNAUIFCUSVOOURBUQVAHSEUKUOUTVJVLUAVCUPUBVDULTTTTUMAUABCVKHSEUKUOUTTTUMJNAUIFUACVFOURBUQVAHSEUKUOUTVJVLUAUNUAUSXFTTTTUMABCUSVPHSEUKUOUTTTUMJNAUIFCUSVOOURBUQVAHSEUKUOUTVJTTTTUMAUABCVKHSEUKUOUTTTUMJNAUIFUACVFOURBUQVAHSEUKUOUTVJUSVHUAUNUAUSVTTTTUMABCUSVPHSEUKUOUTTTUMJNAUIFCUSVOOURBUQVAHSEUKUOUTTTTUMAUABCVKHSEUKUOUTTTUMJNAUIFUACVFOURBUQVAHSEUKUOUTUSVHUAUNUAUSVTTTUMABCUSVPHSEUKUOTTUMAUABCVKHSEUKUOUSVHUAUNUAUSVTTUMUSVHUAUNVEUAUNUSVHABCUSVPHSEUKAUABCVKHSEUKAUABCUSXGHSEUKUSVHUAUNVEVRVSTTUMJNAUIFCUSVOOURBUQVAHSEUKUOTTUMJNAUIFUACVFOURBUQVAHSEUKUOUSVHUAUNUAUSVTTUMUSVHUAUNVEUAUNUSVHJNAUIFCUSVOOURBUQVAHSEUKJNAUIFUACVFOURBUQVAHSEUKUAUNUSVHJNAUIFCUSVOOURBUQJNAUIFUACVFOURBUQAUACUSXHUABUSXIWCHSEUKUSVHUAUNVEVRVSWHWIWJXJVM $. $}
