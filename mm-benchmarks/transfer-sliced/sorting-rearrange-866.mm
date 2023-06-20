$c "amount" \top \kore-symbol-dotk \kore-symbol-kseq #Variable \kore-bottom \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid ) \and \kore-and \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Pattern \kore-or \kore-exists \kore-not \kore-sort-SortKItem \kore-in \kore-inj \kore-top ( $.
$v kore-sort-var-R ph0 ph2 x th0 kore-element-var-VE2 ptn1 ph3 ptn0 ph1 $.
$d kore-sort-var-R x $.
$d kore-sort-var-R kore-element-var-VE2 $.
$d kore-element-var-VE2 x $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
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
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-bottom-is-pattern $a #Pattern ( \kore-bottom ph0 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-not-is-pattern $a #Pattern ( \kore-not ph0 ph1 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-or-is-pattern $a #Pattern ( \kore-or ph0 ph1 ph2 ) $.
kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-not-bot $a |- ( \kore-valid ph0 ( \kore-not ph0 ( \kore-bottom ph0 ) ) ) $.
${ kore-de-morgan-alt.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-not ph0 ph1 ) ) ) $.
   kore-de-morgan-alt.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-not ph0 ph2 ) ) ) $.
   kore-de-morgan-alt $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-not ph0 ( \kore-or ph0 ph1 ph2 ) ) ) ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
string-literal-14-is-pattern $a #Pattern "amount" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
sorting-rearrange-865 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-not kore-sort-var-R ( \kore-exists \kore-sort-SortKResult kore-sort-var-R kore-element-var-VE2 ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) ) ) $.
${ sorting-rearrange-866 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-not kore-sort-var-R ( \kore-or kore-sort-var-R ( \kore-exists \kore-sort-SortKResult kore-sort-var-R kore-element-var-VE2 ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ( \kore-top kore-sort-var-R ) ) ) ) ( \kore-bottom kore-sort-var-R ) ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern top-is-pattern kore-is-sort-is-pattern IMP-sort-28-is-pattern kore-top-is-pattern IMP-sort-17-is-pattern BASIC-K-sort-1-is-pattern kore-inj-is-pattern KSEQ-symbol-1-is-pattern KSEQ-symbol-0-is-pattern kore-and-is-pattern rule-imp-transitivity kore-bottom-is-pattern kore-not-is-pattern kore-valid-is-pattern rule-and-intro-alt2-sugar BASIC-K-sort-0-is-pattern string-literal-14-is-pattern kore-dv-is-pattern typecode-cache-Pattern-177 kore-in-is-pattern kore-exists-is-pattern sorting-cache-133 rule-weakening and-elim-left-sugar top-intro kore-or-is-pattern imp-reflexivity sorting-rearrange-865 kore-not-bot kore-de-morgan-alt ) ACFEDACFEDACFEDACFEDEDDDACACACGACACACHACTACIJIUAUBKLMGJBUCKLMUDACHNNBUEACPUJQRACFEDACFEDACFEDACFEDEDDAUFACFEDACFEDACFEDEDAUFACFEDACFEDEAUFACFEDEUIUGSSSACGACACACHACTACIJIUAUBKLMGJBUCKLMUDACHNNBUEACPACFEDACFEDACFEDEDDDACFEDACFEDACFEDEDDDACFEDACACGACACACHACTACIJIUAUBKLMGJBUCKLMUDACHNNBUEQRACFEDACFEDACFEDEDDDACFEACFEDACFEDACFEDEDDDACFEDACFACFEDACFEDACFEDEDDUHACFEDACFACFACFEUHACFUKOOACFEDACFEDACFEDEDDDEUIUGSABULOACFEDACFEDACFEDEDDDACFEDACACACPQRACFEDACFEDACFEDEDDUHACFEDACACACPQRACUMUGOUNO $. $}
