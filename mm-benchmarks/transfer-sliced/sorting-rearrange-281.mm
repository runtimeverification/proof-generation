$c \top \kore-symbol-Lbl'-LT-'state'-GT-' #Variable \kore-implies \imp \kore-is-sort |- \kore-valid ) \kore-equals \and \kore-and \kore-symbol-LblinitStateCell \kore-symbol-Lbl'Stop'Map #SetVariable #ElementVariable #Symbol #Pattern \kore-top \kore-sort-SortStateCell ( $.
$v kore-sort-var-R ph0 ph2 th0 ph3 ptn0 ph1 $.
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
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
${ kore-mp-alt.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
   kore-mp-alt.1 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
   kore-mp-alt $a |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $. $}
ptn0-pattern $f #Pattern ptn0 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
IMP-symbol-132-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) $.
IMP-symbol-245-is-pattern $a #Pattern \kore-symbol-LblinitStateCell $.
IMP-axiom-3292 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-top kore-sort-var-R ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortStateCell kore-sort-var-R \kore-symbol-LblinitStateCell ( \kore-symbol-Lbl'-LT-'state'-GT-' \kore-symbol-Lbl'Stop'Map ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
sorting-rearrange-280 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-top kore-sort-var-R ) ) ) ) $.
${ sorting-rearrange-281 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortStateCell kore-sort-var-R \kore-symbol-LblinitStateCell ( \kore-symbol-Lbl'-LT-'state'-GT-' \kore-symbol-Lbl'Stop'Map ) ) ( \kore-top kore-sort-var-R ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern kore-top-is-pattern kore-and-is-pattern rule-imp-transitivity rule-and-intro-alt2-sugar IMP-sort-9-is-pattern IMP-symbol-245-is-pattern IMP-symbol-124-is-pattern IMP-symbol-132-is-pattern kore-equals-is-pattern kore-valid-is-pattern sorting-cache-133 and-elim-left-sugar top-intro rule-weakening kore-implies-is-pattern imp-reflexivity IMP-axiom-3292 sorting-rearrange-280 kore-mp-alt ) ABEDCABEDCABEDCABEDCDCCCABABJABKLMNABFGOABEDCABEDCABEDCABEDCDCCAPABEDCABEDCABEDCDCAPABEDCABEDCDAPABEDCDRSIIIABABABFABFGABJABKLMNABFGABEDCABEDCABEDCDCCCABEDCABEDCABEDCDCCCABEDCABABABABFABFGABJABKLMNABFGTOABEDCABEDCABEDCDCCCABEDABEDCABEDCABEDCDCCCABEDCABEABEDCABEDCABEDCDCCQABEDCABEABEABEDQABEUAHHABEDCABEDCABEDCDCCCDRSIAUBHABEDCABEDCABEDCDCCCABEDCABABABFABFGOABEDCABEDCABEDCDCCQAUCHUDH $. $}
