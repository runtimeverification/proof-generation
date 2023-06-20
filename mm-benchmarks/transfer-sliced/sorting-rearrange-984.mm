$c \exists #Substitution \top "balanceSender" \kore-symbol-LblisKResult \kore-symbol-dotk \kore-symbol-kseq #Variable \kore-implies \kore-sort-SortBool \kore-bottom \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \kore-equals "false" \and \kore-and \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-or \kore-exists \kore-not \kore-sort-SortKItem \kore-in \kore-inj \in-sort \kore-top ( $.
$v kore-element-var-V0 xX0 z kore-element-var-VE1 th2 th0 kore-element-var-VE2 ph6 kore-element-var-x0 th1 ptn2 ph8 ph3 ptn0 ph1 th3 kore-sort-var-R ph0 ph2 xX x ptn1 y ph7 kore-element-var-VE0 ph4 ph5 $.
$d kore-element-var-V0 z $.
$d y z $.
$d kore-element-var-V0 x $.
$d y kore-element-var-VE2 $.
$d kore-sort-var-R kore-element-var-VE1 $.
$d kore-element-var-V0 kore-element-var-VE0 $.
$d kore-sort-var-R kore-element-var-V0 $.
$d z x $.
$d kore-sort-var-R kore-element-var-VE0 $.
$d kore-element-var-x0 kore-element-var-V0 $.
$d kore-element-var-VE2 kore-element-var-VE0 $.
$d z kore-element-var-VE0 $.
$d x kore-element-var-VE1 $.
$d z kore-element-var-VE2 $.
$d kore-element-var-VE0 kore-element-var-VE1 $.
$d kore-element-var-x0 kore-element-var-VE0 $.
$d kore-element-var-VE0 x $.
$d kore-sort-var-R x $.
$d kore-element-var-V0 kore-element-var-VE2 $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d z kore-element-var-VE1 $.
$d y kore-element-var-VE1 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-x0 kore-sort-var-R $.
$d kore-sort-var-R kore-element-var-VE2 $.
$d kore-element-var-x0 z $.
$d kore-element-var-V0 kore-element-var-VE1 $.
$d kore-element-var-x0 kore-element-var-VE2 $.
$d kore-sort-var-R z $.
$d kore-element-var-x0 kore-element-var-VE1 $.
$d y kore-sort-var-R $.
$d y kore-element-var-VE0 $.
$d kore-element-var-VE2 x $.
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
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
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
${ $d xX y $.
   $d y ph6 $.
   substitution-kore-exists-alt.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-exists-alt.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-exists-alt.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-exists-alt $a #Substitution ( \kore-exists ph0 ph1 y ph2 ) ( \kore-exists ph3 ph4 y ph5 ) ph6 xX $. $}
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
${ substitution-kore-not.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-not.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-not $a #Substitution ( \kore-not ph0 ph1 ) ( \kore-not ph2 ph3 ) ph4 xX $. $}
${ substitution-kore-and.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-and.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-and.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-and $a #Substitution ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph3 ph4 ph5 ) ph6 xX $. $}
${ substitution-kore-or.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-or.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-or.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-or $a #Substitution ( \kore-or ph0 ph1 ph2 ) ( \kore-or ph3 ph4 ph5 ) ph6 xX $. $}
${ substitution-kore-implies.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-implies.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-implies.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-implies $a #Substitution ( \kore-implies ph0 ph1 ph2 ) ( \kore-implies ph3 ph4 ph5 ) ph6 xX $. $}
${ substitution-kore-equals.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-equals.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-equals.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-equals.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-equals $a #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $. $}
${ substitution-kore-in.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-in.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-in.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-in.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-in $a #Substitution ( \kore-in ph0 ph1 ph2 ph3 ) ( \kore-in ph4 ph5 ph6 ph7 ) ph8 xX $. $}
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
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
ptn2-pattern $f #Pattern ptn2 $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE0-elementvariable $f #ElementVariable kore-element-var-VE0 $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-271-is-pattern $a #Pattern ( \kore-symbol-LblisKResult ptn0 ) $.
${ IMP-symbol-271-substitution.0 $e #Substitution ptn1 ptn2 ptn0 xX0 $.
   IMP-symbol-271-substitution $a #Substitution ( \kore-symbol-LblisKResult ptn1 ) ( \kore-symbol-LblisKResult ptn2 ) ptn0 xX0 $. $}
string-literal-5-is-pattern $a #Pattern "false" $.
IMP-axiom-3337 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-not kore-sort-var-R ( \kore-or kore-sort-var-R ( \kore-exists \kore-sort-SortKResult kore-sort-var-R kore-element-var-VE2 ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R kore-element-var-VE0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ( \kore-bottom kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R kore-element-var-VE0 kore-element-var-VE1 ) ( \kore-top kore-sort-var-R ) ) ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult kore-element-var-VE0 ) ( \kore-dv \kore-sort-SortBool "false" ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-148 $a #Pattern kore-element-var-VE0 $.
substitution-433 $a #Substitution kore-sort-var-R kore-sort-var-R kore-element-var-x0 kore-element-var-VE0 $.
substitution-434 $a #Substitution ( \kore-top kore-sort-var-R ) ( \kore-top kore-sort-var-R ) kore-element-var-x0 kore-element-var-VE0 $.
substitution-495 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortK ) \top ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) \top ) kore-element-var-x0 kore-element-var-VE0 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-277 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) $.
sorting-cache-1174 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-1176 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ) $.
typecode-cache-Pattern-278 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ) $.
typecode-cache-Pattern-279 $a #Pattern ( \kore-in \kore-sort-SortK kore-sort-var-R kore-element-var-VE0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) $.
typecode-cache-Pattern-280 $a #Pattern ( \kore-in \kore-sort-SortK kore-sort-var-R kore-element-var-VE0 kore-element-var-VE1 ) $.
typecode-cache-Pattern-281 $a #Pattern ( \kore-in \kore-sort-SortK kore-sort-var-R kore-element-var-x0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) $.
typecode-cache-Pattern-282 $a #Pattern ( \kore-in \kore-sort-SortK kore-sort-var-R kore-element-var-x0 kore-element-var-VE1 ) $.
substitution-841 $a #Substitution \kore-sort-SortKResult \kore-sort-SortKResult kore-element-var-x0 kore-element-var-VE0 $.
substitution-842 $a #Substitution ( \kore-in \kore-sort-SortK kore-sort-var-R kore-element-var-x0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-in \kore-sort-SortK kore-sort-var-R kore-element-var-VE0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) kore-element-var-x0 kore-element-var-VE0 $.
substitution-843 $a #Substitution ( \kore-bottom kore-sort-var-R ) ( \kore-bottom kore-sort-var-R ) kore-element-var-x0 kore-element-var-VE0 $.
substitution-846 $a #Substitution ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R kore-element-var-x0 kore-element-var-VE1 ) ( \kore-top kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R kore-element-var-VE0 kore-element-var-VE1 ) ( \kore-top kore-sort-var-R ) ) ) kore-element-var-x0 kore-element-var-VE0 $.
substitution-850 $a #Substitution ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult kore-element-var-x0 ) ( \kore-dv \kore-sort-SortBool "false" ) ) ( \kore-top kore-sort-var-R ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult kore-element-var-VE0 ) ( \kore-dv \kore-sort-SortBool "false" ) ) ( \kore-top kore-sort-var-R ) ) kore-element-var-x0 kore-element-var-VE0 $.
sorting-cache-1177 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ) $.
sorting-rearrange-983 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ( \exists kore-element-var-V0 ( \eq kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) \kore-symbol-dotk ) ) ) ) $.
sorting-cache-1584 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
${ sorting-rearrange-984 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-not kore-sort-var-R ( \kore-or kore-sort-var-R ( \kore-exists \kore-sort-SortKResult kore-sort-var-R kore-element-var-VE2 ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ( \kore-bottom kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) \kore-symbol-dotk ) kore-element-var-VE1 ) ( \kore-top kore-sort-var-R ) ) ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceSender" ) ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "false" ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $= ( typecode-cache-Pattern-0 IMP-sort-17-is-pattern kore-top-is-pattern kore-and-is-pattern kore-element-var-VE0-elementvariable kore-dv-is-pattern BASIC-K-sort-1-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern string-literal-10-is-pattern element-var-is-var IMP-sort-28-is-pattern kore-element-var-x0-elementvariable BASIC-K-sort-0-is-pattern IMP-sort-32-is-pattern kore-bottom-is-pattern kore-exists-is-pattern substitution-disjoint kore-or-is-pattern typecode-cache-Pattern-148 string-literal-5-is-pattern kore-not-is-pattern IMP-symbol-271-is-pattern typecode-cache-Pattern-279 top-is-pattern and-is-pattern kore-in-is-pattern kore-equals-is-pattern in-sort-is-pattern typecode-cache-Pattern-25 typecode-cache-Pattern-177 kore-implies-is-pattern typecode-cache-Pattern-277 typecode-cache-Pattern-146 typecode-cache-Pattern-280 typecode-cache-Pattern-281 kore-valid-is-pattern substitution-kore-and substitution-433 typecode-cache-Pattern-282 substitution-var-same rule-and-intro-alt2-sugar rule-imp-transitivity kore-element-var-V0-elementvariable kore-is-sort-is-pattern substitution-kore-in substitution-kore-exists-alt substitution-kore-or substitution-kore-not substitution-kore-implies substitution-kore-valid substitution-imp substitution-434 sorting-cache-1177 sorting-cache-1584 top-intro rule-weakening sorting-rearrange-983 typecode-cache-Pattern-278 and-elim-left-sugar sorting-cache-1174 sorting-cache-1176 IMP-axiom-3337 substitution-in-sort substitution-and IMP-symbol-271-substitution substitution-kore-equals substitution-495 substitution-841 substitution-842 substitution-843 substitution-846 substitution-850 functional-substitution-alt ) ACUQACUQEJENIKLMRUMUIUJUJADADADADADPADADADFADRADEJENIKLMPJBUOKLMUKADFGGBUAADTUCUFADADFADRADEJENIKLMCURUKADFGGGADSADEJENIKLMUGSUEIULADFGUPVAACUQACUQEJENIKLMRUMUIUJACVRACUQEJENIKLMRUMUIACVSACUQUIVTWAVFVFEJENIKLMADADADADADPADADADFADAHBUHADFGGBUAADTUCUFADADFADAHCUSADFGGGADSADHUDUGSUEIULADFGUPVAADADADADADPADADADFADRADEJENIKLMPJBUOKLMUKADFGGBUAADTUCUFADADFADRADEJENIKLMCURUKADFGGGADSADEJENIKLMUGSUEIULADFGUPVAADADADADADPADADADFADABQUTADFGGBUAADTUCUFADADFADACQVDADFGGGADSADQUNUGSUEIULADFGUPVAACUQHUDRUMUIUJEJENIKLMRUMUIUJQUNRUMUIUJVHHQACVHWBACUQHUDRUMUIUJUJAHCWCADADADADADPADADADFADAHBUHADFGGBUAADTUCUFADADFADAHCUSADFGGGADSADHUDUGSUEIULADFGUPVAACUQHUDRUMUIUJUJADVIHUDRUMCURRUMUIUJUJACUQHUDRUMUIUJUJACUQADVIACUQHUDRUMUIUJWDACWEVGAHCWFVFAHBCWGVGEJENIKLMEJENIKLMRUMUIUJADADADADADPADADADFADRADEJENIKLMPJBUOKLMUKADFGGBUAADTUCUFADADFADRADEJENIKLMCURUKADFGGGADSADEJENIKLMUGSUEIULADFGUPVAHUDRUMUIUJADADADADADPADADADFADAHBUHADFGGBUAADTUCUFADADFADAHCUSADFGGGADSADHUDUGSUEIULADFGUPVAHOEJENIKLMEJENIKLMRUMUIHUDRUMUIHOEJENIKLMEJENIKLMRHUDRHOEJENIKLMHOVEREJENIKLMHOUBWHUIEJENIKLMHOUBWIADADADADADPADADADFADRADEJENIKLMPJBUOKLMUKADFGGBUAADTUCUFADADFADRADEJENIKLMCURUKADFGGGADSADEJENIKLMUGSUEIULADFGUPADADADADADPADADADFADAHBUHADFGGBUAADTUCUFADADFADAHCUSADFGGGADSADHUDUGSUEIULADFGUPEJENIKLMHOADEJENIKLMHOUBADADADADPADADADFADRADEJENIKLMPJBUOKLMUKADFGGBUAADTUCUFADADFADRADEJENIKLMCURUKADFGGGADSADEJENIKLMUGSUEIULADFGADADADADPADADADFADAHBUHADFGGBUAADTUCUFADADFADAHCUSADFGGGADSADHUDUGSUEIULADFGEJENIKLMHOADEJENIKLMHOUBADADADPADADADFADRADEJENIKLMPJBUOKLMUKADFGGBUAADTUCUFADADFADRADEJENIKLMCURUKADFGGADADADPADADADFADAHBUHADFGGBUAADTUCUFADADFADAHCUSADFGGEJENIKLMHOADEJENIKLMHOUBADADPADADADFADRADEJENIKLMPJBUOKLMUKADFGGBUAADTUCADADPADADADFADAHBUHADFGGBUAADTUCEJENIKLMHOADEJENIKLMHOUBADPADADADFADRADEJENIKLMPJBUOKLMUKADFGGBUAADTADPADADADFADAHBUHADFGGBUAADTEJENIKLMHOADEJENIKLMHOUBPADADADFADRADEJENIKLMPJBUOKLMUKADFGGPADADADFADAHBUHADFGGEJENIKLMBHOPEJENIKLMHOUBADEJENIKLMHOUBADADFADRADEJENIKLMPJBUOKLMUKADFGADADFADAHBUHADFGEJENIKLMHOADEJENIKLMHOUBADFEJENIKLMHOUBADRADEJENIKLMPJBUOKLMUKADFADAHBUHADFEJENIKLMHOADEJENIKLMHOUBRADEJENIKLMPJBUOKLMRADHUDPJBUOKLMEJENIKLMHOREJENIKLMHOUBADEJENIKLMHOUBEJENIKLMHOVEPJBUOKLMEJENIKLMHOUBVJADFEJENIKLMHOUBVBVBVKADTEJENIKLMHOUBVLVMADADFADRADEJENIKLMCURUKADFGADADFADAHCUSADFGEJENIKLMHOADEJENIKLMHOUBADFEJENIKLMHOUBADRADEJENIKLMCURUKADFADAHCUSADFEJENIKLMHOADEJENIKLMHOUBRADEJENIKLMCURRADHUDCUREJENIKLMHOREJENIKLMHOUBADEJENIKLMHOUBEJENIKLMHOVECUREJENIKLMHOUBVJADFEJENIKLMHOUBVBVBVBADSADEJENIKLMUGSUEIULADFADSADHUDUGSUEIULADFEJENIKLMHOADEJENIKLMHOUBSADEJENIKLMUGSUEISADHUDUGSUEIEJENIKLMHOSEJENIKLMHOUBADEJENIKLMHOUBHOEJENIKLMEJENIKLMHUDEJENIKLMHOVEWJSUEIEJENIKLMHOUBWKADFEJENIKLMHOUBVBVNVOVPQUNQUNRUMUIUJADADADADADPADADADFADABQUTADFGGBUAADTUCUFADADFADACQVDADFGGGADSADQUNUGSUEIULADFGUPVAHUDRUMUIUJADADADADADPADADADFADAHBUHADFGGBUAADTUCUFADADFADAHCUSADFGGGADSADHUDUGSUEIULADFGUPVAHOHQWLADADADADADPADADADFADABQUTADFGGBUAADTUCUFADADFADACQVDADFGGGADSADQUNUGSUEIULADFGUPADADADADADPADADADFADAHBUHADFGGBUAADTUCUFADADFADAHCUSADFGGGADSADHUDUGSUEIULADFGUPQUNHOAHQVCADADADADPADADADFADABQUTADFGGBUAADTUCUFADADFADACQVDADFGGGADSADQUNUGSUEIULADFGADADADADPADADADFADAHBUHADFGGBUAADTUCUFADADFADAHCUSADFGGGADSADHUDUGSUEIULADFGQUNHOAHQVCADADADPADADADFADABQUTADFGGBUAADTUCUFADADFADACQVDADFGGADADADPADADADFADAHBUHADFGGBUAADTUCUFADADFADAHCUSADFGGQUNHOAHQVCADADPADADADFADABQUTADFGGBUAADTUCADADPADADADFADAHBUHADFGGBUAADTUCQUNHOAHQVCADPADADADFADABQUTADFGGBUAADTADPADADADFADAHBUHADFGGBUAADTQUNHOAHQVCPADADADFADABQUTADFGGPADADADFADAHBUHADFGGQUNBHOHQWMAHQVCADADFADABQUTADFGADADFADAHBUHADFGQUNHOAHQVCAHQVQADABQUTADFADAHBUHADFQUNHOAHQVCAHBQWNAHQVQVBVBVKAHQWOVLVMAHCQWPVBAHQWQVNVOVPWRVG $. $}
