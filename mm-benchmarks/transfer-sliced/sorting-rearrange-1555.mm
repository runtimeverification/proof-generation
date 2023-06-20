$c \top \kore-symbol-LblisKResult "210" \kore-symbol-dotk \kore-symbol-kseq #Variable \kore-implies \kore-sort-SortBool \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-valid ) \kore-equals \and \kore-and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-in "true" \kore-inj \kore-sort-SortInt \kore-top ( $.
$v kore-sort-var-R ph0 ph2 th0 ptn1 ph3 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
th0-is-pattern $f #Pattern th0 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
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
${ kore-mp-alt.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
   kore-mp-alt.1 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
   kore-mp-alt $a |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-271-is-pattern $a #Pattern ( \kore-symbol-LblisKResult ptn0 ) $.
string-literal-0-is-pattern $a #Pattern "true" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
string-literal-20-is-pattern $a #Pattern "210" $.
sorting-rearrange-1551 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $.
sorting-rearrange-1554 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $.
${ sorting-rearrange-1555 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-LblisKResult ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "210" ) ) \kore-symbol-dotk ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-top kore-sort-var-R ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern IMP-sort-23-is-pattern kore-dv-is-pattern BASIC-K-sort-1-is-pattern string-literal-20-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern kore-top-is-pattern kore-and-is-pattern IMP-sort-32-is-pattern rule-imp-transitivity rule-and-intro-alt2-sugar IMP-symbol-271-is-pattern string-literal-0-is-pattern kore-equals-is-pattern kore-valid-is-pattern sorting-cache-133 BASIC-K-sort-0-is-pattern kore-in-is-pattern and-elim-left-sugar top-intro rule-weakening kore-implies-is-pattern imp-reflexivity sorting-rearrange-1551 sorting-rearrange-1554 kore-mp-alt ) ABEDCABEDCABEDCABEDCDCCCABABOABFHFIGJKLROSGTABMNUAABEDCABEDCABEDCABEDCDCCAUBABEDCABEDCABEDCDCAUBABEDCABEDCDAUBABEDCDUFUGQQQABABABMABUCABFHFIGJKLFHFIGJKLUDABMNNABOABFHFIGJKLROSGTABMNABEDCABEDCABEDCDCCCABEDCABEDCABEDCDCCCABEDCABABABABMABUCABFHFIGJKLFHFIGJKLUDABMNNABOABFHFIGJKLROSGTABMNUHUAABEDCABEDCABEDCDCCCABEDABEDCABEDCABEDCDCCCABEDCABEABEDCABEDCABEDCDCCUEABEDCABEABEABEDUEABEUIPPABEDCABEDCABEDCDCCCDUFUGQAUJPABEDCABEDCABEDCDCCCABEDCABABABMABUCABFHFIGJKLFHFIGJKLUDABMNNUAABEDCABEDCABEDCDCCUEAUKPULP $. $}
