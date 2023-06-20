$c \top #Variable "10" \kore-sort-SortBool \imp \kore-dv \kore-is-sort \kore-symbol-Lbl'Unds-GT-'Int'Unds' |- \kore-valid ) \kore-equals "false" \and #SetVariable #ElementVariable #Symbol #Pattern "100" \kore-sort-SortInt ( $.
$v kore-sort-var-R ph0 ph2 ptn1 ph3 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-190-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' ptn0 ptn1 ) $.
string-literal-5-is-pattern $a #Pattern "false" $.
string-literal-13-is-pattern $a #Pattern "10" $.
string-literal-16-is-pattern $a #Pattern "100" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-136 $a |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
LblUnds-GT-IntUnds-domain-fact-0 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' ( \kore-dv \kore-sort-SortInt "10" ) ( \kore-dv \kore-sort-SortInt "100" ) ) ( \kore-dv \kore-sort-SortBool "false" ) ) ) ) $.
${ sorting-rearrange-30 $p |- ( \imp ( \and \top ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortBool kore-sort-var-R ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' ( \kore-dv \kore-sort-SortInt "10" ) ( \kore-dv \kore-sort-SortInt "100" ) ) ( \kore-dv \kore-sort-SortBool "false" ) ) ) ) $= ( top-is-pattern typecode-cache-Pattern-0 and-is-pattern kore-is-sort-is-pattern kore-dv-is-pattern IMP-sort-32-is-pattern IMP-sort-23-is-pattern string-literal-13-is-pattern string-literal-16-is-pattern IMP-symbol-190-is-pattern string-literal-5-is-pattern kore-equals-is-pattern kore-valid-is-pattern sorting-cache-136 top-intro rule-weakening rule-and-intro-alt2-sugar LblUnds-GT-IntUnds-domain-fact-0 rule-imp-transitivity ) BACEBDDACEBDACGACHIFHJFKGLFMNBACEBDDACEBAOBACEBDDBPQRAST $. $}
