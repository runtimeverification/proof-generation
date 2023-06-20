$c "amount" \top \kore-sort-SortAExp \kore-symbol-LblisKResult \kore-symbol-dotk \kore-symbol-kseq #Variable \kore-implies \kore-sort-SortBool \kore-bottom \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp "false" \and \kore-and \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Pattern \kore-exists \kore-or \kore-not \kore-sort-SortKItem \kore-in \kore-inj \in-sort \kore-top "balanceTo" ( $.
$v kore-sort-var-R ph0 ph2 x th0 kore-element-var-VE2 ptn1 ph3 ptn0 ph1 $.
$d kore-sort-var-R x $.
$d kore-sort-var-R kore-element-var-VE2 $.
$d kore-element-var-VE2 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
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
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-bottom-is-pattern $a #Pattern ( \kore-bottom ph0 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-not-is-pattern $a #Pattern ( \kore-not ph0 ph1 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-or-is-pattern $a #Pattern ( \kore-or ph0 ph1 ph2 ) $.
kore-implies-is-pattern $a #Pattern ( \kore-implies ph0 ph1 ph2 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-top-sorting $a |- ( \in-sort ( \kore-top ph0 ) ph0 ) $.
kore-not-sorting $a |- ( \in-sort ( \kore-not ph0 ph1 ) ph0 ) $.
kore-and-sorting $a |- ( \imp ( \and ( \in-sort ph1 ph0 ) ( \in-sort ph2 ph0 ) ) ( \in-sort ( \kore-and ph0 ph1 ph2 ) ph0 ) ) $.
kore-in-sorting $a |- ( \in-sort ( \kore-in ph0 ph1 ph2 ph3 ) ph1 ) $.
${ kore-mp-alt.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
   kore-mp-alt.1 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
   kore-mp-alt $a |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $. $}
${ kore-and-intro-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-and-intro-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
   kore-and-intro-alt.2 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
   kore-and-intro-alt.3 $e |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $.
   kore-and-intro-alt $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-and ph0 ph1 ph2 ) ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-271-is-pattern $a #Pattern ( \kore-symbol-LblisKResult ptn0 ) $.
