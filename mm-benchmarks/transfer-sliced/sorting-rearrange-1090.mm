$c \exists #Substitution \top \kore-symbol-kseq #Variable \kore-sort-SortBool \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-equals "false" \and #SetVariable #ElementVariable #Symbol \eq #Pattern \kore-exists \kore-sort-SortKItem \kore-inj \in-sort \kore-symbol-dotk ( $.
$v kore-element-var-V0 z th2 th0 ph6 kore-element-var-x0 th1 ph3 ptn0 ph1 th3 kore-sort-var-R kore-element-var-V2 ph0 ph2 xX x ptn1 y ph4 ph5 $.
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
th0-is-pattern $f #Pattern th0 $.
th1-is-pattern $f #Pattern th1 $.
th2-is-pattern $f #Pattern th2 $.
th3-is-pattern $f #Pattern th3 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
z-is-element-var $f #ElementVariable z $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
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
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
string-literal-5-is-pattern $a #Pattern "false" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
typecode-cache-Pattern-35 $a #Pattern kore-element-var-V2 $.
typecode-cache-Pattern-39 $a #Pattern kore-element-var-V0 $.
substitution-421 $a #Substitution kore-sort-var-R kore-sort-var-R kore-element-var-x0 kore-element-var-V2 $.
typecode-cache-Pattern-156 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
sorting-rearrange-276 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \exists kore-element-var-V0 ( \eq kore-element-var-V0 \kore-symbol-dotk ) ) ) $.
sorting-cache-568 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ) $.
substitution-487 $a #Substitution ( \and ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) \top ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) \kore-symbol-dotk kore-element-var-V2 $.
substitution-488 $a #Substitution kore-sort-var-R kore-sort-var-R \kore-symbol-dotk kore-element-var-V2 $.
substitution-490 $a #Substitution \kore-sort-SortK \kore-sort-SortK kore-element-var-x0 kore-element-var-V2 $.
substitution-492 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortK ) \top ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) kore-element-var-x0 kore-element-var-V2 $.
sorting-cache-570 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) \top ) ) $.
typecode-cache-Pattern-373 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V2 ) ) $.
sorting-rearrange-1089 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V2 ) ) ) ) ) $.
typecode-cache-Pattern-374 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-x0 ) ) $.
substitution-1045 $a #Substitution ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-symbol-dotk ) ) ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V2 ) ) \kore-symbol-dotk kore-element-var-V2 $.
substitution-1046 $a #Substitution ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-x0 ) ) ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V2 ) ) kore-element-var-x0 kore-element-var-V2 $.
${ sorting-rearrange-1090 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-symbol-dotk ) ) ) ) ) $= ( typecode-cache-Pattern-0 BASIC-K-sort-0-is-pattern kore-element-var-V2-elementvariable and-is-pattern top-is-pattern kore-element-var-x0-elementvariable KSEQ-symbol-1-is-pattern kore-exists-is-pattern in-sort-is-pattern IMP-sort-32-is-pattern kore-valid-is-pattern typecode-cache-Pattern-373 element-var-is-var kore-is-sort-is-pattern typecode-cache-Pattern-39 BASIC-K-sort-1-is-pattern string-literal-5-is-pattern kore-dv-is-pattern kore-inj-is-pattern KSEQ-symbol-0-is-pattern kore-equals-is-pattern typecode-cache-Pattern-25 typecode-cache-Pattern-374 typecode-cache-Pattern-35 rule-imp-transitivity substitution-488 substitution-kore-exists-alt substitution-kore-valid substitution-imp substitution-421 sorting-cache-133 sorting-cache-570 rule-and-intro-alt2-sugar sorting-rearrange-276 typecode-cache-Pattern-156 sorting-cache-568 sorting-rearrange-1089 substitution-487 substitution-disjoint substitution-1045 substitution-492 substitution-490 substitution-1046 functional-substitution-alt ) ACPGFACPGFIDKGFFACDACDACBQLRLSTUAIUBUCBJMACPGFACPGFIDKGFAUMAUNUOIACDACABENBJMACDACDACBQLRLSTUAIUBUCBJMACDACABHUEBJMACPGFEUFDKGFIDKGFHUDDKGFBEHABUPACPGFEUFDKGFFAEUQACDACABENBJMAEURABEUSUGIIDKGFACDACDACBQLRLSTUAIUBUCBJMEUFDKGFACDACABENBJMEOEUTACDACDACBQLRLSTUAIUBUCBJACDACABENBJIEOAEUHDACDACBQLRLSTUAIUBUCDACABENIBEODIEOVAAEUHABEVBUIUJUKHUDHUDDKGFACDACABHUEBJMEUFDKGFACDACABENBJMEOEHVCACDACABHUEBJACDACABENBJHUDEOAEHULDACABHUEDACABENHUDBEOEHVDAEHULABEHVEUIUJUKVFUG $. $}
