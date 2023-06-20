$c \top #SetVariable \kore-symbol-Lbl'Stop'Map #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol #Variable #Pattern \and \imp \kore-is-sort |- \kore-valid ) \kore-equals \kore-sort-SortMap ( $.
$v kore-sort-var-R ph0 ph2 th0 ptn1 ph3 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
th0-is-pattern $f #Pattern th0 $.
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
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
${ kore-equals-symmetry.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-equals ph1 ph0 ph3 ph2 ) ) ) $.
   kore-equals-symmetry $a |- ( \imp th0 ( \kore-valid ph0 ( \kore-equals ph1 ph0 ph2 ph3 ) ) ) $. $}
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-symbol-124-is-pattern $a #Pattern \kore-symbol-Lbl'Stop'Map $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
sorting-cache-133 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ) $.
sorting-rearrange-308 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \and ( \and ( \kore-is-sort kore-sort-var-R ) \top ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R ( \kore-symbol-Lbl'Unds'Map'Unds' \kore-symbol-Lbl'Stop'Map \kore-symbol-Lbl'Stop'Map ) \kore-symbol-Lbl'Stop'Map ) ) ) $.
${ sorting-rearrange-309 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) \top ) ( \kore-valid kore-sort-var-R ( \kore-equals \kore-sort-SortMap kore-sort-var-R \kore-symbol-Lbl'Stop'Map ( \kore-symbol-Lbl'Unds'Map'Unds' \kore-symbol-Lbl'Stop'Map \kore-symbol-Lbl'Stop'Map ) ) ) ) $= ( top-is-pattern and-is-pattern typecode-cache-Pattern-0 kore-is-sort-is-pattern IMP-symbol-124-is-pattern IMP-sort-14-is-pattern IMP-symbol-194-is-pattern sorting-cache-133 rule-and-intro-alt2-sugar kore-equals-is-pattern kore-valid-is-pattern top-intro rule-weakening sorting-rearrange-308 kore-equals-symmetry rule-imp-transitivity ) ADEBCADEBCADEBCBCCADGADFFFHKLADEBCADEBCADEBCBCAIADEBCADEBCBAIADEBCBMNJJADGFFFHADEBCADEBCBCCAOPQ $. $}
