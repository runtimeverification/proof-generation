$c \exists #Substitution \kore-symbol-Lbl'-LT-'T'-GT-' "amount" \top "balanceSender" \kore-sort-SortAExp \kore-symbol-dotk \kore-symbol-kseq \kore-sort-SortStmt #Variable \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt \imp \kore-dv "0" |- \kore-sort-SortId \kore-valid ) \kore-symbol-Lbl'-LT-'k'-GT-' \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \kore-equals \in-sort \and \kore-and \unit-sort #SetVariable \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' \eq #Pattern \kore-exists \kore-sort-SortKItem \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' \kore-inj \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-sort-SortInt \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \kore-top \kore-sort-SortStateCell "balanceTo" ( $.
$v z xX0 th2 kore-element-var-VE3 th0 kore-element-var-VE2 ph6 kore-element-var-x0 th1 kore-element-var-VE4 ptn3 kore-element-var-Val ptn2 ph3 ptn0 ph1 th3 ph0 ph2 xX x ptn4 ptn1 y ph4 ph5 $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d y kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE3 kore-element-var-Val $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-Val kore-element-var-VE2 $.
$d z x $.
$d kore-element-var-VE3 x $.
$d kore-element-var-VE3 z $.
$d kore-element-var-x0 kore-element-var-VE3 $.
$d z kore-element-var-VE2 $.
$d kore-element-var-Val x $.
$d kore-element-var-VE4 z $.
$d y kore-element-var-VE4 $.
$d z kore-element-var-Val $.
$d y x $.
$d kore-element-var-VE4 kore-element-var-Val $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-VE4 x $.
$d y kore-element-var-Val $.
$d kore-element-var-x0 kore-element-var-VE4 $.
$d kore-element-var-x0 z $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-x0 kore-element-var-VE2 $.
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
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-204-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) $.
${ IMP-symbol-204-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-204-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-204-substitution $a #Substitution ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn1 ptn2 ) ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-204-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortStmt ) ( \in-sort ptn1 \kore-sort-SortStmt ) ) ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) \kore-sort-SortStmt ) ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
sorting-cache-39 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) \kore-sort-SortStmt ) ) $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
sorting-rearrange-232 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortStmt \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortStmt \unit-sort kore-element-var-Val ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ) ) ) ) $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
substitution-546 $a #Substitution \kore-sort-SortGeneratedTopCell \kore-sort-SortGeneratedTopCell kore-element-var-x0 kore-element-var-VE2 $.
substitution-688 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortStmt ) \top ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) \top ) kore-element-var-x0 kore-element-var-VE2 $.
typecode-cache-Pattern-239 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) $.
typecode-cache-Pattern-240 $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-VE2 kore-element-var-VE4 ) $.
sorting-rearrange-465 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-VE2 kore-element-var-VE4 ) ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE2 ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE4 ) \kore-symbol-dotk ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $.
sorting-cache-883 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) $.
typecode-cache-Pattern-245 $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-x0 kore-element-var-VE4 ) $.
substitution-720 $a #Substitution ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-x0 kore-element-var-VE4 ) ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt kore-element-var-VE2 kore-element-var-VE4 ) ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) kore-element-var-x0 kore-element-var-VE2 $.
substitution-721 $a #Substitution ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-x0 ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE4 ) \kore-symbol-dotk ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE2 ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE4 ) \kore-symbol-dotk ) ) ) kore-element-var-VE3 ) kore-element-var-x0 kore-element-var-VE2 $.
sorting-cache-884 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ) $.
sorting-cache-1905 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-1908 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-sort-SortStmt ) ) $.
${ sorting-rearrange-1138 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortStmt ) \top ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) kore-element-var-VE4 ) ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE4 ) \kore-symbol-dotk ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( IMP-sort-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-13-is-pattern string-literal-10-is-pattern string-literal-14-is-pattern IMP-symbol-185-is-pattern string-literal-17-is-pattern IMP-sort-31-is-pattern IMP-sort-8-is-pattern kore-element-var-VE2-elementvariable BASIC-K-sort-1-is-pattern KSEQ-symbol-0-is-pattern IMP-symbol-204-is-pattern IMP-symbol-164-is-pattern IMP-symbol-160-is-pattern KSEQ-symbol-1-is-pattern typecode-cache-Pattern-178 IMP-symbol-131-is-pattern IMP-sort-23-is-pattern string-literal-1-is-pattern IMP-symbol-128-is-pattern element-var-is-var IMP-symbol-126-is-pattern kore-top-is-pattern typecode-cache-Pattern-179 IMP-symbol-129-is-pattern typecode-cache-Pattern-177 kore-and-is-pattern kore-element-var-x0-elementvariable in-sort-is-pattern top-is-pattern substitution-disjoint and-is-pattern typecode-cache-Pattern-25 typecode-cache-Pattern-239 typecode-cache-Pattern-240 kore-rewrites-is-pattern kore-valid-is-pattern rule-imp-transitivity typecode-cache-Pattern-245 kore-element-var-Val-elementvariable rule-and-intro-alt2-sugar IMP-symbol-129-substitution substitution-kore-and substitution-546 substitution-var-same top-intro rule-weakening substitution-kore-inj KSEQ-symbol-0-substitution IMP-symbol-131-substitution IMP-symbol-126-substitution substitution-kore-rewrites substitution-kore-valid substitution-imp sorting-cache-884 sorting-cache-1905 sorting-cache-1908 IMP-symbol-204-sorting typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern sorting-cache-39 sorting-rearrange-232 kore-functional and-elim-right-sugar and-elim-left-sugar imp-reflexivity sorting-cache-883 sorting-rearrange-465 substitution-in-sort substitution-and IMP-symbol-204-substitution substitution-688 substitution-720 substitution-721 functional-substitution-alt ) ABURABURCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKUMUNUPUPLLLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPESOUAATUFUBUCDUDUIUKLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPEKNBUHESOOUAATUFUBUCDUDUIUKUTVAABURABURCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKUMUNUPABVSABURCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKUMUNABURCGDCFCGDECFCHDEQIKUMCJDCFCJDECFCHDERIKUMUPCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKUMABURCGDCFCGDECFCHDEQIKUMCJDCFCJDECFCHDERIKUMABVTABWAVECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIWBVBABURUNVJVKVEVECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPLLLLUGKNMBUSESOUAATUFUBUCDUDUIUKLLUGKNMUJEKNBUHESOOUAATUFUBUCDUDUIUKUTVALLLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPESOUAATUFUBUCDUDUIUKLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPEKNBUHESOOUAATUFUBUCDUDUIUKUTVALLLLUGKNBULVCESOUAATUFUBUCDUDUIUKLLUGKNULUQEKNBUHESOOUAATUFUBUCDUDUIUKUTVAABURMUJKUMUNUPCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKUMUNUPULUQKUMUNUPVDMULABURUNVDWCCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPWDVDWEABURUNVJVKKCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPUNVDWFVDWGWHVBABURMUJKUMUNUPUPMUJKUMABURUPLLLLUGKNMBUSESOUAATUFUBUCDUDUIUKLLUGKNMUJEKNBUHESOOUAATUFUBUCDUDUIUKUTVAABURMUJKUMUNUPUPMUJKUMABURABURMUJKUMUNUPUPMUJKUMUNUPMUJKUMABURMUJKUMUNUPWIMUJKUMUNUPMUJKUMMUJKUMMUJKUMUNWJMUJKUMWKVBVBMABWLVEMABWMVBCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKUMUNUPLLLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPESOUAATUFUBUCDUDUIUKLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPEKNBUHESOOUAATUFUBUCDUDUIUKUTVAMUJKUMUNUPLLLLUGKNMBUSESOUAATUFUBUCDUDUIUKLLUGKNMUJEKNBUHESOOUAATUFUBUCDUDUIUKUTVAMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKUMUNMUJKUMUNMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKMUJKMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEVIKCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOWNUNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOWOLLLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPESOUAATUFUBUCDUDUIUKLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPEKNBUHESOOUAATUFUBUCDUDUIUKUTLLLLUGKNMBUSESOUAATUFUBUCDUDUIUKLLUGKNMUJEKNBUHESOOUAATUFUBUCDUDUIUKUTCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUELCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOLLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPESOUAATUFUBUCDUDUIUKLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPEKNBUHESOOUAATUFUBUCDUDUIUKLLLUGKNMBUSESOUAATUFUBUCDUDUIUKLLUGKNMUJEKNBUHESOOUAATUFUBUCDUDUIUKCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUELCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPESOUAATUFUBUCDUDUILLUGKNMBUSESOUAATUFUBUCDUDUICGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUELCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOLUGCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPESOUAATUFUBUCDUDKNMBUSESOUAATUFUBUCDUDMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPESOUAATKNMBUSESOUAATMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPESOKNMBUSESOMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPESKNMBUSESKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHPKNMBUSCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEKCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUONCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPBUHMUJBUHCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEVIBUHCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOWPVLSCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOVMVNATCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOVOUBUCDUDCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOVFVGLLUGKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPEKNBUHESOOUAATUFUBUCDUDUILLUGKNMUJEKNBUHESOOUAATUFUBUCDUDUICGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUELCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOLUGCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPEKNBUHESOOUAATUFUBUCDUDKNMUJEKNBUHESOOUAATUFUBUCDUDMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPEKNBUHESOOUAATKNMUJEKNBUHESOOUAATMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPEKNBUHESOOKNMUJEKNBUHESOOMUECGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPEKNBUHESOKNMUJEKNBUHESOKNCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPKNMUJCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEKCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUONCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEVIVLKNBUHESOCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOVMVNATCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOVOUBUCDUDCGDCFCGDECFCHDEQICJDCFCJDECFCHDERIPMUEUOVFVGVPVQVRULUQULUQKUMUNUPLLLLUGKNBULVCESOUAATUFUBUCDUDUIUKLLUGKNULUQEKNBUHESOOUAATUFUBUCDUDUIUKUTVAMUJKUMUNUPLLLLUGKNMBUSESOUAATUFUBUCDUDUIUKLLUGKNMUJEKNBUHESOOUAATUFUBUCDUDUIUKUTVAMUEMULWQLLLLUGKNBULVCESOUAATUFUBUCDUDUIUKLLUGKNULUQEKNBUHESOOUAATUFUBUCDUDUIUKUTLLLLUGKNMBUSESOUAATUFUBUCDUDUIUKLLUGKNMUJEKNBUHESOOUAATUFUBUCDUDUIUKUTULUQMUEMULVHLLLUGKNBULVCESOUAATUFUBUCDUDUIUKLLUGKNULUQEKNBUHESOOUAATUFUBUCDUDUIUKLLLUGKNMBUSESOUAATUFUBUCDUDUIUKLLUGKNMUJEKNBUHESOOUAATUFUBUCDUDUIUKULUQMUEMULVHLLUGKNBULVCESOUAATUFUBUCDUDUILLUGKNMBUSESOUAATUFUBUCDUDUIULUQMUEMULVHLUGULUQMUEUOMUEULUQKNBULVCESOUAATUFUBUCDUDKNMBUSESOUAATUFUBUCDUDMABULWRUBUCDUDULUQMUEUOVFVGLLUGKNULUQEKNBUHESOOUAATUFUBUCDUDUILLUGKNMUJEKNBUHESOOUAATUFUBUCDUDUIULUQMUEMULVHLUGULUQMUEUOMUEULUQKNULUQEKNBUHESOOUAATUFUBUCDUDKNMUJEKNBUHESOOUAATUFUBUCDUDMABULWSUBUCDUDULUQMUEUOVFVGVPVQVRWTVB $. $}
