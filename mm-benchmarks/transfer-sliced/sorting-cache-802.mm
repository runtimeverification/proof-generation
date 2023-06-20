$c \top #SetVariable #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern \and \imp |- ) \in-sort \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE3 ph1 kore-element-var-VE2 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
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
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
${ sorting-cache-802 $p |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) \top ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) \top ) ) ( \in-sort kore-element-var-VE2 \kore-sort-SortStmt ) ) $= ( in-sort-is-pattern typecode-cache-Pattern-177 IMP-sort-31-is-pattern top-is-pattern and-is-pattern typecode-cache-Pattern-178 IMP-sort-9-is-pattern rule-imp-transitivity and-elim-right-sugar and-elim-left-sugar imp-reflexivity ) BHICFGADECFGGADECFGADECBHICFGADECFGKADECFGADECADECADECFLADECMJJ $. $}
