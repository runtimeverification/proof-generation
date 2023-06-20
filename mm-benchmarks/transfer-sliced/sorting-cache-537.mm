$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortK \imp \kore-is-sort |- ) \in-sort ( $.
$v kore-sort-var-R kore-element-var-V2 ph0 ph2 ph1 $.
$d kore-sort-var-R kore-element-var-V2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
top-intro $a |- \top $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-V2-elementvariable $f #ElementVariable kore-element-var-V2 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-35 $a #Pattern kore-element-var-V2 $.
typecode-cache-Pattern-156 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) $.
sorting-cache-533 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-534 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \in-sort kore-element-var-V2 \kore-sort-SortK ) ) $.
${ sorting-cache-537 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-V2 \kore-sort-SortK ) \top ) ) ) $= ( typecode-cache-Pattern-156 top-is-pattern typecode-cache-Pattern-35 BASIC-K-sort-0-is-pattern in-sort-is-pattern rule-and-intro-alt2-sugar typecode-cache-Pattern-0 kore-is-sort-is-pattern and-is-pattern sorting-cache-533 sorting-cache-534 top-intro rule-weakening ) ABCAIJBEFGDKABLABCBEFGDABMABCDNOHH $. $}
