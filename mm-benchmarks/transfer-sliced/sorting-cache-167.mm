$c \top #SetVariable #ElementVariable #Symbol #Variable #Pattern \and \imp \kore-is-sort |- ) \kore-sort-SortInt \in-sort ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-T ph1 $.
$d kore-sort-var-R kore-element-var-T $.
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
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
kore-element-var-T-elementvariable $f #ElementVariable kore-element-var-T $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-6 $a #Pattern kore-element-var-T $.
${ sorting-cache-167 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \in-sort kore-element-var-T \kore-sort-SortInt ) \top ) ) ( \in-sort kore-element-var-T \kore-sort-SortInt ) ) $= ( typecode-cache-Pattern-6 IMP-sort-23-is-pattern in-sort-is-pattern top-is-pattern and-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern rule-imp-transitivity and-elim-right-sugar and-elim-left-sugar imp-reflexivity ) AHIFGBCDEFGGBCDEFGBCDEAHIFGBCDEFGKBCDEFGBCDEBCDEBCDEFLBCDEMJJ $. $}
