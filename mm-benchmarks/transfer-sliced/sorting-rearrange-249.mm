$c \exists "1" #Substitution "amount" \top "balanceSender" \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-sort-SortStmt #Variable \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt \imp \kore-dv "0" \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \in-sort \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block \kore-sort-SortBlock \kore-exists \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt "ret" \kore-inj \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-sort-SortInt \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp "balanceTo" ( $.
$v z xX0 th2 th0 ph6 kore-element-var-x0 th1 ptn5 ptn2 kore-element-var-Val ptn3 ph3 ptn0 ph8 ph1 th3 kore-sort-var-R ph0 ph2 xX x ptn4 ptn6 ptn1 y ph7 ph4 ph5 kore-element-var-K2 $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-Val kore-element-var-K2 $.
$d z x $.
$d z kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K2 $.
$d x kore-element-var-K2 $.
$d kore-element-var-Val x $.
$d z kore-element-var-Val $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-x0 kore-element-var-K2 $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-Val $.
$d kore-element-var-x0 z $.
$d y kore-element-var-K2 $.
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
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
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
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ $d xX y $.
   $d y ph6 $.
   substitution-kore-exists-alt.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-exists-alt.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-exists-alt.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-exists-alt $a #Substitution ( \kore-exists ph0 ph1 y ph2 ) ( \kore-exists ph3 ph4 y ph5 ) ph6 xX $. $}
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
${ substitution-kore-equals.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-equals.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-equals.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-equals.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-equals $a #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $. $}
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
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
ptn5-pattern $f #Pattern ptn5 $.
ptn6-pattern $f #Pattern ptn6 $.
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-192-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-204-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) $.
IMP-symbol-204-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortStmt ) ( \in-sort ptn1 \kore-sort-SortStmt ) ) ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) \kore-sort-SortStmt ) ) $.
IMP-symbol-241-is-pattern $a #Pattern ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) $.
${ IMP-symbol-241-substitution.0 $e #Substitution ptn1 ptn4 ptn0 xX0 $.
   IMP-symbol-241-substitution.1 $e #Substitution ptn2 ptn5 ptn0 xX0 $.
   IMP-symbol-241-substitution.2 $e #Substitution ptn3 ptn6 ptn0 xX0 $.
   IMP-symbol-241-substitution $a #Substitution ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn1 ptn2 ptn3 ) ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn4 ptn5 ptn6 ) ptn0 xX0 $. $}
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
IMP-symbol-354-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortStmt ) ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) \kore-sort-SortBlock ) ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K2-elementvariable $f #ElementVariable kore-element-var-K2 $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-4-is-pattern $a #Pattern "1" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
sorting-cache-39 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-42 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) \kore-sort-SortStmt ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-120 $a #Pattern kore-element-var-K2 $.
typecode-cache-Pattern-132 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) $.
sorting-rearrange-205 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) kore-element-var-K2 ) ) ) ) ) $.
sorting-cache-398 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-405 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-407 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-sort-SortStmt ) ) $.
sorting-rearrange-248 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortBlock \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortBlock \unit-sort kore-element-var-Val ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) ) ) $.
sorting-cache-410 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) ) ) $.
substitution-399 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortBlock ) \top ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortBlock ) \top ) kore-element-var-x0 kore-element-var-K2 $.
substitution-400 $a #Substitution kore-sort-var-R kore-sort-var-R kore-element-var-x0 kore-element-var-K2 $.
substitution-401 $a #Substitution \kore-sort-SortStmt \kore-sort-SortStmt kore-element-var-x0 kore-element-var-K2 $.
substitution-402 $a #Substitution kore-element-var-Val kore-element-var-Val kore-element-var-x0 kore-element-var-K2 $.
${ sorting-rearrange-249 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) ) ) ) $= ( IMP-sort-17-is-pattern kore-dv-is-pattern IMP-sort-13-is-pattern kore-inj-is-pattern IMP-symbol-185-is-pattern IMP-sort-23-is-pattern string-literal-10-is-pattern string-literal-14-is-pattern string-literal-17-is-pattern IMP-symbol-204-is-pattern string-literal-11-is-pattern typecode-cache-Pattern-0 IMP-symbol-354-is-pattern IMP-sort-31-is-pattern kore-element-var-K2-elementvariable IMP-symbol-164-is-pattern IMP-symbol-160-is-pattern string-literal-4-is-pattern top-is-pattern in-sort-is-pattern and-is-pattern IMP-symbol-192-is-pattern string-literal-1-is-pattern element-var-is-var kore-element-var-x0-elementvariable typecode-cache-Pattern-31 IMP-symbol-241-is-pattern IMP-sort-18-is-pattern typecode-cache-Pattern-120 kore-equals-is-pattern typecode-cache-Pattern-25 kore-is-sort-is-pattern kore-exists-is-pattern substitution-disjoint kore-valid-is-pattern rule-imp-transitivity rule-and-intro-alt2-sugar IMP-symbol-204-sorting substitution-var-same substitution-400 IMP-symbol-354-sorting top-intro rule-weakening IMP-symbol-241-substitution substitution-kore-equals substitution-kore-exists-alt substitution-kore-valid substitution-imp substitution-401 sorting-cache-133 sorting-cache-407 sorting-cache-398 sorting-cache-405 eq-is-pattern exists-is-pattern sorting-cache-39 sorting-cache-42 sorting-rearrange-248 kore-functional typecode-cache-Pattern-132 sorting-cache-410 sorting-rearrange-205 substitution-in-sort substitution-and substitution-399 substitution-402 functional-substitution-alt ) ANUNUAUCANUNUAUCCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUJUBUAUCUCANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUIULBUOUQANUNUAUCANUNUAUCCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUJUBUAUCAVLANUNUAUCCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUJUBUAANUNUAUCCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLPUBCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUJUBANUNUAUCCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLPUBCMDHEHTDFGPUBUCCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLPUBANUNUAUCCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLPUBCMDHEHTDFGPUBANUNUAUCCIDCECIDFCECJDFRGPUBCKDCECKDFCECJDFSGPUBUCCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLPUBANUNUAUCCIDCECIDFCECJDFRGPUBCKDCECKDFCECJDFSGPUBAVMAVNUSCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGUTURAVOUSCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGUTURCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLVCURANUNUAUCUAVDVEUSUSCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOQUKUIULBUOUQANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUIULBUOUQANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOUGUMUIULBUOUQANUNUAUCQUKUJUBUAUCCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUJUBUAUCUGUMUJUBUAUCBQUGANUNUAUCUABUHCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOVPBVQANUNUAUCUAVDVEUJCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUABUACIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLPUBCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUJUBUACIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLPUBCMDHEHTDFGPUBUCCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLPUBUACIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLPUBCMDHEHTDFGPUBVRVSUSCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGUTURCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLVCURBVTWAURANUNUAUCQUKUJUBUAUCUCAQWBANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOQUKUIULBUOUQAQWCABQWDURCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUJUBUAUCANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUIULBUOUQQUKUJUBUAUCANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOQUKUIULBUOUQQUFCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUJUBUAQUKUJUBUAQUFCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUJQUKUJQUFCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFVAUJCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFUPWEUACIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFUPWFANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUIULBUOANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOQUKUIULBUOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFANCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFUPPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUIULPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOQUKUIULCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOBQUFPCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFUPANCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFUPPANBUHCECJDFCECIDFUDCMDHEHUEDFGOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOUIPANBUHCECJDFCECIDFUDCMDHEHUEDFGOQUKUICIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFPCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFUPANCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFUPBUHCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFUPQUFCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOCECJDFCECIDFUDCMDHEHUEDFGOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOCECJDFCECIDFUDCMDHEHUEDFGOQUKCECJDFCECIDFUDCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFUPCMDHEHUEDFGOCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFUPCIDCECIDFCECJDFRGCKDCECKDFCECJDFSGLCMDHEHTDFGLOQUFVAVFVGVHVIVJUGUMUGUMUJUBUAUCANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOUGUMUIULBUOUQQUKUJUBUAUCANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOQUKUIULBUOUQQUFQUGWGANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOUGUMUIULBUOANPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOQUKUIULBUOUGUMQUFAQUGVBPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOUGUMUIULPANPANBUHCECJDFCECIDFUDCMDHEHUEDFGOQUKUIULUGUMBQUFQUGVKAQUGVBPANBUHCECJDFCECIDFUDCMDHEHUEDFGOUGUMUIPANBUHCECJDFCECIDFUDCMDHEHUEDFGOQUKUIUGUMQUFQUGVKAQUGVBBQUGWHQUFUGUMCECJDFCECIDFUDCMDHEHUEDFGOUGUMCECJDFCECIDFUDCMDHEHUEDFGOQUKCECJDFCECIDFUDUGUMQUFUPCMDHEHUEDFGOUGUMQUFUPUGUMQUFVAVFVGVHVIVJWIUR $. $}
