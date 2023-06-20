$c \kore-symbol-Lbl'-LT-'T'-GT-' \top #Variable \kore-implies \imp \kore-is-sort |- \kore-valid ) \kore-equals \and \kore-and \kore-symbol-LblinitStateCell #SetVariable \kore-symbol-LblinitTCell #ElementVariable #Symbol \kore-symbol-LblinitKCell #Pattern \kore-in \kore-sort-SortTCell \in-sort \kore-top \kore-sort-SortMap ( $.
$v kore-sort-var-R ph0 ph2 kore-element-var-VE1 kore-element-var-VE0 ph1 $.
$d kore-sort-var-R kore-element-var-VE1 $.
$d kore-sort-var-R kore-element-var-VE0 $.
$d kore-element-var-VE0 kore-element-var-VE1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-implies-is-pattern $a #Pattern ( \kore-implies ph0 ph1 ph2 ) $.
kore-is-sort-is-pattern $a #Pattern ( \kore-is-sort ph0 ) $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE0-elementvariable $f #ElementVariable kore-element-var-VE0 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
IMP-sort-14-is-pattern $a #Pattern \kore-sort-SortMap $.
IMP-axiom-3293 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortMap kore-sort-var-R kore-element-var-VE0 kore-element-var-VE1 ) ( \kore-top kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortTCell kore-sort-var-R ( \kore-symbol-LblinitTCell kore-element-var-VE0 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-LblinitKCell kore-element-var-VE1 ) \kore-symbol-LblinitStateCell ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-147 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) $.
typecode-cache-Pattern-148 $a #Pattern kore-element-var-VE0 $.
sorting-cache-434 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ( \kore-is-sort kore-sort-var-R ) ) $.
sorting-cache-436 $a |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-149 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortMap ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ) $.
typecode-cache-Pattern-150 $a #Pattern ( \kore-in \kore-sort-SortMap kore-sort-var-R kore-element-var-VE0 kore-element-var-VE1 ) $.
typecode-cache-Pattern-154 $a #Pattern ( \kore-equals \kore-sort-SortTCell kore-sort-var-R ( \kore-symbol-LblinitTCell kore-element-var-VE0 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-LblinitKCell kore-element-var-VE1 ) \kore-symbol-LblinitStateCell ) ) $.
${ sorting-rearrange-268 $p |- ( \imp ( \and ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortMap ) \top ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortMap ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-implies kore-sort-var-R ( \kore-and kore-sort-var-R ( \kore-top kore-sort-var-R ) ( \kore-and kore-sort-var-R ( \kore-in \kore-sort-SortMap kore-sort-var-R kore-element-var-VE0 kore-element-var-VE1 ) ( \kore-top kore-sort-var-R ) ) ) ( \kore-and kore-sort-var-R ( \kore-equals \kore-sort-SortTCell kore-sort-var-R ( \kore-symbol-LblinitTCell kore-element-var-VE0 ) ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-LblinitKCell kore-element-var-VE1 ) \kore-symbol-LblinitStateCell ) ) ( \kore-top kore-sort-var-R ) ) ) ) ) $= ( typecode-cache-Pattern-0 and-is-pattern IMP-sort-14-is-pattern in-sort-is-pattern typecode-cache-Pattern-147 typecode-cache-Pattern-148 top-is-pattern kore-top-is-pattern kore-and-is-pattern kore-is-sort-is-pattern rule-imp-transitivity typecode-cache-Pattern-149 typecode-cache-Pattern-150 typecode-cache-Pattern-154 kore-implies-is-pattern kore-valid-is-pattern typecode-cache-Pattern-146 and-elim-left-sugar sorting-cache-434 sorting-cache-436 rule-and-intro-alt2-sugar IMP-axiom-3293 ) ACHBIFGJEEABCOADADADADKADABCPADKLLADABCQADKLRSACHBIFGJEEADMBIFGCTFGJEEACHBIFGJEEACHADMACHBIFGJEUAACUBNABCUCUDABCUEN $. $}