string-literal-5-is-pattern $a #Pattern "false" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
sorting-rearrange-1322 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-not kore-sort-var-R ( \kore-or kore-sort-var-R ( \kore-exists \kore-sort-SortKResult kore-sort-var-R kore-element-var-VE2 ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ( \kore-bottom kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "false" ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $.
sorting-rearrange-1330 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-not kore-sort-var-R ( \kore-or kore-sort-var-R ( \kore-exists \kore-sort-SortKResult kore-sort-var-R kore-element-var-VE2 ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ( \kore-bottom kore-sort-var-R ) ) ) ) ) $.
sorting-rearrange-1332 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $.
${ sorting-rearrange-1333 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "false" ) ) ( \kore-top kore-sort-var-R ) ) ) ) $= ( typecode-cache-Pattern-0 IMP-sort-17-is-pattern and-is-pattern kore-inj-is-pattern top-is-pattern IMP-sort-13-is-pattern kore-is-sort-is-pattern kore-dv-is-pattern BASIC-K-sort-1-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern kore-top-is-pattern string-literal-17-is-pattern string-literal-14-is-pattern IMP-symbol-160-is-pattern kore-and-is-pattern BASIC-K-sort-0-is-pattern kore-in-is-pattern kore-element-var-VE2-elementvariable in-sort-is-pattern IMP-sort-28-is-pattern typecode-cache-Pattern-177 kore-exists-is-pattern kore-bottom-is-pattern kore-or-is-pattern rule-imp-transitivity rule-and-intro-alt2-sugar kore-not-is-pattern IMP-sort-32-is-pattern kore-valid-is-pattern sorting-cache-133 and-elim-left-sugar imp-is-pattern proof-rule-prop-1 proof-rule-mp IMP-symbol-271-is-pattern string-literal-5-is-pattern kore-equals-is-pattern top-intro rule-weakening kore-top-sorting kore-and-sorting kore-implies-is-pattern imp-reflexivity sorting-rearrange-1322 kore-not-sorting kore-in-sorting sorting-rearrange-1330 sorting-rearrange-1332 kore-and-intro-alt kore-mp-alt ) ABHFDABHFDABHFDABHFDFDDDABABUJABGJCGCNIECGCOIEPEKLUQUJURIUSABMQUKABHFDABHFDABHFDABHFDFDDAULABHFDABHFDABHFDFDAULABHFDABHFDFAULABHFDFUTVAUHUHUHABABABABUBABABABMABRABGJCGCNIECGCOIEPEKLUBJTUCEKLSABMQQTUDABUEUFUIABABMABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQQQABUJABGJCGCNIECGCOIEPEKLUQUJURIUSABMQABHFDABHFDABHFDFDDDABHFDABHFDABHFDFDDDABHFDABABABABABUBABABABMABRABGJCGCNIECGCOIEPEKLUBJTUCEKLSABMQQTUDABUEUFUIABABMABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQQQABUJABGJCGCNIECGCOIEPEKLUQUJURIUSABMQVDUKABHFDABHFDABHFDFDDDABHFABHFDABHFDABHFDFDDDABHFDABHABHFDABHFDABHFDFDDUMABHFDABHABHABHFUMABHVEUGUGABHFDABHFDABHFDFDDDFUTVAUHATVFUGABHFDABHFDABHFDFDDDABHFDABABABABUBABABABMABRABGJCGCNIECGCOIEPEKLUBJTUCEKLSABMQQTUDABUEUFUIABABMABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQQQUKABHFDABHFDABHFDFDDUMABHFDABHFDABHFDABHFDFDDDABABABABUBABABABMABRABGJCGCNIECGCOIEPEKLUBJTUCEKLSABMQQTUDABUEUFUIABABMABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQQQUKABHFDABHFDABHFDABHFDFDDAULABHFDABHFDABHFDFDAULABHFDABHFDFAULABHFDFUTVAUHUHUHABABABUBABABABMABRABGJCGCNIECGCOIEPEKLUBJTUCEKLSABMQQTUDABUEUFUIABABMABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQQABHFDABHFDABHFDFDDDABABUBABABABMABRABGJCGCNIECGCOIEPEKLUBJTUCEKLSABMQQTUDABUEUFUIABUAABHFDABHFDABHFDFDDDABABUBABABABMABRABGJCGCNIECGCOIEPEKLUBJTUCEKLSABMQQTUDABUEUFUIABUAUNABABUBABABABMABRABGJCGCNIECGCOIEPEKLUBJTUCEKLSABMQQTUDABUEUFUIABUAABHFDABHFDABHFDFDDDUOABABUBABABABMABRABGJCGCNIECGCOIEPEKLUBJTUCEKLSABMQQTUDABUEUFVGUPABHFDABHFDABHFDFDDDABMABUAABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQABUADABABMABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQQABUAABHFDABHFDABHFDFDDDABMABUAABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQABUAABMABUAABHFDABHFDABHFDFDDDABMABUAUNABMABUAABHFDABHFDABHFDFDDDUOABVBUPABHFDABHFDABHFDFDDDRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABUAABMABUADABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQABUAABHFDABHFDABHFDFDDDRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABUAABMABUARABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABUAABHFDABHFDABHFDFDDDRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABUAUNRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABUAABHFDABHFDABHFDFDDDUORABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLVHUPABMABUAABHFDABHFDABHFDFDDDABMABUAUNABMABUAABHFDABHFDABHFDFDDDUOABVBUPUHABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMVCUGUHABABMABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQVCUGABHFDABHFDABHFDFDDDABHFDABABABUBABABABMABRABGJCGCNIECGCOIEPEKLUBJTUCEKLSABMQQTUDABUEUFUIUKABHFDABHFDABHFDFDDUMATVIUGABHFDABHFDABHFDFDDDABHFDABABABMABRABGJCGCNIECGCOIEPEKLGJCGCNIECGCOIEPEKLSABMQQUKABHFDABHFDABHFDFDDUMAVJUGVKUGUGVLUG $. $}
