$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) \in-sort \kore-sort-SortMap ( $.
$v kore-sort-var-R ph0 ph2 ph1 kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K2 $.
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
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
kore-element-var-K2-elementvariable $f #ElementVariable kore-element-var-K2 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-120 $a #Pattern kore-element-var-K2 $.
typecode-cache-Pattern-191 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) $.
sorting-cache-689 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-690 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ) $.
${ sorting-cache-692 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) \top ) ) ) $= ( typecode-cache-Pattern-191 top-is-pattern typecode-cache-Pattern-120 IMP-sort-14-is-pattern in-sort-is-pattern rule-and-intro-alt2-sugar typecode-cache-Pattern-0 kore-is-sort-is-pattern and-is-pattern sorting-cache-689 sorting-cache-690 top-intro rule-weakening ) ABCAIJBEFGDKABLABCBEFGDABMABCDNOHH $. $}
