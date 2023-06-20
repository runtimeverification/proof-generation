$c "1" #Substitution \top \kore-sort-SortAExp \kore-symbol-kseq \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' \kore-sort-SortK \imp "0" ) \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' #SetVariable #Symbol #Pattern "ret" \kore-inj \kore-sort-SortInt \in-sort "balanceTo" ( \exists "amount" "balanceSender" #Variable "10" \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid \kore-equals \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \and \unit-sort #ElementVariable \eq \kore-sort-SortBlock \kore-exists \kore-sort-SortKItem \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \kore-symbol-dotk $.
$v kore-element-var-V0 xX0 z th2 th0 ph6 kore-element-var-x0 th1 ptn3 ptn2 ph8 ph3 ptn0 ph1 th3 kore-sort-var-R ph0 ph2 kore-element-var-V2 xX x ptn4 ptn1 y ph7 ph4 ph5 $.
$d kore-element-var-V0 z $.
$d y z $.
$d kore-element-var-V0 x $.
$d kore-sort-var-R kore-element-var-V2 $.
$d kore-sort-var-R kore-element-var-V0 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-V0 $.
$d kore-element-var-V2 x $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-V2 $.
$d kore-element-var-x0 z $.
$d kore-element-var-V2 kore-element-var-V0 $.
$d kore-sort-var-R z $.
$d kore-element-var-x0 kore-element-var-V2 $.
$d kore-element-var-V2 z $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-95-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ptn0 ) $.
IMP-symbol-96-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ptn0 ptn1 ) $.
IMP-symbol-96-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortK ) ( \in-sort ptn1 \kore-sort-SortK ) ) ( \in-sort ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ptn0 ptn1 ) \kore-sort-SortKItem ) ) $.
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-204-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) $.
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-4-is-pattern $a #Pattern "1" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
sorting-cache-43 $a |- ( \imp \top ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) $.
sorting-cache-91 $a |- ( \imp \top ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
sorting-cache-92 $a |- ( \imp \top ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
typecode-cache-Pattern-35 $a #Pattern kore-element-var-V2 $.
typecode-cache-Pattern-39 $a #Pattern kore-element-var-V0 $.
substitution-421 $a #Substitution kore-sort-var-R kore-sort-var-R kore-element-var-x0 kore-element-var-V2 $.
typecode-cache-Pattern-156 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
sorting-cache-568 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ) $.
substitution-490 $a #Substitution \kore-sort-SortK \kore-sort-SortK kore-element-var-x0 kore-element-var-V2 $.
substitution-492 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortK ) \top ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) kore-element-var-x0 kore-element-var-V2 $.
sorting-cache-569 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) $.
sorting-cache-1283 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) \kore-sort-SortKItem ) ) $.
sorting-rearrange-846 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortK \unit-sort kore-element-var-V0 ( \kore-equals \kore-sort-SortK \unit-sort kore-element-var-V0 ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) \kore-symbol-dotk ) ) \kore-symbol-dotk ) ) ) ) ) $.
sorting-cache-1392 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
typecode-cache-Pattern-343 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-symbol-dotk ) ) kore-element-var-V2 ) ) $.
sorting-rearrange-1009 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-symbol-dotk ) ) kore-element-var-V2 ) ) ) ) ) $.
typecode-cache-Pattern-344 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-symbol-dotk ) ) kore-element-var-x0 ) ) $.
substitution-976 $a #Substitution ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-symbol-dotk ) ) kore-element-var-x0 ) ) ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-symbol-dotk ) ) kore-element-var-V2 ) ) kore-element-var-x0 kore-element-var-V2 $.
${ sorting-rearrange-1010 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezerif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) \kore-symbol-dotk ) ) \kore-symbol-dotk ) ) ) ) ) ) $= ( IMP-sort-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-13-is-pattern IMP-sort-23-is-pattern IMP-symbol-185-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern BASIC-K-sort-1-is-pattern string-literal-10-is-pattern string-literal-14-is-pattern string-literal-17-is-pattern IMP-symbol-204-is-pattern IMP-sort-18-is-pattern string-literal-11-is-pattern IMP-symbol-354-is-pattern BASIC-K-sort-0-is-pattern typecode-cache-Pattern-0 IMP-symbol-164-is-pattern IMP-symbol-160-is-pattern string-literal-4-is-pattern string-literal-1-is-pattern kore-element-var-V2-elementvariable IMP-symbol-96-is-pattern top-is-pattern in-sort-is-pattern and-is-pattern element-var-is-var kore-is-sort-is-pattern kore-element-var-x0-elementvariable kore-exists-is-pattern string-literal-13-is-pattern IMP-symbol-95-is-pattern typecode-cache-Pattern-39 kore-valid-is-pattern substitution-disjoint rule-imp-transitivity typecode-cache-Pattern-343 typecode-cache-Pattern-35 rule-and-intro-alt2-sugar kore-equals-is-pattern typecode-cache-Pattern-25 typecode-cache-Pattern-344 KSEQ-symbol-0-sorting sorting-cache-569 IMP-symbol-96-sorting top-intro rule-weakening substitution-var-same substitution-kore-exists-alt substitution-kore-valid substitution-imp substitution-421 sorting-cache-133 sorting-cache-1392 sorting-cache-1283 eq-is-pattern exists-is-pattern sorting-cache-91 sorting-cache-92 sorting-cache-43 sorting-rearrange-846 kore-functional typecode-cache-Pattern-156 sorting-cache-568 sorting-rearrange-1009 substitution-in-sort substitution-and KSEQ-symbol-0-substitution substitution-kore-equals substitution-492 substitution-490 substitution-976 functional-substitution-alt ) ATUKUGUIATUKUGUIPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJSUHUGUIUIATSATSATBUPGKGUNDEIJUOPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJJVCBUMUQATUKUGUIATUKUGUIPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJSUHUGUIAVPATUKUGUIPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJSUHUGATUKUGUIPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFKUHISUHUIPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJSUHATUKUGUIPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFKUHISUHATUKUGUIPKCQDGFGUDDEHREIJSUHPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJSUHUIPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFKUHATUKUGUIPKCQDGFGUDDEHREIJSUHPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJSUHAVQATUKUGUIPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREKUHISUHUIPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJSUHATUKUGUIPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREKUHISUHAVRAVGVBPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIVFUSVBPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJVHUSAVGVBPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIVFUSATUKUGUIUGVIVJVBVBPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJATSATABUEUTBUMUQATSATSATBUPGKGUNDEIJUOPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJJVCBUMUQATSATABULVEBUMUQATUKUGUIUEVASUHUGUIPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJSUHUGUIULVDSUHUGUIBUEULATUKUGUIUGBUPPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJVSBVTATUKUGUIUGVIVJSPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUGBUGPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFKUHISUHUIPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJSUHUGPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFKUHISUHUGPKCQDGFGUDDEHREIJSUHPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJSUHUIPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFKUHUGPKCQDGFGUDDEHREIJSUHPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJSUHWAWBVBPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJVHUSWCVBPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIVFUSBWDWEUSATUKUGUIUEVASUHUGUIUIAUEWFATSATABUEUTBUMUQAUEWGABUEWHUSPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJSUHUGUIATSATSATBUPGKGUNDEIJUOPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJJVCBUMUQUEVASUHUGUIATSATABUEUTBUMUQUEUJPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJSUHUGUEVASUHUGUEUJPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJSUEVASUEUJPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJVKSPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJURWIUGPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJURWJATSATSATBUPGKGUNDEIJUOPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJJVCBUMATSATABUEUTBUMPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJATPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJURSATSATBUPGKGUNDEIJUOPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJJVCSATABUEUTPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJBUEUJSPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJURATPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJURSATBUPGKGUNDEIJUOPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJJSATBUPGKGUNDEIJUOUEVAJPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJSPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJURATPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJURBUPPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJURUEUJPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJGKGUNDEIJUOPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJGKGUNDEIJUOUEVAGKGUNDEIJUOPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJURPKCQDGFGUDDEHREIJPKCLDCFCLDECFCMDEUAHCNDCFCNDECFCMDEUBHOCQDGFGUCDEHOREIJUFIJUEUJVKWKWLVLVMVNULVDULVDSUHUGUIATSATABULVEBUMUQUEVASUHUGUIATSATABUEUTBUMUQUEUJUEULWMATSATABULVEBUMATSATABUEUTBUMULVDUEUJAUEULVOSATABULVESATABUEUTULVDBUEUJUEULWNAUEULVOABUEULWOVLVMVNWPUS $. $}
