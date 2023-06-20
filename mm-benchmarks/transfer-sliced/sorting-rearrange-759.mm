$c "amount" \kore-sort-SortBExp \top "balanceSender" \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-symbol-kseq #Variable \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-forall \and \kore-and \kore-sort-SortKResult #SetVariable \kore-top #ElementVariable #Symbol #Pattern \kore-exists \is-predicate \kore-not \kore-sort-SortKItem \kore-in \kore-inj \in-sort \kore-symbol-dotk ( $.
$v kore-sort-var-R ph0 ph2 x th0 kore-element-var-VE2 ptn1 y ph3 ptn0 ph1 $.
$d y kore-element-var-VE2 $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-sort-var-R kore-element-var-VE2 $.
$d y kore-sort-var-R $.
$d kore-element-var-VE2 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-not-is-pattern $a #Pattern ( \kore-not ph0 ph1 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ rule-predicate-intro-and.0 $e |- ( \is-predicate ph0 ) $.
   rule-predicate-intro-and.1 $e |- ( \is-predicate ph1 ) $.
   rule-predicate-intro-and $a |- ( \is-predicate ( \and ph0 ph1 ) ) $. $}
predicate-intro-top $a |- ( \is-predicate \top ) $.
${ $d x ph0 $.
   kore-is-sort-is-predicate $a |- ( \is-predicate ( \kore-is-sort ph0 ) ) $. $}
${ $d x ph0 $.
   $d x th0 $.
   $d y x $.
   $d y ph0 $.
   $d y ph1 $.
   $d y ph2 $.
   kore-forall-not-to-exists.0 $e |- ( \is-predicate th0 ) $.
   kore-forall-not-to-exists.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
   kore-forall-not-to-exists.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-forall ph1 ph0 x ( \kore-not ph0 ph2 ) ) ) ) $.
   kore-forall-not-to-exists $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-not ph0 ( \kore-exists ph1 ph0 x ph2 ) ) ) ) $. $}
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
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
sorting-rearrange-758 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-forall \kore-sort-SortKResult kore-sort-var-R kore-element-var-VE2 ( \kore-not kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) ) ) $.
sorting-cache-1220 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \in-sort ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) kore-sort-var-R ) ) $.
${ sorting-rearrange-759 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-not kore-sort-var-R ( \kore-exists \kore-sort-SortKResult kore-sort-var-R kore-element-var-VE2 ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) ) ) $= ( typecode-cache-Pattern-0 top-is-pattern and-is-pattern kore-is-sort-is-pattern IMP-sort-17-is-pattern kore-inj-is-pattern IMP-sort-28-is-pattern kore-top-is-pattern BASIC-K-sort-1-is-pattern IMP-sort-13-is-pattern kore-dv-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern kore-and-is-pattern rule-predicate-intro-and predicate-intro-top BASIC-K-sort-0-is-pattern IMP-sort-22-is-pattern string-literal-14-is-pattern string-literal-10-is-pattern IMP-symbol-192-is-pattern typecode-cache-Pattern-177 kore-in-is-pattern sorting-cache-133 rule-and-intro-alt2-sugar kore-is-sort-is-predicate kore-exists-is-pattern kore-not-is-pattern kore-valid-is-pattern top-intro rule-weakening sorting-cache-1220 sorting-rearrange-758 kore-forall-not-to-exists rule-imp-transitivity ) ACFDEACFDEACFDEDEEACACIACACACJACSACTKGLGUAMHGLGUBMHUCHNOIKBUDHNOUEACJPPBUIUJUKACFDEACFDEACFDEDEAUFACFDEACFDEDAUFACFDEDULUMUGUGACIACACJACSACTKGLGUAMHGLGUBMHUCHNOIKBUDHNOUEACJPPACFDEACFDEDEEBACFDEACFDEDEACFDACUHRQACFDEDACFDACUHRQRQQABUNABUOUPUQ $. $}
