$c \kore-symbol-Lbl'-LT-'T'-GT-' \kore-sort-SortBExp \top \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-symbol-kseq #Variable \kore-sort-SortBool \kore-sort-SortK \imp \kore-symbol-Lbl'Unds-GT-'Int'Unds' |- \kore-valid ) \kore-symbol-Lbl'-LT-'k'-GT-' \and \kore-and #SetVariable \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortInt \kore-sort-SortGeneratedCounterCell \in-sort \kore-top \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE1 kore-element-var-VE3 kore-element-var-VE2 ptn1 kore-element-var-VE4 kore-element-var-VE0 ptn0 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE2 kore-element-var-VE0 $.
$d kore-element-var-VE3 kore-element-var-VE0 $.
$d kore-element-var-VE0 kore-element-var-VE1 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE4 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-VE0 $.
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
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-and-is-pattern $a #Pattern ( \kore-and ph0 ph1 ph2 ) $.
kore-rewrites-is-pattern $a #Pattern ( \kore-rewrites ph0 ph1 ph2 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
kore-element-var-VE0-elementvariable $f #ElementVariable kore-element-var-VE0 $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-symbol-129-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn0 ptn1 ) $.
IMP-axiom-3202 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortGeneratedCounterCell ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortInt ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-VE4 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-VE1 ) ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) kore-element-var-VE0 ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' kore-element-var-VE4 kore-element-var-VE1 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) kore-element-var-VE0 ) ) ) ) ) $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-148 $a #Pattern kore-element-var-VE0 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-347 $a #Pattern ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) $.
sorting-cache-1631 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortInt ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortGeneratedCounterCell ) \top ) ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) ) $.
typecode-cache-Pattern-348 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-VE4 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-VE1 ) ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) $.
typecode-cache-Pattern-350 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' kore-element-var-VE4 kore-element-var-VE1 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) $.
${ sorting-rearrange-1061 $p |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortInt ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortInt ) \top ) ) ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortGeneratedCounterCell ) \top ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-VE4 ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp kore-element-var-VE1 ) ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) kore-element-var-VE0 ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBool \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-'Int'Unds' kore-element-var-VE4 kore-element-var-VE1 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) kore-element-var-VE0 ) ) ) ) ) $= ( in-sort-is-pattern and-is-pattern typecode-cache-Pattern-177 BASIC-K-sort-0-is-pattern typecode-cache-Pattern-146 IMP-sort-23-is-pattern typecode-cache-Pattern-347 typecode-cache-Pattern-148 IMP-sort-10-is-pattern top-is-pattern rule-imp-transitivity IMP-sort-8-is-pattern and-elim-left-sugar imp-reflexivity rule-and-intro-alt2-sugar kore-top-is-pattern IMP-symbol-129-is-pattern kore-and-is-pattern and-elim-right-sugar typecode-cache-Pattern-348 typecode-cache-Pattern-350 kore-rewrites-is-pattern kore-valid-is-pattern sorting-cache-1631 IMP-axiom-3202 ) CJKFBHIFDELGGAMNFOGGAMNFCJKFBHIFDELGGGQQQQUABCDEUEAMUBUCQQUABCDEUFAMUBUCUGUHCJKFBHIFDELGGAMNFOGGAMNFCJKFBHIFDELGGCJKFBHIFDELGGAMNFOGGAMNFOGAMNFCJKFBHIFDELGGAMNFOGUDAMNFOGAMNFAMNFAMNFORAMNFSPPCJKFBHIFDELGGAMNFOGGCJKFBHIFDELGCJKFBHIFDELGGAMNFOGGCJKFBHIFDELGGCJKFCJKFBHIFDELGGAMNFOGRCJKFBHIFDELGGCJKFCJKFCJKFBHIFDELGRCJKFSPPCJKFBHIFDELGGAMNFOGGBHIFDELCJKFBHIFDELGGAMNFOGGCJKFBHIFDELGGBHIFCJKFBHIFDELGGAMNFOGRCJKFBHIFDELGGBHIFDELGBHIFCJKFBHIFDELGUDBHIFDELGBHIFBHIFBHIFDELRBHIFSPPPABCDEUITTTABCDEUJP $. $}
