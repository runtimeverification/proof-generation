$c #Substitution \kore-symbol-Lbl'-LT-'T'-GT-' \top \kore-sort-SortAExp \kore-symbol-LblisKResult \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-symbol-kseq \kore-sort-SortBool \kore-sort-SortK \imp "0" ) \kore-and \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' #SetVariable \kore-top #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' "true" \kore-inj \kore-sort-SortInt \in-sort ( \exists \kore-sort-SortBExp #Variable "10" \kore-dv |- \kore-valid \kore-equals \kore-symbol-Lbl'-LT-'k'-GT-' \and \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable \kore-symbol-LblnotBool'Unds' \eq \kore-sort-SortKItem \kore-symbol-Lbl'Unds'andBool'Unds' \kore-symbol-dotk \kore-sort-SortStateCell $.
$v z xX0 kore-element-var-VE1 th2 kore-element-var-VE3 th0 kore-element-var-VE2 ph6 kore-element-var-x0 th1 kore-element-var-VE4 ptn3 ptn2 kore-element-var-Val ph3 ptn0 ph8 ph1 th3 ph0 ph2 xX x ptn4 ptn1 y ph7 ph4 ph5 $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d y z $.
$d kore-element-var-x0 kore-element-var-Val $.
$d y kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE3 kore-element-var-Val $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-Val kore-element-var-VE2 $.
$d z x $.
$d kore-element-var-VE3 x $.
$d kore-element-var-VE3 z $.
$d x kore-element-var-VE1 $.
$d kore-element-var-x0 kore-element-var-VE3 $.
$d z kore-element-var-VE2 $.
$d kore-element-var-Val x $.
$d kore-element-var-VE4 z $.
$d y kore-element-var-VE4 $.
$d z kore-element-var-Val $.
$d y x $.
$d kore-element-var-VE4 kore-element-var-Val $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d z kore-element-var-VE1 $.
$d y kore-element-var-VE1 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE4 x $.
$d y kore-element-var-Val $.
$d kore-element-var-x0 kore-element-var-VE4 $.
$d kore-element-var-x0 z $.
$d kore-element-var-VE4 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-x0 kore-element-var-VE2 $.
$d kore-element-var-x0 kore-element-var-VE1 $.
$d kore-element-var-Val kore-element-var-VE1 $.
$d kore-element-var-VE2 x $.
$d y kore-element-var-VE3 $.
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
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
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
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-rewrites-is-pattern $a #Pattern ( \kore-rewrites ph0 ph1 ph2 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
${ substitution-kore-and.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-and.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-and.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-and $a #Substitution ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph3 ph4 ph5 ) ph6 xX $. $}
${ substitution-kore-equals.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-equals.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-equals.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-equals.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-equals $a #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $. $}
${ substitution-kore-rewrites.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-rewrites.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-rewrites.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-rewrites $a #Substitution ( \kore-rewrites ph0 ph1 ph2 ) ( \kore-rewrites ph3 ph4 ph5 ) ph6 xX $. $}
${ substitution-kore-inj.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-inj.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-inj.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-inj $a #Substitution ( \kore-inj ph0 ph1 ph2 ) ( \kore-inj ph3 ph4 ph5 ) ph6 xX $. $}
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
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
${ KSEQ-symbol-0-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   KSEQ-symbol-0-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   KSEQ-symbol-0-substitution $a #Substitution ( \kore-symbol-kseq ptn1 ptn2 ) ( \kore-symbol-kseq ptn3 ptn4 ) ptn0 xX0 $. $}
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-95-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ptn0 ) $.
${ IMP-symbol-95-substitution.0 $e #Substitution ptn1 ptn2 ptn0 xX0 $.
   IMP-symbol-95-substitution $a #Substitution ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ptn1 ) ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ptn2 ) ptn0 xX0 $. $}
IMP-symbol-126-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn0 ptn1 ) $.
${ IMP-symbol-126-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-126-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-126-substitution $a #Substitution ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn1 ptn2 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-128-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ptn0 ) $.
IMP-symbol-129-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn0 ptn1 ) $.
${ IMP-symbol-129-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-129-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-129-substitution $a #Substitution ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn1 ptn2 ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-131-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn0 ) $.
${ IMP-symbol-131-substitution.0 $e #Substitution ptn1 ptn2 ptn0 xX0 $.
   IMP-symbol-131-substitution $a #Substitution ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn1 ) ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn2 ) ptn0 xX0 $. $}
IMP-symbol-192-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
IMP-symbol-205-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'andBool'Unds' ptn0 ptn1 ) $.
${ IMP-symbol-205-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-205-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-205-substitution $a #Substitution ( \kore-symbol-Lbl'Unds'andBool'Unds' ptn1 ptn2 ) ( \kore-symbol-Lbl'Unds'andBool'Unds' ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-271-is-pattern $a #Pattern ( \kore-symbol-LblisKResult ptn0 ) $.
${ IMP-symbol-271-substitution.0 $e #Substitution ptn1 ptn2 ptn0 xX0 $.
   IMP-symbol-271-substitution $a #Substitution ( \kore-symbol-LblisKResult ptn1 ) ( \kore-symbol-LblisKResult ptn2 ) ptn0 xX0 $. $}
IMP-symbol-297-is-pattern $a #Pattern ( \kore-symbol-LblnotBool'Unds' ptn0 ) $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
string-literal-0-is-pattern $a #Pattern "true" $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
string-literal-13-is-pattern $a #Pattern "10" $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
substitution-448 $a #Substitution \kore-sort-SortGeneratedTopCell \kore-sort-SortGeneratedTopCell kore-element-var-x0 kore-element-var-VE1 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
substitution-683 $a #Substitution kore-element-var-VE3 kore-element-var-VE3 kore-element-var-x0 kore-element-var-VE1 $.
typecode-cache-Pattern-286 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) $.
sorting-cache-1254 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortAExp ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) ) $.
substitution-864 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortAExp ) \top ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortAExp ) \top ) kore-element-var-x0 kore-element-var-VE1 $.
substitution-872 $a #Substitution ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-x0 ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE1 ) \kore-symbol-dotk ) kore-element-var-x0 kore-element-var-VE1 $.
sorting-cache-1256 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) ) $.
typecode-cache-Pattern-333 $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-VE1 kore-element-var-VE4 ) $.
typecode-cache-Pattern-334 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-VE1 kore-element-var-VE4 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) $.
typecode-cache-Pattern-335 $a #Pattern ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE1 ) \kore-symbol-dotk ) ) kore-element-var-VE2 ) $.
sorting-rearrange-979 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-equals \kore-sort-SortBool \kore-sort-SortGeneratedTopCell ( \kore-symbol-Lbl'Unds'andBool'Unds' ( \kore-symbol-Lbl'Unds'andBool'Unds' ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE1 ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-symbol-LblnotBool'Unds' ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE4 ) \kore-symbol-dotk ) ) ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-VE1 kore-element-var-VE4 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE4 ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE1 ) \kore-symbol-dotk ) ) kore-element-var-VE2 ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $.
sorting-rearrange-980 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) ) ( \exists kore-element-var-Val ( \eq kore-element-var-Val ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) ) ) $.
typecode-cache-Pattern-336 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) kore-element-var-VE4 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) $.
typecode-cache-Pattern-338 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-x0 kore-element-var-VE4 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) $.
typecode-cache-Pattern-339 $a #Pattern ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-x0 ) \kore-symbol-dotk ) ) kore-element-var-VE2 ) $.
substitution-964 $a #Substitution ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) kore-element-var-VE4 ) ) kore-element-var-VE2 ) ) ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-VE1 kore-element-var-VE4 ) ) kore-element-var-VE2 ) ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) kore-element-var-VE1 $.
substitution-965 $a #Substitution \kore-sort-SortBool \kore-sort-SortBool kore-element-var-x0 kore-element-var-VE1 $.
substitution-970 $a #Substitution ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-x0 kore-element-var-VE4 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp kore-element-var-VE1 kore-element-var-VE4 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) kore-element-var-x0 kore-element-var-VE1 $.
substitution-971 $a #Substitution ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-x0 ) \kore-symbol-dotk ) ) kore-element-var-VE2 ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE1 ) \kore-symbol-dotk ) ) kore-element-var-VE2 ) kore-element-var-x0 kore-element-var-VE1 $.
sorting-cache-1582 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) ) ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-sort-SortAExp ) ) $.
${ sorting-rearrange-981 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) \top ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-equals \kore-sort-SortBool \kore-sort-SortGeneratedTopCell ( \kore-symbol-Lbl'Unds'andBool'Unds' ( \kore-symbol-Lbl'Unds'andBool'Unds' ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-symbol-LblnotBool'Unds' ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE4 ) \kore-symbol-dotk ) ) ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) kore-element-var-VE4 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE4 ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "10" ) ) ) \kore-symbol-dotk ) ) kore-element-var-VE2 ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( IMP-sort-13-is-pattern IMP-sort-23-is-pattern kore-inj-is-pattern kore-dv-is-pattern kore-element-var-VE1-elementvariable BASIC-K-sort-1-is-pattern KSEQ-symbol-0-is-pattern IMP-sort-8-is-pattern IMP-sort-32-is-pattern KSEQ-symbol-1-is-pattern string-literal-13-is-pattern typecode-cache-Pattern-179 element-var-is-var IMP-symbol-271-is-pattern string-literal-0-is-pattern kore-element-var-x0-elementvariable in-sort-is-pattern IMP-symbol-205-is-pattern string-literal-1-is-pattern IMP-symbol-128-is-pattern typecode-cache-Pattern-146 and-is-pattern typecode-cache-Pattern-177 IMP-symbol-129-is-pattern kore-and-is-pattern typecode-cache-Pattern-178 typecode-cache-Pattern-25 IMP-symbol-297-is-pattern IMP-symbol-131-is-pattern substitution-disjoint BASIC-K-sort-0-is-pattern IMP-symbol-126-is-pattern top-is-pattern typecode-cache-Pattern-286 kore-top-is-pattern kore-equals-is-pattern typecode-cache-Pattern-335 kore-rewrites-is-pattern IMP-symbol-95-is-pattern typecode-cache-Pattern-334 kore-valid-is-pattern typecode-cache-Pattern-339 typecode-cache-Pattern-336 rule-imp-transitivity typecode-cache-Pattern-338 rule-and-intro-alt2-sugar KSEQ-symbol-0-substitution substitution-448 and-elim-left-sugar IMP-symbol-205-substitution IMP-symbol-129-substitution substitution-kore-and substitution-var-same IMP-symbol-126-substitution imp-reflexivity kore-element-var-Val-elementvariable substitution-kore-inj IMP-symbol-271-substitution substitution-kore-equals IMP-sort-22-is-pattern IMP-symbol-131-substitution substitution-kore-rewrites substitution-kore-valid substitution-imp sorting-cache-1256 sorting-cache-1582 top-intro rule-weakening sorting-rearrange-980 and-elim-right-sugar sorting-cache-1254 sorting-rearrange-979 substitution-in-sort substitution-and IMP-symbol-192-is-pattern typecode-cache-Pattern-333 substitution-964 IMP-symbol-95-substitution substitution-864 substitution-965 substitution-872 substitution-970 substitution-971 substitution-683 functional-substitution-alt ) AUFUNTBCUQUEAUFUNTBCUQUEEDENGFDTUPUEUEKKKLKDIEDENGFFMJQLRGUADICOFMJQUKUALRGUSABCVFEUBGUCUGUHKKURDICOFDIEDENGFFMJVBAUFJJULBUIUOEUBGUCUGUHVAVDAUFUNTBCUQUEAUFUNTBCUQUEEDENGFDTUPUEAUFUNTBCUQUEAUFUNTBCUQAUFUNTBCUQUEAUFUNTAUFUNTAUFUNTBCUQVLAUFUNTVRVGABCWHVIAUFUNTBCUQUEEDENGFDTUPABCWIAUFUNTBCUQUEUPWJWKVIVIEDENGFKKKLKDIHUDFMJQLRGUADICOFMJQUKUALRGUSAHBCVCEUBGUCUGUHKKURDICOFAHUTJULBUIUOEUBGUCUGUHVAVDKKKLKDIEDENGFFMJQLRGUADICOFMJQUKUALRGUSABCVFEUBGUCUGUHKKURDICOFDIEDENGFFMJVBAUFJJULBUIUOEUBGUCUGUHVAVDKKKLKDISUJFMJQLRGUADICOFMJQUKUALRGUSABCSVHEUBGUCUGUHKKURDICOFASVEJULBUIUOEUBGUCUGUHVAVDAUFUNTBCUQUEHUDDTUPUEEDENGFDTUPUESUJDTUPUEVSHSABCVSWLAUFUNTBCUQUEHUDDTUPUEUEHUDDTAUFUNTBCUQUEUEKKKLKDIHUDFMJQLRGUADICOFMJQUKUALRGUSAHBCVCEUBGUCUGUHKKURDICOFAHUTJULBUIUOEUBGUCUGUHVAVDAUFUNTBCUQUEHUDDTUPUEUEHUDDTAUFUNTBCUQUEAUFUNTBCUQUEHUDDTUPUEUEHUDDTUPUEHUDDTAUFUNTBCUQUEHUDDTUPUEWMHUDDTUPUEHUDDTHUDDTHUDDTUPVLHUDDTVRVGVGAUFUNTBCUQUEHUDDTUPUEUEAUFUNTBCUQAUFUNTBCUQUEHUDDTUPUEUEAUFUNTBCUQUEAUFUNTAUFUNTBCUQUEHUDDTUPUEVLAUFUNTBCUQVLVGAHBCWNVIVIAHBCWOVGEDENGFEDENGFDTUPUEKKKLKDIEDENGFFMJQLRGUADICOFMJQUKUALRGUSABCVFEUBGUCUGUHKKURDICOFDIEDENGFFMJVBAUFJJULBUIUOEUBGUCUGUHVAVDHUDDTUPUEKKKLKDIHUDFMJQLRGUADICOFMJQUKUALRGUSAHBCVCEUBGUCUGUHKKURDICOFAHUTJULBUIUOEUBGUCUGUHVAVDHPEDENGFEDENGFDTUPHUDDTUPHPEDENGFEDENGFDHUDDHPEDENGFHPVPDEDENGFHPUMWPUPEDENGFHPUMWQKKKLKDIEDENGFFMJQLRGUADICOFMJQUKUALRGUSABCVFEUBGUCUGUHKKURDICOFDIEDENGFFMJVBAUFJJULBUIUOEUBGUCUGUHVAKKKLKDIHUDFMJQLRGUADICOFMJQUKUALRGUSAHBCVCEUBGUCUGUHKKURDICOFAHUTJULBUIUOEUBGUCUGUHVAEDENGFHPKEDENGFHPUMKKLKDIEDENGFFMJQLRGUADICOFMJQUKUALRGUSABCVFEUBGUCUGUHKKURDICOFDIEDENGFFMJVBAUFJJULBUIUOEUBGUCUGUHKKLKDIHUDFMJQLRGUADICOFMJQUKUALRGUSAHBCVCEUBGUCUGUHKKURDICOFAHUTJULBUIUOEUBGUCUGUHEDENGFHPKEDENGFHPUMKLKDIEDENGFFMJQLRGUADICOFMJQUKUALRGUSABCVFEUBGUCUGKLKDIHUDFMJQLRGUADICOFMJQUKUALRGUSAHBCVCEUBGUCUGEDENGFHPKEDENGFHPUMLKDIEDENGFFMJQLRGUADICOFMJQUKUALRGLKDIHUDFMJQLRGUADICOFMJQUKUALRGEDENGFHPLEDENGFHPUMKEDENGFHPUMHPEDENGFDIEDENGFFMJQLRGUADICOFMJQUKDIHUDFMJQLRGUADICOFMJQUKHPEDENGFDIEDENGFFMJQLRGDIHUDFMJQLRGHPEDENGFDIEDENGFFMJDIHUDFMJHPEDENGFDIEDENGFFMDIHUDFMDIEDENGFDIHUDEDENGFHPDEDENGFHPUMIEDENGFHPUMEDENGFHPVPVTMEDENGFHPUMVJWALRGEDENGFHPUMVMDICOFMJQUKEDENGFHPUMVMLRGEDENGFHPUMWBHPEDENGFABCVFEUBGUCAHBCVCEUBGUCHPEDENGFWCIEDENGFCOWRFAUFJULBUIWCIHCWSFAUFJULBUIAHCWTBUIEDENGFHPUMVQEUBGUCEDENGFHPUMVNVOKKURDICOFDIEDENGFFMJVBAUFJJULBUIUOEUBGUCUGKKURDICOFAHUTJULBUIUOEUBGUCUGEDENGFHPKEDENGFHPUMKUREDENGFHPUMHPEDENGFDICOFDIEDENGFFMJVBAUFJJULBUIUOEUBGUCDICOFAHUTJULBUIUOEUBGUCHPEDENGFDICOFDIEDENGFFMJVBAUFJJULBUIDICOFAHUTJULBUIHPEDENGFDICOFDIEDENGFFMJVBAUFJJDICOFAHUTJHPEDENGFDICOFDIEDENGFFMJVBAUFJDICOFAHUTDICOFEDENGFHPUMHPEDENGFDIEDENGFFMJVBAUFDIHUDFMJVBAUFHPEDENGFDIEDENGFFMJDIHUDFMJHPEDENGFDIEDENGFFMDIHUDFMDIEDENGFDIHUDEDENGFHPDEDENGFHPUMIEDENGFHPUMEDENGFHPVPVTMEDENGFHPUMVJXAAUFEDENGFHPUMVJVJWDBUIEDENGFHPUMVQEUBGUCEDENGFHPUMVNVOWEWFWGSUJSUJDTUPUEKKKLKDISUJFMJQLRGUADICOFMJQUKUALRGUSABCSVHEUBGUCUGUHKKURDICOFASVEJULBUIUOEUBGUCUGUHVAVDHUDDTUPUEKKKLKDIHUDFMJQLRGUADICOFMJQUKUALRGUSAHBCVCEUBGUCUGUHKKURDICOFAHUTJULBUIUOEUBGUCUGUHVAVDHPHSXBKKKLKDISUJFMJQLRGUADICOFMJQUKUALRGUSABCSVHEUBGUCUGUHKKURDICOFASVEJULBUIUOEUBGUCUGUHVAKKKLKDIHUDFMJQLRGUADICOFMJQUKUALRGUSAHBCVCEUBGUCUGUHKKURDICOFAHUTJULBUIUOEUBGUCUGUHVASUJHPHSVKKKLKDISUJFMJQLRGUADICOFMJQUKUALRGUSABCSVHEUBGUCUGUHKKURDICOFASVEJULBUIUOEUBGUCUGUHKKLKDIHUDFMJQLRGUADICOFMJQUKUALRGUSAHBCVCEUBGUCUGUHKKURDICOFAHUTJULBUIUOEUBGUCUGUHSUJHPHSVKKLKDISUJFMJQLRGUADICOFMJQUKUALRGUSABCSVHEUBGUCUGKLKDIHUDFMJQLRGUADICOFMJQUKUALRGUSAHBCVCEUBGUCUGSUJHPHSVKLKDISUJFMJQLRGUADICOFMJQUKUALRGLKDIHUDFMJQLRGUADICOFMJQUKUALRGSUJHPHSXCHSVKHPSUJDISUJFMJQLRGUADICOFMJQUKDIHUDFMJQLRGUADICOFMJQUKHPSUJDISUJFMJQLRGDIHUDFMJQLRGHPSUJDISUJFMJDIHUDFMJHSXDWALRGSUJHPUMVMDICOFMJQUKSUJHPUMVMLRGSUJHPUMWBHPSUJABCSVHEUBGUCAHBCVCEUBGUCAHBCSXEEUBGUCSUJHPUMVNVOKKURDICOFASVEJULBUIUOEUBGUCUGKKURDICOFAHUTJULBUIUOEUBGUCUGSUJHPHSVKKURSUJHPUMHPSUJDICOFASVEJULBUIUOEUBGUCDICOFAHUTJULBUIUOEUBGUCHPSUJDICOFASVEJULBUIDICOFAHUTJULBUIHPSUJDICOFASVEJDICOFAHUTJHPSUJDICOFASVEDICOFAHUTDICOFSUJHPUMAHSXFVJWDHBSXGVQEUBGUCSUJHPUMVNVOWEWFWGXHVG $. $}
