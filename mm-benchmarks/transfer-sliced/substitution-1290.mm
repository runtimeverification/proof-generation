$c "1" #Substitution #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol \kore-symbol-kseq \kore-sort-SortStmt #Variable #Pattern \kore-sort-SortKItem \kore-dv ) \kore-inj \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \kore-sort-SortInt \kore-symbol-dotk ( $.
$v xX0 kore-element-var-VE3 ph6 kore-element-var-x0 ptn3 ptn2 ph3 ptn0 ph1 ph0 ph2 xX x ptn4 ptn1 ph4 ph5 $.
$d kore-element-var-VE3 x $.
$d kore-element-var-x0 kore-element-var-VE3 $.
$d kore-element-var-x0 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ substitution-kore-inj.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-inj.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-inj.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-inj $a #Substitution ( \kore-inj ph0 ph1 ph2 ) ( \kore-inj ph3 ph4 ph5 ) ph6 xX $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
${ KSEQ-symbol-0-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   KSEQ-symbol-0-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   KSEQ-symbol-0-substitution $a #Substitution ( \kore-symbol-kseq ptn1 ptn2 ) ( \kore-symbol-kseq ptn3 ptn4 ) ptn0 xX0 $. $}
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
${ IMP-symbol-185-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-185-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-185-substitution $a #Substitution ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn1 ptn2 ) ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn3 ptn4 ) ptn0 xX0 $. $}
string-literal-4-is-pattern $a #Pattern "1" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
substitution-559 $a #Substitution \kore-sort-SortStmt \kore-sort-SortStmt kore-element-var-x0 kore-element-var-VE3 $.
substitution-565 $a #Substitution \kore-sort-SortKItem \kore-sort-SortKItem kore-element-var-x0 kore-element-var-VE3 $.
substitution-567 $a #Substitution \kore-symbol-dotk \kore-symbol-dotk kore-element-var-x0 kore-element-var-VE3 $.
${ substitution-1290 $p #Substitution ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp kore-element-var-x0 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp kore-element-var-VE3 ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) kore-element-var-x0 kore-element-var-VE3 $= ( IMP-sort-23-is-pattern kore-inj-is-pattern typecode-cache-Pattern-25 IMP-sort-13-is-pattern string-literal-4-is-pattern kore-dv-is-pattern element-var-is-var IMP-sort-31-is-pattern BASIC-K-sort-1-is-pattern IMP-symbol-185-is-pattern typecode-cache-Pattern-178 KSEQ-symbol-1-is-pattern substitution-559 substitution-565 substitution-var-same substitution-disjoint IMP-symbol-185-substitution substitution-kore-inj substitution-567 KSEQ-symbol-0-substitution ) AIBEJKBECFCGHDLDNJKAMCFCGHDLDNJKBECFCGHDLJKAMCFCGHDLBEAIABOABPAIBEBECFCGHDAMCFCGHDBEAIQCFCGHDBEAIRSTABUAUB $. $}
