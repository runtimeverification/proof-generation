$c \exists #Substitution \kore-symbol-Lbl'-LT-'T'-GT-' \kore-sort-SortBExp \top \kore-symbol-dotk \kore-symbol-kseq \kore-sort-SortStmt #Variable \kore-sort-SortBool \kore-sort-SortK \imp \kore-dv "0" |- \kore-valid ) \kore-symbol-Lbl'-LT-'k'-GT-' "false" \and \kore-and #SetVariable \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' \eq #Pattern \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block \kore-sort-SortBlock \kore-sort-SortKItem \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' \kore-inj \kore-sort-SortInt \in-sort \kore-top \kore-sort-SortStateCell ( $.
$v kore-element-var-V0 xX0 z kore-element-var-VE1 th2 kore-element-var-VE3 th0 kore-element-var-VE2 ph6 kore-element-var-x0 th1 kore-element-var-VE4 ptn2 ptn3 ph3 ptn0 ph1 th3 ph0 ph2 xX x ptn4 ptn1 y ph4 ph5 $.
$d kore-element-var-V0 z $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d y z $.
$d kore-element-var-V0 x $.
$d y kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE4 kore-element-var-V0 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d z x $.
$d kore-element-var-x0 kore-element-var-V0 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-VE3 z $.
$d x kore-element-var-VE1 $.
$d kore-element-var-x0 kore-element-var-VE3 $.
$d z kore-element-var-VE2 $.
$d kore-element-var-VE4 z $.
$d y kore-element-var-VE4 $.
$d kore-element-var-V0 kore-element-var-VE2 $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d z kore-element-var-VE1 $.
$d y kore-element-var-VE1 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE4 x $.
$d kore-element-var-x0 kore-element-var-VE4 $.
$d kore-element-var-x0 z $.
$d kore-element-var-V0 kore-element-var-VE1 $.
$d kore-element-var-VE4 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-x0 kore-element-var-VE2 $.
$d kore-element-var-x0 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-V0 $.
$d kore-element-var-VE2 x $.
$d y kore-element-var-VE3 $.
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
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
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
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
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
${ substitution-kore-rewrites.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-rewrites.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-rewrites.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-rewrites $a #Substitution ( \kore-rewrites ph0 ph1 ph2 ) ( \kore-rewrites ph3 ph4 ph5 ) ph6 xX $. $}
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
KSEQ-symbol-1-sorting $a |- ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-18-is-pattern $a #Pattern \kore-sort-SortBlock $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
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
IMP-symbol-241-is-pattern $a #Pattern ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ptn0 ptn1 ptn2 ) $.
string-literal-1-is-pattern $a #Pattern "0" $.
string-literal-5-is-pattern $a #Pattern "false" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
substitution-448 $a #Substitution \kore-sort-SortGeneratedTopCell \kore-sort-SortGeneratedTopCell kore-element-var-x0 kore-element-var-VE1 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
substitution-675 $a #Substitution ( \and ( \in-sort \kore-symbol-dotk \kore-sort-SortK ) \top ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) \kore-symbol-dotk kore-element-var-VE1 $.
substitution-676 $a #Substitution kore-element-var-VE3 kore-element-var-VE3 \kore-symbol-dotk kore-element-var-VE1 $.
substitution-681 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortK ) \top ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) kore-element-var-x0 kore-element-var-VE1 $.
typecode-cache-Pattern-382 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ) $.
typecode-cache-Pattern-383 $a #Pattern ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-inj \kore-sort-SortBool \kore-sort-SortBExp ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-VE4 kore-element-var-VE2 ) ) kore-element-var-VE1 ) $.
typecode-cache-Pattern-384 $a #Pattern ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE2 ) kore-element-var-VE1 ) $.
sorting-rearrange-1129 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-inj \kore-sort-SortBool \kore-sort-SortBExp ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-VE4 kore-element-var-VE2 ) ) kore-element-var-VE1 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE2 ) kore-element-var-VE1 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $.
sorting-rearrange-1130 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ) ) ( \exists kore-element-var-V0 ( \eq kore-element-var-V0 \kore-symbol-dotk ) ) ) $.
sorting-cache-1844 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ) ) $.
typecode-cache-Pattern-385 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-inj \kore-sort-SortBool \kore-sort-SortBExp ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-VE4 kore-element-var-VE2 ) ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) $.
typecode-cache-Pattern-386 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) $.
typecode-cache-Pattern-387 $a #Pattern ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-inj \kore-sort-SortBool \kore-sort-SortBExp ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-VE4 kore-element-var-VE2 ) ) kore-element-var-x0 ) $.
typecode-cache-Pattern-388 $a #Pattern ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE2 ) kore-element-var-x0 ) $.
substitution-1095 $a #Substitution ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE2 ) kore-element-var-VE1 ) ) kore-element-var-VE3 ) \kore-symbol-dotk kore-element-var-VE1 $.
substitution-1096 $a #Substitution ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-inj \kore-sort-SortBool \kore-sort-SortBExp ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-VE4 kore-element-var-VE2 ) ) kore-element-var-x0 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-inj \kore-sort-SortBool \kore-sort-SortBExp ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-VE4 kore-element-var-VE2 ) ) kore-element-var-VE1 ) ) kore-element-var-VE3 ) kore-element-var-x0 kore-element-var-VE1 $.
substitution-1098 $a #Substitution ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE2 ) kore-element-var-x0 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE2 ) kore-element-var-VE1 ) ) kore-element-var-VE3 ) kore-element-var-x0 kore-element-var-VE1 $.
sorting-cache-1845 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ) ) $.
${ sorting-rearrange-1131 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortBlock ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortBlock ) \top ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lblif'LParUndsRParUnds'else'UndsUnds'IMP-SYNTAX'Unds'Stmt'Unds'BExp'Unds'Block'Unds'Block ( \kore-inj \kore-sort-SortBool \kore-sort-SortBExp ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-VE4 kore-element-var-VE2 ) ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBlock \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( IMP-sort-8-is-pattern kore-element-var-VE1-elementvariable kore-dv-is-pattern in-sort-is-pattern IMP-sort-23-is-pattern string-literal-1-is-pattern IMP-symbol-128-is-pattern and-is-pattern kore-top-is-pattern IMP-symbol-129-is-pattern IMP-symbol-131-is-pattern typecode-cache-Pattern-178 IMP-symbol-126-is-pattern typecode-cache-Pattern-177 kore-and-is-pattern kore-element-var-x0-elementvariable KSEQ-symbol-1-is-pattern element-var-is-var IMP-sort-18-is-pattern BASIC-K-sort-0-is-pattern typecode-cache-Pattern-382 top-is-pattern typecode-cache-Pattern-146 typecode-cache-Pattern-383 kore-rewrites-is-pattern typecode-cache-Pattern-25 substitution-disjoint typecode-cache-Pattern-384 IMP-sort-32-is-pattern kore-inj-is-pattern kore-valid-is-pattern typecode-cache-Pattern-385 typecode-cache-Pattern-386 rule-imp-transitivity typecode-cache-Pattern-387 typecode-cache-Pattern-388 rule-and-intro-alt2-sugar IMP-sort-31-is-pattern BASIC-K-sort-1-is-pattern IMP-sort-22-is-pattern string-literal-5-is-pattern typecode-cache-Pattern-179 IMP-symbol-241-is-pattern and-elim-left-sugar IMP-symbol-129-substitution substitution-kore-and substitution-448 imp-reflexivity kore-element-var-V0-elementvariable KSEQ-symbol-0-is-pattern substitution-kore-rewrites substitution-kore-valid substitution-imp sorting-cache-1845 imp-is-pattern proof-rule-prop-1 KSEQ-symbol-1-sorting proof-rule-mp top-intro rule-weakening sorting-rearrange-1130 and-elim-right-sugar sorting-cache-1844 sorting-rearrange-1129 substitution-675 substitution-var-same KSEQ-symbol-0-substitution IMP-symbol-131-substitution substitution-676 IMP-symbol-126-substitution substitution-1095 substitution-681 substitution-1096 substitution-1098 functional-substitution-alt ) AQUBGBCUDKAQUBGBCUDKTUCGUEKKDDDDLABCUOHIFJMRDDLABUPHIFJMRUHUNAQUBGBCUDKAQUBGBCUDKTUCGUEKAQUBGBCUDKAQUBGBCUDAQUBGBCUDKAQUBGAQUBGAQUBGBCUDVGAQUBGVKUQABCVQUTAQUBGBCUDKTUCGUETUCGAQUBGBCUDKTUCGVRTUCGAQUBGBCUDKVSVTWAAQUBGBCUDKUEWBWCUTUTTDDDDLAECUGNBOPHIFJMRDDLAEUKNBOPHIFJMRUHUNDDDDLABCUOHIFJMRDDLABUPHIFJMRUHUNDDDDLACSURNBOPHIFJMRDDLASUSNBOPHIFJMRUHUNAQUBGBCUDKEUFUCGUEKTUCGUEKSUIUCGUEKVLESABCVLWDAQUBGBCUDKEUFUCGUEKKEUFUCGAQUBGBCUDKKDDDDLAECUGNBOPHIFJMRDDLAEUKNBOPHIFJMRUHUNAQUBGBCUDKEUFUCGUEKKEUFUCGAQUBGBCUDKAQUBGBCUDKEUFUCGUEKKEUFUCGUEKEUFUCGAQUBGBCUDKEUFUCGUEKWEEUFUCGUEKEUFUCGEUFUCGEUFUCGUEVGEUFUCGVKUQUQAQUBGBCUDKEUFUCGUEKKAQUBGBCUDAQUBGBCUDKEUFUCGUEKKAQUBGBCUDKAQUBGAQUBGBCUDKEUFUCGUEKVGAQUBGBCUDVGUQAEBCWFUTUTAEBCWGUQTTUCGUEKDDDDLABCUOHIFJMRDDLABUPHIFJMRUHUNEUFUCGUEKDDDDLAECUGNBOPHIFJMRDDLAEUKNBOPHIFJMRUHUNEUAEWHDDDDLABCUOHIFJMRDDLABUPHIFJMRUHDDDDLAECUGNBOPHIFJMRDDLAEUKNBOPHIFJMRUHTEUADTEUAUJDDDLABCUOHIFJMRDDLABUPHIFJMRDDDLAECUGNBOPHIFJMRDDLAEUKNBOPHIFJMRTEUADTEUAUJDDLABCUOHIFJMDDLAECUGNBOPHIFJMTEUADTEUAUJDLTEUAUJEUATABCUOHIFJAECUGNBOPHIFJEUATVAVBULVCULVDFUMCVEAQVFUMTVMNBOAECUGNBOEUATVAVBULVCULVDFUMCVEAQVFUMTVMAECUGEUATVAVBULVCULVDFUMCVEAQVFUMTVAVBULVCULVDFUMCVEAQVFUMEUFVAVBULVCULVDFUMCVEAQVFUMTEUAUJTEUAWIWJWKEBWLWMHIFJTEUAUJVHVIDDLABUPHIFJMDDLAEUKNBOPHIFJMTEUADTEUAUJDLTEUAUJEUATABUPHIFJAEUKNBOPHIFJAEBWNHIFJTEUAUJVHVIVNVOVPSUISUIUCGUEKDDDDLACSURNBOPHIFJMRDDLASUSNBOPHIFJMRUHUNEUFUCGUEKDDDDLAECUGNBOPHIFJMRDDLAEUKNBOPHIFJMRUHUNEUAESWODDDDLACSURNBOPHIFJMRDDLASUSNBOPHIFJMRUHDDDDLAECUGNBOPHIFJMRDDLAEUKNBOPHIFJMRUHSUIEUAESVJDDDLACSURNBOPHIFJMRDDLASUSNBOPHIFJMRDDDLAECUGNBOPHIFJMRDDLAEUKNBOPHIFJMRSUIEUAESVJDDLACSURNBOPHIFJMDDLAECUGNBOPHIFJMSUIEUAESVJDLSUIEUAUJEUASUIACSURNBOPHIFJAECUGNBOPHIFJAEBCSWPHIFJSUIEUAUJVHVIDDLASUSNBOPHIFJMDDLAEUKNBOPHIFJMSUIEUAESVJDLSUIEUAUJEUASUIASUSNBOPHIFJAEUKNBOPHIFJAEBSWQHIFJSUIEUAUJVHVIVNVOVPWRUQ $. $}
