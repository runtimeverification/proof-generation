$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) \in-sort \kore-sort-SortMap ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-K3 kore-element-var-K1 ph1 kore-element-var-K2 $.
$d kore-element-var-K1 kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K2 $.
$d kore-sort-var-R kore-element-var-K1 $.
$d kore-element-var-K3 kore-element-var-K2 $.
$d kore-element-var-K1 kore-element-var-K3 $.
$d kore-sort-var-R kore-element-var-K3 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
kore-element-var-K2-elementvariable $f #ElementVariable kore-element-var-K2 $.
kore-element-var-K3-elementvariable $f #ElementVariable kore-element-var-K3 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
typecode-cache-Pattern-120 $a #Pattern kore-element-var-K2 $.
typecode-cache-Pattern-209 $a #Pattern kore-element-var-K3 $.
typecode-cache-Pattern-210 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) $.
sorting-cache-729 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-733 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) $.
${ sorting-cache-734 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) \top ) ) ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K2 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-K3 \kore-sort-SortMap ) \top ) ) ) ) ) $= ( IMP-sort-14-is-pattern in-sort-is-pattern and-is-pattern typecode-cache-Pattern-49 top-is-pattern typecode-cache-Pattern-210 rule-imp-transitivity typecode-cache-Pattern-0 kore-is-sort-is-pattern typecode-cache-Pattern-120 typecode-cache-Pattern-209 and-elim-left-sugar rule-and-intro-alt2-sugar sorting-cache-729 and-elim-right-sugar imp-reflexivity sorting-cache-733 ) ACDJBHEFIGGALMBHEFCNEFDOEFIGGGACDJBHEFIGGACDJALMACDJBHEFIGPACDRKACDJBHEFIGGBHEFCNEFDOEFIGGACDJBHEFIGGBHEFIGBHEFACDJBHEFIGSBHEFIGBHEFBHEFBHEFIPBHEFTKKABCDUAQQ $. $}
