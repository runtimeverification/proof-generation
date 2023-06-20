$c \top \kore-sort-SortKConfigVar \kore-symbol-kseq #Variable \kore-implies \kore-symbol-LblMap'Coln'lookup \imp \kore-dv \kore-sort-SortPgm \kore-is-sort |- \kore-valid ) \kore-equals \kore-symbol-Lbl'-LT-'k'-GT-' \and \kore-sort-SortKCell \kore-and \kore-symbol-Lblproject'Coln'Pgm #SetVariable \kore-top #ElementVariable "%24PGM" #Symbol \kore-symbol-LblinitKCell #Pattern \kore-sort-SortKItem \kore-in \kore-inj \in-sort \kore-symbol-dotk \kore-sort-SortMap ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-VE1 ptn1 kore-element-var-VE0 ptn0 ph3 ph1 $.
$d kore-sort-var-R kore-element-var-VE1 $.
$d kore-sort-var-R kore-element-var-VE0 $.
$d kore-element-var-VE0 kore-element-var-VE1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-implies-is-pattern $a #Pattern ( \kore-implies ph0 ph1 ph2 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE0-elementvariable $f #ElementVariable kore-element-var-VE0 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
IMP-sort-7-is-pattern $a #Pattern \kore-sort-SortKCell $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-20-is-pattern $a #Pattern \kore-sort-SortKConfigVar $.
IMP-sort-27-is-pattern $a #Pattern \kore-sort-SortPgm $.
IMP-symbol-131-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn0 ) $.
IMP-symbol-142-is-pattern $a #Pattern ( \kore-symbol-LblMap'Coln'lookup ptn0 ptn1 ) $.
IMP-symbol-244-is-pattern $a #Pattern ( \kore-symbol-LblinitKCell ptn0 ) $.
IMP-symbol-326-is-pattern $a #Pattern ( \kore-symbol-Lblproject'Coln'Pgm ptn0 ) $.
string-literal-9-is-pattern $a #Pattern "%24PGM" $.
IMP-axiom-3291 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortMap kore-sort-var-R kore-element-var-VE0 kore-element-var-VE1 ) ( \kore-top kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortKCell kore-sort-var-R ( \kore-symbol-LblinitKCell kore-element-var-VE0 ) ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblproject'Coln'Pgm ( \kore-symbol-kseq ( \kore-symbol-LblMap'Coln'lookup kore-element-var-VE1 ( \kore-inj \kore-sort-SortKConfigVar \kore-sort-SortKItem ( \kore-dv \kore-sort-SortKConfigVar "%24PGM" ) ) ) \kore-symbol-dotk ) ) ) \kore-symbol-dotk ) ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-147 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) $.
typecode-cache-Pattern-148 $a #Pattern kore-element-var-VE0 $.
sorting-cache-434 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-436 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-149 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-150 $a #Pattern ( \kore-in \kore-sort-SortMap kore-sort-var-R kore-element-var-VE0 kore-element-var-VE1 ) $.
${ sorting-rearrange-270 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortMap kore-sort-var-R kore-element-var-VE0 kore-element-var-VE1 ) ( \kore-top kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortKCell kore-sort-var-R ( \kore-symbol-LblinitKCell kore-element-var-VE0 ) ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortPgm \kore-sort-SortKItem ( \kore-symbol-Lblproject'Coln'Pgm ( \kore-symbol-kseq ( \kore-symbol-LblMap'Coln'lookup kore-element-var-VE1 ( \kore-inj \kore-sort-SortKConfigVar \kore-sort-SortKItem ( \kore-dv \kore-sort-SortKConfigVar "%24PGM" ) ) ) \kore-symbol-dotk ) ) ) \kore-symbol-dotk ) ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern typecode-cache-Pattern-148 IMP-sort-14-is-pattern in-sort-is-pattern typecode-cache-Pattern-147 top-is-pattern kore-top-is-pattern kore-and-is-pattern BASIC-K-sort-1-is-pattern typecode-cache-Pattern-146 IMP-sort-20-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern kore-is-sort-is-pattern rule-imp-transitivity typecode-cache-Pattern-149 typecode-cache-Pattern-150 IMP-sort-7-is-pattern IMP-symbol-244-is-pattern IMP-sort-27-is-pattern string-literal-9-is-pattern kore-dv-is-pattern IMP-symbol-142-is-pattern IMP-symbol-326-is-pattern IMP-symbol-131-is-pattern kore-equals-is-pattern kore-implies-is-pattern kore-valid-is-pattern and-elim-left-sugar sorting-cache-434 sorting-cache-436 rule-and-intro-alt2-sugar IMP-axiom-3291 ) ACIBFGHJEEABCUAADADADADKADABCUBADKLLADUCADBFUDUEMCNOMOUFUGPUHQRUIPQRUJUKADKLULUMACIBFGHJEEADSBFGHCNGHJEEACIBFGHJEEACIADSACIBFGHJEUNACUOTABCUPUQABCURT $. $}
