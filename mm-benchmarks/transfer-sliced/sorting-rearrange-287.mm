$c \top #Variable \kore-implies \imp \kore-dv "0" \kore-is-sort |- \kore-valid ) \kore-equals \and \kore-and #SetVariable #ElementVariable \kore-symbol-LblinitGeneratedCounterCell #Symbol #Pattern \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' \kore-sort-SortGeneratedCounterCell \kore-sort-SortInt \kore-top ( $.
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
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
${ kore-mp-alt.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
   kore-mp-alt.1 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
   kore-mp-alt $a |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $. $}
ptn0-pattern $f #Pattern ptn0 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-128-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ptn0 ) $.
IMP-symbol-242-is-pattern $a #Pattern \kore-symbol-LblinitGeneratedCounterCell $.
string-literal-1-is-pattern $a #Pattern "0" $.
IMP-axiom-3289 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-top kore-sort-var-R ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R \kore-symbol-LblinitGeneratedCounterCell ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
sorting-rearrange-280 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-top kore-sort-var-R ) ) ) ) $.
${ sorting-rearrange-287 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortGeneratedCounterCell kore-sort-var-R \kore-symbol-LblinitGeneratedCounterCell ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ( \kore-top kore-sort-var-R ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern kore-top-is-pattern kore-and-is-pattern rule-imp-transitivity rule-and-intro-alt2-sugar IMP-sort-10-is-pattern IMP-symbol-242-is-pattern IMP-sort-23-is-pattern string-literal-1-is-pattern kore-dv-is-pattern IMP-symbol-128-is-pattern kore-equals-is-pattern kore-valid-is-pattern sorting-cache-133 and-elim-left-sugar top-intro rule-weakening kore-implies-is-pattern imp-reflexivity IMP-axiom-3289 sorting-rearrange-280 kore-mp-alt ) ABEDCABEDCABEDCABEDCDCCCABABJABKLMNOPABFGQABEDCABEDCABEDCABEDCDCCARABEDCABEDCABEDCDCARABEDCABEDCDARABEDCDTUAIIIABABABFABFGABJABKLMNOPABFGABEDCABEDCABEDCDCCCABEDCABEDCABEDCDCCCABEDCABABABABFABFGABJABKLMNOPABFGUBQABEDCABEDCABEDCDCCCABEDABEDCABEDCABEDCDCCCABEDCABEABEDCABEDCABEDCDCCSABEDCABEABEABEDSABEUCHHABEDCABEDCABEDCDCCCDTUAIAUDHABEDCABEDCABEDCDCCCABEDCABABABFABFGQABEDCABEDCABEDCDCCSAUEHUFH $. $}
