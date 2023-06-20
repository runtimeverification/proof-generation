$c #Notation \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol #Variable #Pattern \included \inh ) \in-sort ( $.
$v ph0 ph2 ph1 kore-element-var-VE2 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
included-is-pattern $a #Pattern ( \included ph0 ph1 ) $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
in-sort-is-sugar $a #Notation ( \in-sort ph0 ph1 ) ( \included ph0 ( \inh ph1 ) ) $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
${ notation-cache-770 $p #Notation ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \included kore-element-var-VE2 ( \inh \kore-sort-SortKResult ) ) $= ( typecode-cache-Pattern-177 IMP-sort-28-is-pattern inh-is-pattern included-is-pattern in-sort-is-pattern in-sort-is-sugar notation-reflexivity notation-transitivity ) ABCFABCDEABCDEABCGABCDEHI $. $}
