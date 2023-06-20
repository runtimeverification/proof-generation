$c #Substitution #SetVariable #ElementVariable #Symbol \kore-symbol-kseq \kore-sort-SortStmt #Variable #Pattern \kore-sort-SortKItem ) \kore-symbol-Lbl'-LT-'k'-GT-' \kore-inj \kore-symbol-dotk ( $.
$v ph0 ph2 xX xX0 x kore-element-var-VE1 ptn4 kore-element-var-VE2 ptn1 ptn3 ptn2 ptn0 ph1 $.
$d x kore-element-var-VE1 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE2 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
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
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
${ IMP-symbol-131-substitution.0 $e #Substitution ptn1 ptn2 ptn0 xX0 $.
   IMP-symbol-131-substitution $a #Substitution ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn1 ) ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn2 ) ptn0 xX0 $. $}
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-227 $a #Pattern ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE2 ) kore-element-var-VE1 ) $.
${ substitution-678 $p #Substitution ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem kore-element-var-VE2 ) kore-element-var-VE1 ) ) \kore-symbol-dotk kore-element-var-VE1 $= ( KSEQ-symbol-1-is-pattern element-var-is-var IMP-sort-31-is-pattern BASIC-K-sort-1-is-pattern typecode-cache-Pattern-177 kore-inj-is-pattern KSEQ-symbol-0-is-pattern typecode-cache-Pattern-227 typecode-cache-Pattern-146 substitution-disjoint substitution-var-same KSEQ-symbol-0-substitution IMP-symbol-131-substitution ) BDCEFAGHCIABJBDCEFAGHCEFAGHBKEFAGHCBDLCBDMNO $. $}
