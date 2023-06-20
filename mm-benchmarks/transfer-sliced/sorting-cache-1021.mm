$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \kore-sort-SortKItem \imp |- ) \in-sort \kore-sort-SortMap ( $.
$v kore-element-var-VE5 kore-element-var-VE4 ph0 ph2 ph1 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
${ sorting-cache-1021 $p |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) \top ) ) ( \in-sort kore-element-var-VE4 \kore-sort-SortKItem ) ) $= ( in-sort-is-pattern typecode-cache-Pattern-179 BASIC-K-sort-1-is-pattern top-is-pattern and-is-pattern typecode-cache-Pattern-253 IMP-sort-14-is-pattern rule-imp-transitivity and-elim-right-sugar and-elim-left-sugar imp-reflexivity ) BHICFGADECFGGADECFGADECBHICFGADECFGKADECFGADECADECADECFLADECMJJ $. $}
