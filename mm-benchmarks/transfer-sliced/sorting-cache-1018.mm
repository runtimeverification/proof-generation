$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp |- \kore-sort-SortId ) \in-sort \kore-sort-SortMap ( $.
$v ph0 ph2 kore-element-var-VE3 kore-element-var-VE5 kore-element-var-VE4 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
typecode-cache-Pattern-254 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) $.
sorting-cache-962 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ) $.
sorting-cache-1017 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) $.
${ sorting-cache-1018 $p |- ( \imp ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) $= ( in-sort-is-pattern typecode-cache-Pattern-254 typecode-cache-Pattern-178 IMP-sort-17-is-pattern and-is-pattern typecode-cache-Pattern-179 BASIC-K-sort-1-is-pattern typecode-cache-Pattern-253 IMP-sort-14-is-pattern top-is-pattern and-elim-right-sugar sorting-cache-962 rule-imp-transitivity sorting-cache-1017 rule-and-intro-alt2-sugar ) AFGDBCEHBIJDCKLDMHAFGDBCEHBCEBIJDAFGDBCENBCOPABCQR $. $}
