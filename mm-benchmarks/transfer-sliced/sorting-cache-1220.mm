$c "amount" \kore-sort-SortBExp \top "balanceSender" \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-symbol-kseq #Variable \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-sort-SortId ) \and \kore-and \kore-sort-SortKResult #SetVariable \kore-top #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-in \kore-inj \in-sort \kore-symbol-dotk ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-VE2 ptn1 ph3 ptn0 ph1 $.
$d kore-sort-var-R kore-element-var-VE2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-top-sorting $a |- ( \in-sort ( \kore-top ph0 ) ph0 ) $.
kore-and-sorting $a |- ( \imp ( \and ( \in-sort ph1 ph0 ) ( \in-sort ph2 ph0 ) ) ( \in-sort ( \kore-and ph0 ph1 ph2 ) ph0 ) ) $.
kore-in-sorting $a |- ( \in-sort ( \kore-in ph0 ph1 ph2 ph3 ) ph1 ) $.
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
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
IMP-symbol-192-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
${ sorting-cache-1220 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \in-sort ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) kore-sort-var-R ) ) $= ( typecode-cache-Pattern-0 IMP-sort-17-is-pattern kore-inj-is-pattern and-is-pattern top-is-pattern BASIC-K-sort-1-is-pattern IMP-sort-13-is-pattern kore-dv-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern kore-is-sort-is-pattern in-sort-is-pattern kore-top-is-pattern BASIC-K-sort-0-is-pattern IMP-sort-22-is-pattern string-literal-14-is-pattern string-literal-10-is-pattern IMP-symbol-192-is-pattern IMP-sort-28-is-pattern typecode-cache-Pattern-177 kore-in-is-pattern kore-and-is-pattern imp-is-pattern proof-rule-prop-1 proof-rule-mp kore-top-sorting rule-and-intro-alt2-sugar kore-and-sorting rule-imp-transitivity kore-in-sorting ) ACMGFACMGFGFFACOACNACPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACOUDACNFACACOACPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACOUDUDACNACMGFACMGFGFFACOACNACPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACOUDACNACOACNACMGFACMGFGFFACOACNUEACOACNACMGFACMGFGFFUFACUHUGACMGFACMGFGFFPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACNACOACNFACPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACOUDACNACMGFACMGFGFFPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACNACOACNPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACNACMGFACMGFGFFPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACNUEPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACNACMGFACMGFGFFUFPACQHDIDRJEDIDSJETEKLUAHBUBEKLULUGACOACNACMGFACMGFGFFACOACNUEACOACNACMGFACMGFGFFUFACUHUGUIACPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACOUJUKUIACACOACPACQHDIDRJEDIDSJETEKLUAHBUBEKLUCACOUDUJUK $. $}
