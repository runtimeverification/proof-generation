$c \exists "1" #Substitution "amount" \kore-sort-SortBExp \top "balanceSender" \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-sort-SortStmt #Variable \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt \imp \kore-dv "0" \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \in-sort \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block \kore-sort-SortBlock \kore-exists \kore-sort-SortKItem \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt "ret" \kore-inj \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-sort-SortInt \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp "balanceTo" ( $.
$v ph5 z th2 th0 ph6 kore-element-var-x0 th1 ptn2 kore-element-var-Val ph8 ph3 ptn0 ph1 th3 kore-sort-var-R ph0 ph2 xX x ptn1 y ph7 ph4 kore-element-var-From $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-From $.
$d z x $.
$d kore-element-var-x0 kore-element-var-From $.
$d kore-element-var-From z $.
$d y kore-element-var-From $.
$d kore-element-var-Val x $.
$d kore-element-var-From x $.
$d z kore-element-var-Val $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-element-var-From kore-element-var-Val $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-Val $.
$d kore-element-var-x0 z $.
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
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-192-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-204-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) $.
IMP-symbol-204-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortStmt ) ( \in-sort ptn1 \kore-sort-SortStmt ) ) ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) \kore-sort-SortStmt ) ) $.
IMP-symbol-241-is-pattern $a #Pattern ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) $.
IMP-symbol-241-sorting $a |- ( \imp ( \and ( \and ( \in-sort ptn0 \kore-sort-SortBExp ) ( \in-sort ptn1 \kore-sort-SortBlock ) ) ( \in-sort ptn2 \kore-sort-SortBlock ) ) ( \in-sort ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) \kore-sort-SortStmt ) ) $.
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
IMP-symbol-354-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortStmt ) ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) \kore-sort-SortBlock ) ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-From-elementvariable $f #ElementVariable kore-element-var-From $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-4-is-pattern $a #Pattern "1" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
sorting-cache-31 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) \kore-sort-SortBExp ) ) $.
sorting-cache-35 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) \kore-sort-SortBlock ) ) $.
sorting-cache-39 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-42 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) \kore-sort-SortStmt ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-45 $a #Pattern kore-element-var-From $.
substitution-178 $a #Substitution kore-sort-var-R kore-sort-var-R kore-element-var-x0 kore-element-var-From $.
sorting-cache-398 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-405 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-407 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-sort-SortStmt ) ) $.
sorting-rearrange-250 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortStmt \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortStmt \unit-sort kore-element-var-Val ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) ) ) ) $.
sorting-cache-411 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) \kore-sort-SortBExp ) ) $.
sorting-cache-412 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) \kore-sort-SortBlock ) ) $.
typecode-cache-Pattern-247 $a #Pattern ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-From ) ) $.
sorting-rearrange-469 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortStmt ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-From ) ) ) ) ) $.
typecode-cache-Pattern-248 $a #Pattern ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-x0 ) ) $.
substitution-729 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortStmt ) \top ) ( \and ( \in-sort kore-element-var-From \kore-sort-SortStmt ) \top ) kore-element-var-x0 kore-element-var-From $.
substitution-732 $a #Substitution ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-x0 ) ) ) ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-From ) ) ) kore-element-var-x0 kore-element-var-From $.
${ sorting-rearrange-470 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortKItem kore-sort-var-R kore-element-var-Val ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) ) ) ) ) $= ( IMP-sort-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-13-is-pattern IMP-symbol-185-is-pattern IMP-sort-23-is-pattern string-literal-14-is-pattern string-literal-10-is-pattern string-literal-17-is-pattern IMP-symbol-204-is-pattern string-literal-11-is-pattern IMP-symbol-354-is-pattern IMP-symbol-164-is-pattern IMP-symbol-160-is-pattern string-literal-4-is-pattern typecode-cache-Pattern-0 in-sort-is-pattern IMP-symbol-192-is-pattern string-literal-1-is-pattern IMP-sort-31-is-pattern top-is-pattern kore-element-var-From-elementvariable IMP-symbol-241-is-pattern and-is-pattern BASIC-K-sort-1-is-pattern element-var-is-var kore-is-sort-is-pattern kore-exists-is-pattern IMP-sort-18-is-pattern kore-element-var-x0-elementvariable substitution-disjoint typecode-cache-Pattern-31 rule-and-intro-alt2-sugar rule-imp-transitivity kore-valid-is-pattern typecode-cache-Pattern-45 IMP-sort-22-is-pattern typecode-cache-Pattern-247 kore-equals-is-pattern typecode-cache-Pattern-25 IMP-symbol-204-sorting typecode-cache-Pattern-248 IMP-symbol-354-sorting IMP-symbol-241-sorting top-intro rule-weakening substitution-var-same substitution-kore-valid substitution-imp sorting-cache-133 sorting-cache-411 sorting-cache-412 sorting-cache-407 sorting-cache-398 sorting-cache-405 eq-is-pattern exists-is-pattern sorting-cache-31 sorting-cache-35 sorting-cache-39 sorting-cache-42 sorting-rearrange-250 kore-functional sorting-rearrange-469 substitution-in-sort substitution-and substitution-kore-inj substitution-kore-equals substitution-kore-exists-alt substitution-729 substitution-178 substitution-732 functional-substitution-alt ) ARUIUCUFARUIUCUFCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUBSUCUFUFARUGARUGARBUNUBUGCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEEVABUJUQARUIUCUFARUIUCUFCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUBSUCUFAVLARUIUCUFCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUBSUCARUIUCUFCFCIDECFCJDETUSSCMDHFHUADEGNUKSUFCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUKSUFCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUBSARUIUCUFCFCIDECFCJDETUSSCMDHFHUADEGNUKSUFCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUKSARUIUCUFCFCIDECFCJDETUSSCMDHFHUADEGNUKSAVMAVNUOARUIUCUFCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLUBSCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUKSARUIUCUFCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLUBSCMDHFHQDEGUBSUFCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLUBSARUIUCUFCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLUBSCMDHFHQDEGUBSARUIUCUFCJDCFCJDECFCIDEOGUBSCKDCFCKDECFCIDEPGUBSUFCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLUBSARUIUCUFCJDCFCJDECFCIDEOGUBSCKDCFCKDECFCIDEPGUBSAVOAVPUOCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGVCUPAVQUOCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGVCUPCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLVEUPUOCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNVFUPARUIUCUFUCVGVHUOUOCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEARUGARABUDUTBUJUQARUGARUGARBUNUBUGCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEEVABUJUQARUGARABULVDBUJUQARUIUCUFUDURUBSUCUFCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUBSUCUFULVBUBSUCUFBUDULARUIUCUFUCBUNCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEVRBVSARUIUCUFUCVGVHUBCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUCBUCCFCIDECFCJDETUSSCMDHFHUADEGNUKSUFCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUKSUFCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUBSUCCFCIDECFCJDETUSSCMDHFHUADEGNUKSUFCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUKSUCCFCIDECFCJDETUSSCMDHFHUADEGNUKSVTWAUOUCCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLUBSCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUKSUCCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLUBSCMDHFHQDEGUBSUFCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLUBSUCCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLUBSCMDHFHQDEGUBSWBWCUOCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGVCUPCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLVEUPUOCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNVFUPBWDWEUPABUDWFCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUECFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUBSUCUFARUGARUGARBUNUBUGCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEEVABUJUQUDURUBSUCUFARUGARABUDUTBUJUQUDUHCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUECFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUBSUCUDURUBSUCUDUHCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUECFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUBUDURUBUDUHCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHVIUBCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUMWGUCCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUMWHARUGARUGARBUNUBUGCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEEVABUJARUGARABUDUTBUJCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHARCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUMUGARUGARBUNUBUGCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEEVAUGARABUDUTCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEBUDUHUGCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUMARCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUMUGARBUNUBUGCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEEUGARBUNUBUGUDURECFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUGCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUMARCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUMBUNCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUMUBUGCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUBUGUDURCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUBCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUMUGCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHUMCFCIDECFCJDETCMDHFHUADEGNCJDCFCJDECFCIDEOGCKDCFCKDECFCIDEPGLCMDHFHQDEGLNUEUDUHVIWIWJWKVJVKULVBULVBUBSUCUFARUGARABULVDBUJUQUDURUBSUCUFARUGARABUDUTBUJUQUDUHUDULWLARUGARABULVDBUJARUGARABUDUTBUJULVBUDUHAUDULWMABUDULWNVJVKWOUP $. $}
