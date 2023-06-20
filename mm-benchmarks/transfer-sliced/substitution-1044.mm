$c #Substitution #SetVariable #ElementVariable #Symbol \kore-symbol-kseq #Variable #Pattern \kore-exists \kore-sort-SortBool \kore-sort-SortK \kore-sort-SortKItem \kore-dv ) \kore-equals \kore-inj "false" ( $.
$v kore-element-var-V0 xX0 ph6 ptn3 ptn2 kore-element-var-V1 ph8 ptn0 ph3 ph1 kore-sort-var-R kore-element-var-V2 ph0 ph2 xX x ptn4 ptn1 y ph7 ph4 ph5 $.
$d kore-element-var-V0 x $.
$d kore-element-var-V0 kore-element-var-V1 $.
$d kore-element-var-V2 kore-element-var-V1 $.
$d kore-sort-var-R kore-element-var-V2 $.
$d kore-sort-var-R kore-element-var-V0 $.
$d y kore-element-var-V1 $.
$d kore-element-var-V2 x $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-sort-var-R kore-element-var-V1 $.
$d y kore-element-var-V2 $.
$d kore-element-var-V1 x $.
$d kore-element-var-V2 kore-element-var-V0 $.
$d y kore-sort-var-R $.
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
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ $d xX y $.
   $d y ph6 $.
   substitution-kore-exists-alt.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-exists-alt.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-exists-alt.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-exists-alt $a #Substitution ( \kore-exists ph0 ph1 y ph2 ) ( \kore-exists ph3 ph4 y ph5 ) ph6 xX $. $}
${ substitution-kore-equals.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-equals.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-equals.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-equals.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-equals $a #Substitution ( \kore-equals ph0 ph1 ph2 ph3 ) ( \kore-equals ph4 ph5 ph6 ph7 ) ph8 xX $. $}
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V0-elementvariable $f #ElementVariable kore-element-var-V0 $.
kore-element-var-V1-elementvariable $f #ElementVariable kore-element-var-V1 $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
string-literal-5-is-pattern $a #Pattern "false" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-35 $a #Pattern kore-element-var-V2 $.
typecode-cache-Pattern-37 $a #Pattern kore-element-var-V1 $.
typecode-cache-Pattern-39 $a #Pattern kore-element-var-V0 $.
typecode-cache-Pattern-158 $a #Pattern ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) $.
typecode-cache-Pattern-159 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) $.
typecode-cache-Pattern-373 $a #Pattern ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V2 ) ) $.
${ substitution-1044 $p #Substitution ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V2 ) ) ) ( \kore-exists \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-equals \kore-sort-SortK kore-sort-var-R kore-element-var-V0 ( \kore-symbol-kseq kore-element-var-V1 kore-element-var-V2 ) ) ) ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) kore-element-var-V1 $= ( IMP-sort-32-is-pattern BASIC-K-sort-1-is-pattern string-literal-5-is-pattern kore-dv-is-pattern kore-inj-is-pattern element-var-is-var BASIC-K-sort-0-is-pattern typecode-cache-Pattern-0 substitution-disjoint typecode-cache-Pattern-35 typecode-cache-Pattern-39 typecode-cache-Pattern-373 typecode-cache-Pattern-159 KSEQ-symbol-0-is-pattern typecode-cache-Pattern-158 typecode-cache-Pattern-37 substitution-var-same KSEQ-symbol-0-substitution substitution-kore-equals substitution-kore-exists-alt ) KALABDPKALABCDQEFEGHIBCJKEFEGHICJMALEFEGHICJMKALBOEFEGHIDNRKALBOCDSEFEGHICJKEFEGHICJMALEFEGHICJMBOEFEGHICJMCJEFEGHIEFEGHIDNCTDNEFEGHICJUADNEFEGHICJMUBUCUD $. $}
