$c \top \kore-symbol-dotk \kore-symbol-kseq #Variable "90" \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-valid ) \and \kore-and #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem \kore-in \kore-inj \kore-sort-SortInt \in-sort \kore-top ( $.
$v kore-sort-var-R ph0 ph2 th0 ptn1 ph3 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
th0-is-pattern $f #Pattern th0 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
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
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-top-sorting $a |- ( \in-sort ( \kore-top ph0 ) ph0 ) $.
kore-and-sorting $a |- ( \imp ( \and ( \in-sort ph1 ph0 ) ( \in-sort ph2 ph0 ) ) ( \in-sort ( \kore-and ph0 ph1 ph2 ) ph0 ) ) $.
kore-in-sorting $a |- ( \in-sort ( \kore-in ph0 ph1 ph2 ph3 ) ph1 ) $.
kore-top-valid $a |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $.
${ kore-and-intro-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   kore-and-intro-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
   kore-and-intro-alt.2 $e |- ( \imp th0 ( \kore-valid ph0 ph1 ) ) $.
   kore-and-intro-alt.3 $e |- ( \imp th0 ( \kore-valid ph0 ph2 ) ) $.
   kore-and-intro-alt $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-and ph0 ph1 ph2 ) ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
string-literal-19-is-pattern $a #Pattern "90" $.
sorting-rearrange-1280 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) $.
${ sorting-rearrange-1281 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "90" ) ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern IMP-sort-23-is-pattern BASIC-K-sort-1-is-pattern string-literal-19-is-pattern kore-dv-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern kore-top-is-pattern in-sort-is-pattern BASIC-K-sort-0-is-pattern kore-in-is-pattern rule-imp-transitivity kore-and-is-pattern rule-and-intro-alt2-sugar kore-valid-is-pattern sorting-cache-133 rule-weakening imp-is-pattern proof-rule-prop-1 proof-rule-mp and-elim-left-sugar top-intro kore-top-sorting kore-in-sorting kore-and-sorting imp-reflexivity kore-top-valid sorting-rearrange-1280 kore-and-intro-alt ) ABEDCABEDCABEDCABEDCDCCCABABABMABOABFGFHIJKLFGFHIJKLPABMRRTABEDCABEDCABEDCABEDCDCCAUAABEDCABEDCABEDCDCAUAABEDCABEDCDAUAABEDCDUGUBSSSABABMABOABFGFHIJKLFGFHIJKLPABMRABEDCABEDCABEDCDCCCABMABNABEDCABEDCABEDCDCCCABMABNUCABMABNABEDCABEDCABEDCDCCCUDABUHUEABEDCABEDCABEDCDCCCOABFGFHIJKLFGFHIJKLPABNABMABNCABOABFGFHIJKLFGFHIJKLPABMRABNABEDCABEDCABEDCDCCCOABFGFHIJKLFGFHIJKLPABNABMABNOABFGFHIJKLFGFHIJKLPABNABEDCABEDCABEDCDCCCOABFGFHIJKLFGFHIJKLPABNUCOABFGFHIJKLFGFHIJKLPABNABEDCABEDCABEDCDCCCUDOABFGFHIJKLFGFHIJKLUIUEABMABNABEDCABEDCABEDCDCCCABMABNUCABMABNABEDCABEDCABEDCDCCCUDABUHUESABOABFGFHIJKLFGFHIJKLPABMUJQABEDCABEDCABEDCDCCCABEDCABABMTABEDCABEDCABEDCDCCCABEDABEDCABEDCABEDCDCCCABEDCABEABEDCABEDCABEDCDCCUFABEDCABEABEABEDUFABEUKQQABEDCABEDCABEDCDCCCDUGUBSABEDCABABMTABULUBQABEDCABEDCABEDCDCCCABEDCABABOABFGFHIJKLFGFHIJKLPABMRTABEDCABEDCABEDCDCCUFAUMQUNQ $. $}
