$c "amount" \top "balanceSender" \kore-sort-SortAExp \kore-symbol-LblisKResult \kore-symbol-kseq #Variable \kore-sort-SortBool \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals "false" \and \kore-and #SetVariable \kore-top #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-inj \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \in-sort \kore-symbol-dotk ( $.
$v kore-sort-var-R ph0 ph2 th0 ptn1 ph3 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
th0-is-pattern $f #Pattern th0 $.
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
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-equals-sorting $a |- ( \in-sort ( \kore-equals ph0 ph1 ph2 ph3 ) ph1 ) $.
${ kore-anp-top.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-and-top.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-and ph0 ph1 ( \kore-top ph0 ) ) ) ) $.
   kore-anp-top $a |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $. $}
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-164-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-271-is-pattern $a #Pattern ( \kore-symbol-LblisKResult ptn0 ) $.
string-literal-5-is-pattern $a #Pattern "false" $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
sorting-rearrange-1184 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "false" ) ) ( \kore-top kore-sort-var-R ) ) ) ) $.
${ sorting-rearrange-1185 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "false" ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern IMP-sort-17-is-pattern IMP-sort-13-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-sort-32-is-pattern BASIC-K-sort-1-is-pattern string-literal-10-is-pattern string-literal-14-is-pattern IMP-symbol-164-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern IMP-symbol-271-is-pattern string-literal-5-is-pattern kore-equals-is-pattern rule-imp-transitivity rule-and-intro-alt2-sugar in-sort-is-pattern kore-valid-is-pattern sorting-cache-133 top-intro rule-weakening and-elim-left-sugar imp-is-pattern proof-rule-prop-1 kore-equals-sorting proof-rule-mp kore-top-is-pattern kore-and-is-pattern imp-reflexivity sorting-rearrange-1184 kore-anp-top ) ABEDCABEDCABEDCDCCABJABGKFGFLHIFGFMHINIOPQJRHSUCABEDCABEDCABEDCDCAUDABEDCABEDCDAUDABEDCDUEUFUAUAABJABGKFGFLHIFGFMHINIOPQJRHSABEDCABEDCDCCJABGKFGFLHIFGFMHINIOPQJRHSABUBABEDCABEDCDCCJABGKFGFLHIFGFMHINIOPQJRHSABUBUHJABGKFGFLHIFGFMHINIOPQJRHSABUBABEDCABEDCDCCUIJABGKFGFLHIFGFMHINIOPQJRHUJUKABEDCABEDCDCCABEDCABABJABGKFGFLHIFGFMHINIOPQJRHSABULUMUCABEDCABEDCDCCABEDABEDCABEDCDCCABEDCABEABEDCABEDCDCUGABEDCABEABEABEDUGABEUNTTABEDCABEDCDCCDUEUFUAAUOTUPT $. $}
