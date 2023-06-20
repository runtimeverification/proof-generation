$c "1" #Substitution \top \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-symbol-kseq \kore-sort-SortK \imp "0" ) #SetVariable #Symbol #Pattern "ret" \kore-inj \kore-sort-SortInt "balanceTo" ( \exists "amount" "balanceSender" \kore-sort-SortStmt #Variable \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt "200" \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid \kore-equals \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \and \unit-sort #ElementVariable \eq \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block \kore-exists \kore-sort-SortKItem \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \kore-symbol-dotk $.
$v kore-element-var-V0 z sg0 th2 th0 ph6 kore-sort-var-x0 th1 ptn2 ph8 ph3 ptn0 ph1 th3 kore-sort-var-R ph0 ph2 xX x ptn1 y ph7 ph4 ph5 $.
$d kore-element-var-V0 z $.
$d y z $.
$d kore-element-var-V0 x $.
$d kore-sort-var-R kore-sort-var-x0 $.
$d kore-sort-var-R kore-element-var-V0 $.
$d z x $.
$d kore-element-var-V0 kore-sort-var-x0 $.
$d z kore-sort-var-x0 $.
$d kore-sort-var-R x $.
$d y x $.
$d y kore-sort-var-x0 $.
$d x kore-sort-var-x0 $.
$d kore-sort-var-R z $.
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
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
ptn2-pattern $f #Pattern ptn2 $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-192-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-204-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ptn0 ptn1 ) $.
IMP-symbol-241-is-pattern $a #Pattern ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) $.
IMP-symbol-354-is-pattern $a #Pattern ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ptn0 ) $.
kore-sort-var-x0-elementvariable $f #ElementVariable kore-sort-var-x0 $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-4-is-pattern $a #Pattern "1" $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-15-is-pattern $a #Pattern "200" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-14 $a #Pattern kore-sort-var-x0 $.
typecode-cache-Pattern-22 $a #Pattern ( \eq x \unit-sort ) $.
sorting-cache-129 $a |- ( \imp \top ( \and ( \kore-is-sort \unit-sort ) \top ) ) $.
sorting-cache-136 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
substitution-83 $a #Substitution ( \and ( \kore-is-sort \unit-sort ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \unit-sort kore-sort-var-R $.
substitution-87 $a #Substitution ( \and ( \kore-is-sort kore-sort-var-x0 ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) kore-sort-var-x0 kore-sort-var-R $.
typecode-cache-Pattern-39 $a #Pattern kore-element-var-V0 $.
substitution-427 $a #Substitution kore-element-var-V0 kore-element-var-V0 \unit-sort kore-sort-var-R $.
substitution-428 $a #Substitution kore-element-var-V0 kore-element-var-V0 kore-sort-var-x0 kore-sort-var-R $.
substitution-480 $a #Substitution \kore-sort-SortK \kore-sort-SortK \unit-sort kore-sort-var-R $.
substitution-483 $a #Substitution \kore-sort-SortK \kore-sort-SortK kore-sort-var-x0 kore-sort-var-R $.
sorting-rearrange-485 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) \kore-symbol-dotk ) ) ) ) ) ) $.
${ sorting-rearrange-486 $p |- ( \imp \top ( \kore-valid \unit-sort ( \kore-exists \kore-sort-SortK \unit-sort kore-element-var-V0 ( \kore-equals \kore-sort-SortK \unit-sort kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "200" ) ) ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-symbol-Lbl'LBraUndsRBraUnds'IMP-SYNTAX'Unds'Block'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsUndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'Stmt'Unds'Stmt ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) ) ) ) \kore-symbol-dotk ) ) ) ) ) ) $= ( IMP-sort-17-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-13-is-pattern IMP-sort-23-is-pattern IMP-symbol-185-is-pattern string-literal-17-is-pattern string-literal-14-is-pattern string-literal-10-is-pattern kore-sort-var-R-elementvariable IMP-sort-31-is-pattern BASIC-K-sort-1-is-pattern string-literal-11-is-pattern IMP-symbol-354-is-pattern IMP-symbol-204-is-pattern KSEQ-symbol-0-is-pattern BASIC-K-sort-0-is-pattern typecode-cache-Pattern-0 unit-sort-is-symbol symbol-is-pattern kore-sort-var-x0-elementvariable top-is-pattern string-literal-15-is-pattern IMP-symbol-192-is-pattern string-literal-1-is-pattern IMP-symbol-164-is-pattern IMP-symbol-160-is-pattern string-literal-4-is-pattern IMP-symbol-241-is-pattern KSEQ-symbol-1-is-pattern typecode-cache-Pattern-14 typecode-cache-Pattern-39 and-is-pattern kore-equals-is-pattern element-var-is-var kore-is-sort-is-pattern kore-exists-is-pattern kore-valid-is-pattern substitution-var-same x-is-element-var rule-weakening top-intro rule-and-intro-alt2-sugar rule-imp-transitivity substitution-480 substitution-disjoint substitution-kore-equals substitution-kore-exists-alt substitution-kore-valid substitution-imp substitution-483 sorting-cache-129 typecode-cache-Pattern-22 exists-is-pattern unit-sort-is-functional sorting-cache-136 sorting-rearrange-485 substitution-83 substitution-427 substitution-87 substitution-428 functional-substitution-alt ) UCUCTUAUQUCUNUNTUARTUARTUAAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURUSUCUCTUAUQUCUNUCUCVCVBVMVDTUAKSRKSRKSAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURUSTUARTUARTUAAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURUSUBULRUBULRUBULAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURUSUCKSUQUCUNTUAUQUCUNUBULUQUCUNVAKUBUCVAVNVAVOVAVPVBUCKSUQUCUNUNKSUQUCUNKSRKSRKSAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURUSUCKSUQUCUNUNKSUQUCKVQUCKSUQUCUNUNUCVCVBVDKAVRVETUATUAUQUCUNTUARTUARTUAAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURUSKSUQUCUNKSRKSRKSAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURUSKUPKVSTUARTUARTUAAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURKSRKSRKSAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURTUAKUPTUAKUPUTRTUARTUAAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUORKSRKSAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOTUAAKUPKVFTUAKUPUTRTUAAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQRKSAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQTUAKUPKVFTUAKUPUTKAVTLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQTUAKUPVGVHVIVJVKUBULUBULUQUCUNUBULRUBULRUBULAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURUSKSUQUCUNKSRKSRKSAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURUSKUPKUBWAUBULRUBULRUBULAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURKSRKSRKSAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOAURUBULKUPUBULKUPUTRUBULRUBULAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUORKSRKSAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUOUBULAKUPKUBVLUBULKUPUTRUBULAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQRKSAUMLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUBULKUPKUBVLUBULKUPUTKAUBWBLMBHCFEFUDCDGDLMBEBICDBEBJCDUEBNCFEFUFCDGOBJCBEBJCDBEBICDUGGBHCBEBHCDBEBICDUHGPBNCFEFUICDGPOUJDUKQQUBULKUPVGVHVIVJVKWCVE $. $}
