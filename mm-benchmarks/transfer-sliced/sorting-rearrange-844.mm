$c \exists "1" #Substitution "amount" \top "balanceSender" \kore-sort-SortAExp \kore-symbol-kseq \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' #Variable \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt \kore-sort-SortK \imp \kore-dv "0" \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \in-sort \and \unit-sort #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-sort-SortBlock \kore-exists \kore-sort-SortKItem \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt "ret" \kore-inj \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-sort-SortInt \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \kore-symbol-dotk "balanceTo" ( $.
$v kore-element-var-V0 xX0 z th2 th0 ph6 kore-element-var-x0 th1 ptn3 ptn2 kore-element-var-Val kore-element-var-V1 ph3 ptn0 ph8 ph1 th3 kore-sort-var-R kore-element-var-V2 ph0 ph2 xX x ptn4 ptn1 y ph7 ph4 ph5 $.
$d kore-element-var-V0 z $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-element-var-V0 x $.
$d kore-element-var-V0 kore-element-var-V1 $.
$d kore-element-var-V2 kore-element-var-V1 $.
$d kore-sort-var-R kore-element-var-V2 $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-V0 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-V0 $.
$d kore-element-var-Val x $.
$d z kore-element-var-Val $.
$d kore-element-var-Val kore-element-var-V1 $.
$d kore-element-var-V2 kore-element-var-Val $.
$d y kore-element-var-V1 $.
$d kore-element-var-V2 x $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-sort-var-R kore-element-var-V1 $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d z kore-element-var-V1 $.
$d kore-element-var-x0 kore-element-var-V1 $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-Val $.
$d y kore-element-var-V2 $.
$d kore-element-var-V1 x $.
$d kore-element-var-x0 z $.
$d kore-element-var-V2 kore-element-var-V0 $.
$d kore-sort-var-R z $.
$d kore-element-var-x0 kore-element-var-V2 $.
$d kore-element-var-V2 z $.
$d kore-element-var-V0 kore-element-var-Val $.
$d y kore-sort-var-R $.
$d y kore-element-var-V0 $.
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
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
kore-element-var-V1-elementvariable $f #ElementVariable kore-element-var-V1 $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-96-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ptn0 ptn1 ) $.
IMP-symbol-96-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortK ) ( \in-sort ptn1 \kore-sort-SortK ) ) ( \in-sort ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ptn0 ptn1 ) \kore-sort-SortKItem ) ) $.
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-204-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) $.
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-4-is-pattern $a #Pattern "1" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
sorting-cache-91 $a |- ( \imp \top ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
sorting-cache-92 $a |- ( \imp \top ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-31 $a #Pattern kore-element-var-Val $.
typecode-cache-Pattern-35 $a #Pattern kore-element-var-V2 $.
typecode-cache-Pattern-37 $a #Pattern kore-element-var-V1 $.
typecode-cache-Pattern-39 $a #Pattern kore-element-var-V0 $.
typecode-cache-Pattern-156 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
typecode-cache-Pattern-158 $a #Pattern ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) $.
typecode-cache-Pattern-159 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) $.
sorting-rearrange-273 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) ) ) ) $.
typecode-cache-Pattern-161 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-x0 kore-element-var-V2 ) ) $.
substitution-474 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortKItem ) \top ) ( \and ( \in-sort kore-element-var-V1 \kore-sort-SortKItem ) \top ) kore-element-var-x0 kore-element-var-V1 $.
substitution-479 $a #Substitution ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-x0 kore-element-var-V2 ) ) ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) ) ) kore-element-var-x0 kore-element-var-V1 $.
sorting-cache-537 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ) $.
sorting-cache-1277 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \in-sort ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) \kore-sort-SortKItem ) ) $.
sorting-rearrange-843 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortKItem \unit-sort kore-element-var-Val ( \kore-equals \kore-sort-SortKItem \unit-sort kore-element-var-Val ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) \kore-symbol-dotk ) ) ) ) ) ) $.
sorting-cache-1284 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
${ sorting-rearrange-844 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) \kore-symbol-dotk ) ) kore-element-var-V2 ) ) ) ) ) $= ( IMP-sort-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-13-is-pattern IMP-symbol-185-is-pattern IMP-sort-23-is-pattern BASIC-K-sort-1-is-pattern string-literal-10-is-pattern string-literal-14-is-pattern string-literal-17-is-pattern IMP-symbol-204-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern IMP-sort-18-is-pattern string-literal-11-is-pattern IMP-symbol-354-is-pattern IMP-symbol-164-is-pattern IMP-symbol-160-is-pattern string-literal-4-is-pattern string-literal-1-is-pattern IMP-symbol-96-is-pattern BASIC-K-sort-0-is-pattern kore-element-var-V1-elementvariable typecode-cache-Pattern-0 in-sort-is-pattern top-is-pattern element-var-is-var typecode-cache-Pattern-156 and-is-pattern kore-exists-is-pattern typecode-cache-Pattern-35 substitution-disjoint typecode-cache-Pattern-39 kore-valid-is-pattern kore-element-var-x0-elementvariable typecode-cache-Pattern-37 kore-equals-is-pattern rule-and-intro-alt2-sugar rule-imp-transitivity typecode-cache-Pattern-159 kore-element-var-Val-elementvariable typecode-cache-Pattern-25 IMP-symbol-96-sorting top-intro rule-weakening typecode-cache-Pattern-161 substitution-var-same substitution-imp sorting-cache-537 sorting-cache-1284 sorting-cache-1277 imp-is-pattern proof-rule-prop-1 KSEQ-symbol-1-sorting proof-rule-mp KSEQ-symbol-0-sorting typecode-cache-Pattern-31 eq-is-pattern exists-is-pattern sorting-cache-91 sorting-cache-92 sorting-rearrange-843 kore-functional sorting-rearrange-273 substitution-in-sort substitution-and typecode-cache-Pattern-158 KSEQ-symbol-0-substitution substitution-kore-equals substitution-kore-exists-alt substitution-kore-valid substitution-474 substitution-479 functional-substitution-alt ) ACUKACUKQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDJUHUIULULAUGUEAUGUEAUGBUPQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDCUNPUTBUMUQACUKACUKQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDJUHUIULACVLACUKQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDJUHUIACUKQJDREIGIUCEFHSFOPUEUHQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUEUHULQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDJUHACUKQJDREIGIUCEFHSFOPUEUHQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUEUHACVMACUKQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFJUHOUEUHULQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUEUHACUKQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFJUHOUEUHACVNOUEUHACUKOUEUHVOOUEUHACUKVPVQVRVAQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOVSVBVAQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPVFVBACUKUIVGVHVAVAQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDAUGUEAUGABUFCVCBUMUQAUGUEAUGUEAUGBUPQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDCUNPUTBUMUQAUGUEAUGABCURVIBUMUQACUKUFUSJUHUIULQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDJUHUIULURVEJUHUIULVDUFURACUKUIVDVTQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDWAVDWBACUKUIVGVHJQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUIVDUIQJDREIGIUCEFHSFOPUEUHQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUEUHULQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDJUHUIQJDREIGIUCEFHSFOPUEUHQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUEUHWCWDVAQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPVFVBVDWEWFVBABUFCWGQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDJUHUIULAUGUEAUGUEAUGBUPQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDCUNPUTBUMUQUFUSJUHUIULAUGUEAUGABUFCVCBUMUQUFUJQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDJUHUIUFUSJUHUIUFUJQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDJUFUSJUFUJQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJVJJQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJUOWHUIQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJUOWIAUGUEAUGUEAUGBUPQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDCUNPUTBUMAUGUEAUGABUFCVCBUMQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJAUGQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJUOUEAUGUEAUGBUPQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDCUNPUTUEAUGABUFCVCQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDBUFUJUEQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJUOAUGQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJUOUEAUGBUPQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDCUNPUEAUGBUPUFCWJQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJUEQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJUOAUGQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJUOBUPQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJUOUFUJQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDCUNUFUSCUNQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJVJCUNQJDREIGIUCEFHSFOPQJDKEDGDKEFDGDLEFTHDMEDGDMEFDGDLEFUAHNDREIGIUBEFHNSFOPUDUFUJUOWKWLWMWNVKURVEURVEJUHUIULAUGUEAUGABCURVIBUMUQUFUSJUHUIULAUGUEAUGABUFCVCBUMUQUFUJUFURWOABUFCURWPVKWQVB $. $}
