$c "1" #Substitution "12345" \top \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-symbol-kseq \kore-sort-SortK \imp \kore-sort-SortPgm "0" ) #SetVariable #Symbol #Pattern \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids "ret" "100" \kore-inj \kore-sort-SortInt "addressTo" \in-sort "balanceTo" ( \exists "amount" \kore-sort-SortBExp "balanceSender" \kore-sort-SortStmt #Variable "10" \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt "200" \kore-sort-SortIds \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \kore-equals \and \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids \unit-sort #ElementVariable \eq \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block \kore-sort-SortBlock \kore-exists \kore-sort-SortKItem \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \kore-symbol-dotk $.
$v kore-element-var-V0 z kore-element-var-VE1 sg0 th2 th0 ph6 kore-sort-var-x0 th1 ptn2 ph8 ph3 ptn0 ph1 th3 kore-sort-var-R ph0 ph2 xX x ptn1 y ph7 ph4 ph5 $.
$d kore-element-var-V0 z $.
$d y z $.
$d kore-element-var-V0 x $.
$d kore-sort-var-R kore-sort-var-x0 $.
$d kore-sort-var-R kore-element-var-VE1 $.
$d kore-sort-var-R kore-element-var-V0 $.
$d z x $.
$d x kore-element-var-VE1 $.
$d kore-element-var-V0 kore-sort-var-x0 $.
$d z kore-sort-var-x0 $.
$d kore-sort-var-R x $.
$d y x $.
$d z kore-element-var-VE1 $.
$d y kore-element-var-VE1 $.
$d y kore-sort-var-x0 $.
$d kore-element-var-V0 kore-element-var-VE1 $.
$d x kore-sort-var-x0 $.
$d kore-sort-var-R z $.
$d y kore-sort-var-R $.
$d kore-element-var-VE1 kore-sort-var-x0 $.
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
sg0-is-symbol $f #Symbol sg0 $.
element-var-is-var $a #Variable x $.
symbol-is-pattern $a #Pattern sg0 $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
unit-sort-is-symbol $a #Symbol \unit-sort $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
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
unit-sort-is-functional $a |- ( \exists x ( \eq x \unit-sort ) ) $.
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
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
ptn2-pattern $f #Pattern ptn2 $.
KSEQ-symbol-0-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKItem ) ( \in-sort ptn1 \kore-sort-SortK ) ) ( \in-sort ( \kore-symbol-kseq ptn0 ptn1 ) \kore-sort-SortK ) ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-0-is-pattern $a #Pattern \kore-sort-SortIds $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-27-is-pattern $a #Pattern \kore-sort-SortPgm $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-123-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids $.
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-161-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ptn0 ptn1 ) $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-192-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-204-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) $.
IMP-symbol-204-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortStmt ) ( \in-sort ptn1 \kore-sort-SortStmt ) ) ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) \kore-sort-SortStmt ) ) $.
IMP-symbol-241-is-pattern $a #Pattern ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) $.
IMP-symbol-241-sorting $a |- ( \imp ( \and ( \and ( \in-sort ptn0 \kore-sort-SortBExp ) ( \in-sort ptn1 \kore-sort-SortBlock ) ) ( \in-sort ptn2 \kore-sort-SortBlock ) ) ( \in-sort ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) \kore-sort-SortStmt ) ) $.
IMP-symbol-247-is-pattern $a #Pattern ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ptn0 ptn1 ) $.
IMP-symbol-247-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortIds ) ( \in-sort ptn1 \kore-sort-SortStmt ) ) ( \in-sort ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ptn0 ptn1 ) \kore-sort-SortPgm ) ) $.
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
IMP-symbol-354-sorting $a |- ( \imp ( \in-sort ptn0 \kore-sort-SortStmt ) ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) \kore-sort-SortBlock ) ) $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-4-is-pattern $a #Pattern "1" $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-12-is-pattern $a #Pattern "12345" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-15-is-pattern $a #Pattern "200" $.
string-literal-16-is-pattern $a #Pattern "100" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
string-literal-18-is-pattern $a #Pattern "addressTo" $.
sorting-cache-1 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortPgm ) ) $.
sorting-cache-2 $a |- ( \imp \top ( \kore-is-sort \kore-sort-SortKItem ) ) $.
sorting-cache-21 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-24 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-27 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-31 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) \kore-sort-SortBExp ) ) $.
sorting-cache-35 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) \kore-sort-SortBlock ) ) $.
sorting-cache-39 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-42 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) \kore-sort-SortStmt ) ) $.
sorting-cache-43 $a |- ( \imp \top ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
typecode-cache-Pattern-22 $a #Pattern ( \eq x \unit-sort ) $.
sorting-cache-129 $a |- ( \imp \top ( \and ( \kore-is-sort \unit-sort ) \top ) ) $.
sorting-cache-136 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
substitution-83 $a #Substitution ( \and ( \kore-is-sort \unit-sort ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \unit-sort kore-sort-var-R $.
substitution-87 $a #Substitution ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) kore-sort-var-x0 kore-sort-var-R $.
sorting-cache-257 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "ret" ) \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids ) ) ) ) ) \kore-sort-SortIds ) ) $.
typecode-cache-Pattern-39 $a #Pattern kore-element-var-V0 $.
substitution-427 $a #Substitution kore-element-var-V0 kore-element-var-V0 \unit-sort kore-sort-var-R $.
substitution-428 $a #Substitution kore-element-var-V0 kore-element-var-V0 kore-sort-var-x0 kore-sort-var-R $.
substitution-480 $a #Substitution \kore-sort-SortK \kore-sort-SortK \unit-sort kore-sort-var-R $.
substitution-483 $a #Substitution \kore-sort-SortK \kore-sort-SortK kore-sort-var-x0 kore-sort-var-R $.
sorting-rearrange-277 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "ret" ) \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids ) ) ) ) ) ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) ) ) \kore-symbol-dotk ) ) ) ) ) $.
typecode-cache-Pattern-165 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) $.
${ sorting-rearrange-278 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortPgm ) \top ) ) ( \exists kore-element-var-V0 ( \eq kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblint'UndsSClnUndsUnds'IMP-SYNTAX'Unds'Pgm'Unds'Ids'Unds'Stmt ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids ( \kore-dv \kore-sort-SortId "ret" ) \kore-symbol-Lbl'Stop'List'LBraQuotUndsCommUndsUnds'IMP-SYNTAX'Unds'Ids'Unds'Id'Unds'Ids'QuotRBraUnds'Ids ) ) ) ) ) ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "addressTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "12345" ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "amount" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "100" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) ) ) \kore-symbol-dotk ) ) ) ) $= ( IMP-sort-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-13-is-pattern IMP-sort-23-is-pattern IMP-symbol-185-is-pattern IMP-symbol-204-is-pattern string-literal-14-is-pattern string-literal-10-is-pattern string-literal-17-is-pattern IMP-symbol-161-is-pattern string-literal-11-is-pattern IMP-symbol-354-is-pattern string-literal-18-is-pattern IMP-symbol-164-is-pattern IMP-symbol-160-is-pattern string-literal-4-is-pattern string-literal-12-is-pattern string-literal-13-is-pattern string-literal-16-is-pattern top-is-pattern IMP-symbol-192-is-pattern string-literal-1-is-pattern string-literal-15-is-pattern in-sort-is-pattern IMP-symbol-241-is-pattern BASIC-K-sort-0-is-pattern IMP-sort-27-is-pattern BASIC-K-sort-1-is-pattern IMP-symbol-123-is-pattern IMP-symbol-247-is-pattern typecode-cache-Pattern-0 KSEQ-symbol-1-is-pattern and-is-pattern unit-sort-is-symbol symbol-is-pattern kore-sort-var-x0-elementvariable KSEQ-symbol-0-is-pattern IMP-sort-31-is-pattern typecode-cache-Pattern-39 typecode-cache-Pattern-14 kore-is-sort-is-pattern kore-equals-is-pattern element-var-is-var kore-exists-is-pattern rule-and-intro-alt2-sugar rule-imp-transitivity kore-valid-is-pattern IMP-sort-18-is-pattern substitution-var-same rule-weakening IMP-symbol-204-sorting x-is-element-var top-intro IMP-sort-22-is-pattern typecode-cache-Pattern-165 exists-is-pattern IMP-sort-0-is-pattern substitution-480 substitution-disjoint substitution-kore-equals substitution-kore-exists-alt substitution-kore-valid substitution-imp substitution-483 eq-is-pattern sorting-cache-1 sorting-cache-2 sorting-cache-257 sorting-cache-21 sorting-cache-24 sorting-cache-27 sorting-cache-31 sorting-cache-35 sorting-cache-39 sorting-cache-42 IMP-symbol-354-sorting IMP-symbol-241-sorting IMP-symbol-247-sorting INJ-symbol-0-sorting sorting-cache-43 KSEQ-symbol-0-sorting sorting-cache-129 typecode-cache-Pattern-22 unit-sort-is-functional sorting-cache-136 sorting-rearrange-277 substitution-83 substitution-427 substitution-87 substitution-428 functional-substitution-alt kore-functional ) ABVSUDCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAWICVTABVSUDVQVNUJUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAUDCUDUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFULUHUPUJUHUQUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAUJUHUDUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFULUHUPUJUHUDUKVEULVEUQDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNUKUHUQUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFULUHUDUKVEULVEUQDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNUKUHUDUKVEULVEWJWKVIUDDQEDKEDLEDMEDOEUMNNNNNWAUHDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJVBUHUQDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNUKUHUDDQEDKEDLEDMEDOEUMNNNNNWAUHDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJVBUHWLUDDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJVBUHDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIVBUHUQDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJVBUHUDDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJVBUHDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIVBUHUDDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJVBUHDMEHGHUGEFIVBUHUQDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJVBUHUDDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJVBUHDMEHGHUGEFIVBUHUDDQEHGHUAEFIDKEHGHUBEFIJVBUHDLEHGHUCEFIVBUHUQDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJVBUHUDDQEHGHUAEFIDKEHGHUBEFIJVBUHDLEHGHUCEFIVBUHWMWNVIDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIVOVJWOVIDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIVOVJUDDGDKEFDGDLEFUEVRUHDOEHGHUFEFIPVLUHUQDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPVLUHUQDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIVBUHUDDGDKEFDGDLEFUEVRUHDOEHGHUFEFIPVLUHUQDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPVLUHUDDGDKEFDGDLEFUEVRUHDOEHGHUFEFIPVLUHWPWQVIUDDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJVBUHDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPVLUHUDDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJVBUHDOEHGHTEFIVBUHUQDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJVBUHUDDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJVBUHDOEHGHTEFIVBUHWRWSVIDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIVOVJDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJWTVJVIDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPXAVJVIDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIVOVJVIDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJXBVJVIUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNXCVJXDVIUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPXEVJUDUDURUSVEUDUQUQURUSUJURUSUJURUSCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHVKUDUDURUSVEUDUQUDUDVQVNXFVIURUSAUOUJAUOUJAUOCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHVKURUSUJURUSUJURUSCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHVKUTVDUJUTVDUJUTVDCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHVKUDAUOVEUDUQURUSVEUDUQUTVDVEUDUQVPAUTUDVPXGVPVTVPXHVNUDAUOVEUDUQUQAUOVEUDUQAUOUJAUOUJAUOCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHVKUDAUOVEUDUQUQAUOVEUDAXIUDAUOVEUDUQUQUDVQVNVIACXJVJURUSURUSVEUDUQURUSUJURUSUJURUSCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHVKAUOVEUDUQAUOUJAUOUJAUOCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHVKAVGAXKURUSUJURUSUJURUSCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHAUOUJAUOUJAUOCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHURUSAVGURUSAVGVMUJURUSUJURUSCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFUJAUOUJAUOCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFURUSCAVGAWBURUSAVGVMUJURUSCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAUJAUOCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAURUSAVGAWBURUSAVGVMACXLUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAURUSAVGWCWDWEWFWGUTVDUTVDVEUDUQUTVDUJUTVDUJUTVDCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHVKAUOVEUDUQAUOUJAUOUJAUOCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHVKAVGAUTXMUTVDUJUTVDUJUTVDCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHAUOUJAUOUJAUOCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFCVHUTVDAVGUTVDAVGVMUJUTVDUJUTVDCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFUJAUOUJAUOCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAVFUTVDCAVGAUTWHUTVDAVGVMUJUTVDCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAUJAUOCVCUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAUTVDAVGAUTWHUTVDAVGVMACUTXNUKULDQEDKEDLEDMEDOEUMNNNNNDQEHGHUAEFIDKEHGHUBEFIJDLEHGHUCEFIJDMEHGHUGEFIJDGDKEFDGDLEFUEDOEHGHUFEFIPDLEDGDLEFDGDKEFRIDMEDGDMEFDGDKEFSIJDOEHGHTEFIJPUIJUNFUPVAUTVDAVGWCWDWEWFWGXOVJXPVJ $. $}
