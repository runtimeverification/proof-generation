$c \kore-sort-SortKResult \top #SetVariable #ElementVariable #Symbol #Variable #Pattern "10" \and \kore-sort-SortKItem \imp \kore-dv \kore-is-sort |- ) \kore-inj \kore-sort-SortInt \in-sort ( $.
$v kore-sort-var-R ph0 ph2 ptn1 ptn2 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
INJ-symbol-0-sorting $a |- ( \imp ( \and ( \and ( \kore-is-sort ptn0 ) ( \kore-is-sort ptn1 ) ) ( \in-sort ptn2 ptn0 ) ) ( \in-sort ( \kore-inj ptn0 ptn1 ptn2 ) ptn1 ) ) $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
string-literal-13-is-pattern $a #Pattern "10" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-1569 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \and ( \kore-is-sort \kore-sort-SortKResult ) ( \kore-is-sort \kore-sort-SortKItem ) ) ) $.
sorting-cache-1571 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortKResult ( \kore-dv \kore-sort-SortInt "10" ) ) \kore-sort-SortKResult ) ) $.
${ sorting-cache-1572 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \in-sort ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem ( \kore-inj \kore-sort-SortInt \kore-sort-SortKResult ( \kore-dv \kore-sort-SortInt "10" ) ) ) \kore-sort-SortKItem ) ) $= ( and-is-pattern IMP-sort-28-is-pattern kore-is-sort-is-pattern IMP-sort-23-is-pattern top-is-pattern BASIC-K-sort-1-is-pattern kore-inj-is-pattern typecode-cache-Pattern-0 string-literal-13-is-pattern kore-dv-is-pattern in-sort-is-pattern sorting-cache-1569 sorting-cache-1571 rule-and-intro-alt2-sugar INJ-symbol-0-sorting rule-imp-transitivity ) AIDFBAIDFBFBBCDGDBECEJKHCLBCGECEJKHHGLAIDFBAIDFBFBBCDGDBECEJKHCLAMANOCGECEJKHPQ $. $}
