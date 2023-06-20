$c "amount" \top \kore-sort-SortAExp \kore-symbol-dotk \kore-symbol-kseq #Variable \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \and \kore-and #SetVariable #ElementVariable #Symbol #Pattern \is-predicate \kore-sort-SortKItem \kore-in \kore-inj \in-sort \kore-top "balanceTo" ( $.
$v kore-sort-var-R ph0 ph2 x th0 ptn1 ph3 ptn0 ph1 $.
$d kore-sort-var-R x $.
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
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ rule-predicate-intro-and.0 $e |- ( \is-predicate ph0 ) $.
   rule-predicate-intro-and.1 $e |- ( \is-predicate ph1 ) $.
   rule-predicate-intro-and $a |- ( \is-predicate ( \and ph0 ph1 ) ) $. $}
predicate-intro-top $a |- ( \is-predicate \top ) $.
kore-top-sorting $a |- ( \in-sort ( \kore-top ph0 ) ph0 ) $.
kore-in-sorting $a |- ( \in-sort ( \kore-in ph0 ph1 ph2 ph3 ) ph1 ) $.
kore-top-valid $a |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $.
${ kore-and-intro-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-and-intro-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
   kore-and-intro-alt.2 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
   kore-and-intro-alt.3 $e |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $.
   kore-and-intro-alt $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-and ph0 ph1 ph2 ) ) ) $. $}
${ $d x ph0 $.
   kore-is-sort-is-predicate $a |- ( \is-predicate ( \kore-is-sort ph0 ) ) $. $}
${ kore-in-reflexivity.0 $e |- ( \is-predicate th0 ) $.
   kore-in-reflexivity.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
   kore-in-reflexivity $a |- ( \imp th0 ( \kore-valid ph1 ( \kore-in ph0 ph1 ph2 ph2 ) ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-symbol-160-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
sorting-cache-2145 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
${ sorting-rearrange-1331 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceTo" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ) ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) $= ( and-is-pattern typecode-cache-Pattern-0 top-is-pattern kore-is-sort-is-pattern IMP-sort-17-is-pattern IMP-sort-13-is-pattern kore-inj-is-pattern kore-dv-is-pattern BASIC-K-sort-1-is-pattern string-literal-17-is-pattern string-literal-14-is-pattern IMP-symbol-160-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern BASIC-K-sort-0-is-pattern kore-in-is-pattern kore-top-is-pattern in-sort-is-pattern rule-imp-transitivity kore-valid-is-pattern rule-and-intro-alt2-sugar sorting-cache-133 rule-weakening top-intro and-elim-left-sugar imp-is-pattern proof-rule-prop-1 proof-rule-mp predicate-intro-top rule-predicate-intro-and kore-and-is-pattern kore-in-sorting kore-top-sorting imp-reflexivity kore-is-sort-is-predicate sorting-cache-2145 kore-in-reflexivity kore-top-valid kore-and-intro-alt ) ACEDBACEDBACEDBACEDBDBBBACACPACGJFGFKIHFGFLIHMHNOGJFGFKIHFGFLIHMHNOQACRULUAACEDBACEDBACEDBACEDBDBBAUCACEDBACEDBACEDBDBAUCACEDBACEDBDAUCACEDBDUEUDUBUBUBACPACGJFGFKIHFGFLIHMHNOGJFGFKIHFGFLIHMHNOQACRACEDBACEDBACEDBDBBBPACGJFGFKIHFGFLIHMHNOGJFGFKIHFGFLIHMHNOQACSACEDBACEDBACEDBDBBBPACGJFGFKIHFGFLIHMHNOGJFGFKIHFGFLIHMHNOQACSUGPACGJFGFKIHFGFLIHMHNOGJFGFKIHFGFLIHMHNOQACSACEDBACEDBACEDBDBBBUHPACGJFGFKIHFGFLIHMHNOGJFGFKIHFGFLIHMHNOUMUIACRACSACEDBACEDBACEDBDBBBACRACSUGACRACSACEDBACEDBACEDBDBBBUHACUNUIACEDBACEDBACEDBDBBBACEDBACPACGJFGFKIHFGFLIHMHNOGJFGFKIHFGFLIHMHNOQUAACEDBACEDBACEDBDBBBACEDACEDBACEDBACEDBDBBBACEDBACEACEDBACEDBACEDBDBBUFACEDBACEACEACEDUFACEUOTTACEDBACEDBACEDBDBBBDUEUDUBACEDBACEDBDBACPACGJFGFKIHFGFLIHMHNOGJFGFKIHFGFLIHMHNOQUAACEDBACEDBDAUCACEDBDUEUDUBPACGJFGFKIHFGFLIHMHNOACEDBDBACEDBDACEDACUPUJUKUJUKAUQURTTACEDBACEDBACEDBDBBBACEDBACACRUAACEDBACEDBACEDBDBBUFACEDBACACRUAACUSUDTUTT $. $}
