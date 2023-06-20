$c #Substitution \top \kore-symbol-LblisKResult \kore-symbol-dotk \kore-symbol-kseq #Variable \kore-implies \kore-sort-SortBool \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-equals "false" \and \kore-and \unit-sort \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-in "true" \kore-inj \in-sort \kore-top ( $.
$v xX0 sg0 th0 ph6 kore-element-var-x0 ptn3 ptn2 ph8 ph3 ptn0 ph1 kore-sort-var-R ph0 ph2 xX x ptn4 ptn1 ph7 ph4 ph5 $.
$d kore-sort-var-R x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 kore-sort-var-R $.
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
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
element-var-is-var $a #Variable x $.
symbol-is-pattern $a #Pattern sg0 $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
unit-sort-is-symbol $a #Symbol \unit-sort $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
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
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-implies-is-pattern $a #Pattern ( \kore-implies ph0 ph1 ph2 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
${ substitution-kore-and.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-and.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-and.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-and $a #Substitution ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph3 ph4 ph5 ) ph6 xX $. $}
${ substitution-kore-implies.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-implies.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-implies.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-implies $a #Substitution ( \kore-implies ph0 ph1 ph2 ) ( \kore-implies ph3 ph4 ph5 ) ph6 xX $. $}
${ substitution-kore-in.0 $e #Substitution ph0 ph4 ph8 xX $.
   substitution-kore-in.1 $e #Substitution ph1 ph5 ph8 xX $.
   substitution-kore-in.2 $e #Substitution ph2 ph6 ph8 xX $.
   substitution-kore-in.3 $e #Substitution ph3 ph7 ph8 xX $.
   substitution-kore-in $a #Substitution ( \kore-in ph0 ph1 ph2 ph3 ) ( \kore-in ph4 ph5 ph6 ph7 ) ph8 xX $. $}
${ kore-equals-elim-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-equals-elim-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
   kore-equals-elim-alt.2 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-equals ph0 \unit-sort ph1 ph2 ) ) ) $.
   kore-equals-elim-alt.3 $e |- ( \imp th0 ( \kore-valid ph6 ph3 ) ) $.
   kore-equals-elim-alt.4 $e #Substitution ( \kore-valid ph6 ph3 ) ph4 ph1 x $.
   kore-equals-elim-alt.5 $e #Substitution ( \kore-valid ph7 ph5 ) ph4 ph2 x $.
   kore-equals-elim-alt $a |- ( \imp th0 ( \kore-valid ph7 ph5 ) ) $. $}
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-271-is-pattern $a #Pattern ( \kore-symbol-LblisKResult ptn0 ) $.
string-literal-0-is-pattern $a #Pattern "true" $.
string-literal-5-is-pattern $a #Pattern "false" $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
sorting-rearrange-1100 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem ( \kore-inj \kore-sort-SortBool \kore-sort-SortKResult ( \kore-dv \kore-sort-SortBool "false" ) ) ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $.
sorting-rearrange-1109 $a |- ( \imp \top ( \kore-valid \unit-sort ( \kore-equals \kore-sort-SortKItem \unit-sort ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem ( \kore-inj \kore-sort-SortBool \kore-sort-SortKResult ( \kore-dv \kore-sort-SortBool "false" ) ) ) ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) ) ) ) $.
sorting-cache-1820 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \in-sort ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem ( \kore-inj \kore-sort-SortBool \kore-sort-SortKResult ( \kore-dv \kore-sort-SortBool "false" ) ) ) \kore-sort-SortKItem ) ) $.
sorting-cache-1822 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \in-sort ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-sort-SortKItem ) ) $.
${ sorting-rearrange-1110 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-dv \kore-sort-SortBool "false" ) ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $= ( IMP-sort-32-is-pattern typecode-cache-Pattern-0 kore-inj-is-pattern kore-dv-is-pattern BASIC-K-sort-1-is-pattern string-literal-5-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern kore-top-is-pattern IMP-sort-28-is-pattern kore-element-var-x0-elementvariable and-is-pattern top-is-pattern kore-and-is-pattern element-var-is-var kore-is-sort-is-pattern BASIC-K-sort-0-is-pattern substitution-disjoint kore-in-is-pattern kore-equals-is-pattern IMP-symbol-271-is-pattern string-literal-0-is-pattern typecode-cache-Pattern-25 kore-implies-is-pattern rule-imp-transitivity kore-valid-is-pattern substitution-kore-and top-intro rule-weakening rule-and-intro-alt2-sugar sorting-cache-133 unit-sort-is-symbol symbol-is-pattern and-elim-left-sugar substitution-var-same KSEQ-symbol-0-substitution substitution-kore-in substitution-kore-implies substitution-kore-valid sorting-cache-1820 sorting-cache-1822 sorting-rearrange-1109 imp-reflexivity sorting-rearrange-1100 kore-equals-elim-alt ) ACQNMACQNMACQNMNMMACACACACJACRACBFBGEDHIBFBGEDHITACJOOACBACBFBGEDHIUBBUCEUAACJOUEUGACQNMACQNMACQNMNMAULACQNMACQNMNAULACQNMNUIUJUKUKFKFBKBGEDDBFBGEDACACACJACRACBFBGEDHIKFBKBGEDDHITACJOOACBACBFBGEDHIUBBUCEUAACJOUEACACACACJACRACBFBGEDHILUDHITACJOOACBACBFBGEDHIUBBUCEUAACJOUEUGACACACJACRACBFBGEDHIBFBGEDHITACJOOACBACBFBGEDHIUBBUCEUAACJOUEACACACQNMACQNMNMMLAVAAVBACQNMACQNMNMMNUMUNFUMUNKFBKBGEDDBFBGEDUAUGACQNMACQNMNMMNUIUJVCUFACQNMACQNMNMMACQNMACACACACJACRACBFBGEDHIKFBKBGEDDHITACJOOACBACBFBGEDHIUBBUCEUAACJOUEUGACQNMACQNMNMMACQNACQNMACQNMNMMACQNMACQACQNMACQNMNMUOACQNMACQACQACQNUOACQVDUFUFACQNMACQNMNMMNUIUJUKAVEUFACACACACJACRACBFBGEDHIKFBKBGEDDHITACJOOACBACBFBGEDHIUBBUCEUAACJOUEACACACACJACRACBFBGEDHILUDHITACJOOACBACBFBGEDHIUBBUCEUAACJOUEKFBKBGEDDLPACKFBKBGEDDLPSACACACJACRACBFBGEDHIKFBKBGEDDHITACJOOACBACBFBGEDHIUBBUCEUAACJOACACACJACRACBFBGEDHILUDHITACJOOACBACBFBGEDHIUBBUCEUAACJOKFBKBGEDDLPACKFBKBGEDDLPSACACJACRACBFBGEDHIKFBKBGEDDHITACJOACACJACRACBFBGEDHILUDHITACJOKFBKBGEDDLPACKFBKBGEDDLPSACJKFBKBGEDDLPSACRACBFBGEDHIKFBKBGEDDHITACJACRACBFBGEDHILUDHITACJKFBKBGEDDLPACKFBKBGEDDLPSRACBFBGEDHIKFBKBGEDDHIRACBFBGEDHILUDHIKFBKBGEDDLPRKFBKBGEDDLPSACKFBKBGEDDLPSBFBGEDHIKFBKBGEDDLPSLPKFBKBGEDDKFBKBGEDDHLUDHKFBKBGEDDLPUPHKFBKBGEDDLPSUQURACJKFBKBGEDDLPSUHUHACBACBFBGEDHIUBBUCEUAACJOKFBKBGEDDLPSUSUTACACACACJACRACBFBGEDHIBFBGEDHITACJOOACBACBFBGEDHIUBBUCEUAACJOUEACACACACJACRACBFBGEDHILUDHITACJOOACBACBFBGEDHIUBBUCEUAACJOUEBFBGEDLPACBFBGEDLPSACACACJACRACBFBGEDHIBFBGEDHITACJOOACBACBFBGEDHIUBBUCEUAACJOACACACJACRACBFBGEDHILUDHITACJOOACBACBFBGEDHIUBBUCEUAACJOBFBGEDLPACBFBGEDLPSACACJACRACBFBGEDHIBFBGEDHITACJOACACJACRACBFBGEDHILUDHITACJOBFBGEDLPACBFBGEDLPSACJBFBGEDLPSACRACBFBGEDHIBFBGEDHITACJACRACBFBGEDHILUDHITACJBFBGEDLPACBFBGEDLPSRACBFBGEDHIBFBGEDHIRACBFBGEDHILUDHIBFBGEDLPRBFBGEDLPSACBFBGEDLPSBFBGEDHIBFBGEDLPSLPBFBGEDBFBGEDHLUDHBFBGEDLPUPHBFBGEDLPSUQURACJBFBGEDLPSUHUHACBACBFBGEDHIUBBUCEUAACJOBFBGEDLPSUSUTVFUF $. $}
