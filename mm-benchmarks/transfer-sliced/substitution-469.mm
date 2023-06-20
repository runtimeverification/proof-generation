$c #Substitution \kore-symbol-Lblproject'Coln'Pgm #SetVariable \kore-sort-SortKConfigVar #ElementVariable "%24PGM" #Symbol \kore-symbol-kseq #Variable #Pattern \kore-sort-SortKItem \kore-symbol-LblMap'Coln'lookup \kore-sort-SortPgm \kore-dv ) \kore-inj \kore-symbol-dotk ( $.
$v xX0 kore-element-var-VE1 ph6 kore-element-var-x0 ptn3 ptn2 ph3 ptn0 ph1 ph0 ph2 xX x ptn4 ptn1 ph4 ph5 $.
$d x kore-element-var-VE1 $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 kore-element-var-VE1 $.
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
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
${ KSEQ-symbol-0-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   KSEQ-symbol-0-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   KSEQ-symbol-0-substitution $a #Substitution ( \kore-symbol-kseq ptn1 ptn2 ) ( \kore-symbol-kseq ptn3 ptn4 ) ptn0 xX0 $. $}
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
IMP-sort-20-is-pattern $a #Pattern \kore-sort-SortKConfigVar $.
IMP-sort-27-is-pattern $a #Pattern \kore-sort-SortPgm $.
IMP-symbol-142-is-pattern $a #Pattern ( \kore-symbol-LblMap'Coln'lookup ptn0 ptn1 ) $.
${ IMP-symbol-142-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   IMP-symbol-142-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   IMP-symbol-142-substitution $a #Substitution ( \kore-symbol-LblMap'Coln'lookup ptn1 ptn2 ) ( \kore-symbol-LblMap'Coln'lookup ptn3 ptn4 ) ptn0 xX0 $. $}
IMP-symbol-326-is-pattern $a #Pattern ( \kore-symbol-Lblproject'Coln'Pgm ptn0 ) $.
${ IMP-symbol-326-substitution.0 $e #Substitution ptn1 ptn2 ptn0 xX0 $.
   IMP-symbol-326-substitution $a #Substitution ( \kore-symbol-Lblproject'Coln'Pgm ptn1 ) ( \kore-symbol-Lblproject'Coln'Pgm ptn2 ) ptn0 xX0 $. $}
string-literal-9-is-pattern $a #Pattern "%24PGM" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
substitution-466 $a #Substitution \kore-sort-SortPgm \kore-sort-SortPgm kore-element-var-x0 kore-element-var-VE1 $.
substitution-467 $a #Substitution \kore-sort-SortKItem \kore-sort-SortKItem kore-element-var-x0 kore-element-var-VE1 $.
substitution-468 $a #Substitution \kore-symbol-dotk \kore-symbol-dotk kore-element-var-x0 kore-element-var-VE1 $.
${ substitution-469 $p #Substitution ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblproject'Coln'Pgm ( \kore-symbol-kseq ( \kore-symbol-LblMap'Coln'lookup kore-element-var-x0 ( \kore-inj \kore-sort-SortKConfigVar \kore-sort-SortKItem ( \kore-dv \kore-sort-SortKConfigVar "%24PGM" ) ) ) \kore-symbol-dotk ) ) ) ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblproject'Coln'Pgm ( \kore-symbol-kseq ( \kore-symbol-LblMap'Coln'lookup kore-element-var-VE1 ( \kore-inj \kore-sort-SortKConfigVar \kore-sort-SortKItem ( \kore-dv \kore-sort-SortKConfigVar "%24PGM" ) ) ) \kore-symbol-dotk ) ) ) kore-element-var-x0 kore-element-var-VE1 $= ( IMP-sort-20-is-pattern BASIC-K-sort-1-is-pattern typecode-cache-Pattern-25 string-literal-9-is-pattern kore-dv-is-pattern kore-inj-is-pattern IMP-symbol-142-is-pattern KSEQ-symbol-1-is-pattern element-var-is-var KSEQ-symbol-0-is-pattern typecode-cache-Pattern-146 IMP-sort-27-is-pattern IMP-symbol-326-is-pattern substitution-466 substitution-467 substitution-var-same substitution-disjoint IMP-symbol-142-substitution substitution-468 KSEQ-symbol-0-substitution IMP-symbol-326-substitution substitution-kore-inj ) NDBECDCFGHIJLONDAMCDCFGHIJLOBEAKABPABQAKBEBECDCFGHIJLAMCDCFGHIJLAKBEBECDCFGHIJAMCDCFGHIJAKBEBECDCFGHAMCDCFGHBEAKRCDCFGHBEAKSTABUAUBUCUD $. $}
