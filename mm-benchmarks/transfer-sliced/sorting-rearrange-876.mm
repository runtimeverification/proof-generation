$c \kore-symbol-Lbl'-LT-'T'-GT-' \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' \top \kore-symbol-Lbl'-LT-'state'-GT-' \kore-symbol-kseq #Variable \kore-sort-SortK \imp |- \kore-sort-SortId \kore-valid ) \kore-symbol-Lbl'-LT-'k'-GT-' \and \kore-and #SetVariable \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable \kore-symbol-Lbl'Unds'Map'Unds' #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-sort-SortKItem \kore-inj \kore-sort-SortGeneratedCounterCell \in-sort \kore-top \kore-sort-SortMap \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE1 kore-element-var-VE3 kore-element-var-VE2 ptn1 kore-element-var-VE5 kore-element-var-VE4 kore-element-var-VE0 ptn0 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE2 kore-element-var-VE0 $.
$d kore-element-var-VE3 kore-element-var-VE0 $.
$d kore-element-var-VE0 kore-element-var-VE1 $.
$d kore-element-var-VE5 kore-element-var-VE0 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE4 kore-element-var-VE1 $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-VE0 $.
$d kore-element-var-VE5 kore-element-var-VE1 $.
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
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
kore-element-var-VE0-elementvariable $f #ElementVariable kore-element-var-VE0 $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-10-is-pattern $a #Pattern \kore-sort-SortGeneratedCounterCell $.
IMP-symbol-126-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn0 ptn1 ) $.
IMP-symbol-129-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn0 ptn1 ) $.
IMP-symbol-131-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn0 ) $.
IMP-symbol-132-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'state'-GT-' ptn0 ) $.
IMP-symbol-194-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'Map'Unds' ptn0 ptn1 ) $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
IMP-axiom-3164 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortGeneratedCounterCell ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE1 ) ) ( \kore-and \kore-sort-SortStateCell ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE3 ) kore-element-var-VE5 ) ) kore-element-var-VE2 ) ) kore-element-var-VE0 ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq kore-element-var-VE3 kore-element-var-VE1 ) ) kore-element-var-VE2 ) kore-element-var-VE0 ) ) ) ) ) $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-148 $a #Pattern kore-element-var-VE0 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
typecode-cache-Pattern-308 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) $.
sorting-cache-1375 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortGeneratedCounterCell ) \top ) ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ) ) $.
typecode-cache-Pattern-309 $a #Pattern ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE1 ) $.
typecode-cache-Pattern-310 $a #Pattern ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE3 ) $.
typecode-cache-Pattern-312 $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq kore-element-var-VE3 kore-element-var-VE1 ) ) kore-element-var-VE2 ) kore-element-var-VE0 ) $.
${ sorting-rearrange-876 $p |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortKItem ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortId ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortMap ) \top ) ) ) ) ) ( \and ( \in-sort kore-element-var-VE0 \kore-sort-SortGeneratedCounterCell ) \top ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE1 ) ) ( \kore-and \kore-sort-SortStateCell ( \kore-symbol-Lbl'-LT-'state'-GT-' ( \kore-symbol-Lbl'Unds'Map'Unds' ( \kore-symbol-Lbl'UndsPipe'-'-GT-Unds' ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE3 ) kore-element-var-VE5 ) ) kore-element-var-VE2 ) ) kore-element-var-VE0 ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq kore-element-var-VE3 kore-element-var-VE1 ) ) kore-element-var-VE2 ) kore-element-var-VE0 ) ) ) ) ) $= ( in-sort-is-pattern and-is-pattern typecode-cache-Pattern-146 BASIC-K-sort-0-is-pattern typecode-cache-Pattern-148 IMP-sort-10-is-pattern typecode-cache-Pattern-177 IMP-sort-9-is-pattern typecode-cache-Pattern-178 BASIC-K-sort-1-is-pattern typecode-cache-Pattern-308 top-is-pattern IMP-sort-8-is-pattern rule-imp-transitivity kore-and-is-pattern and-elim-left-sugar kore-top-is-pattern imp-reflexivity rule-and-intro-alt2-sugar typecode-cache-Pattern-309 IMP-symbol-131-is-pattern typecode-cache-Pattern-310 typecode-cache-Pattern-253 IMP-symbol-194-is-pattern IMP-symbol-132-is-pattern IMP-symbol-126-is-pattern IMP-symbol-129-is-pattern typecode-cache-Pattern-312 kore-rewrites-is-pattern kore-valid-is-pattern and-elim-right-sugar sorting-cache-1375 IMP-axiom-3164 ) CIJGBMNGDOPGEFQHHHAKLGRHHAKLGCIJGBMNGDOPGEFQHHHHSSSSUCCEUFUGNDEUHFUIUJUKBMUAULAKUMUASSUCABCDUNUAUOUPCIJGBMNGDOPGEFQHHHAKLGRHHAKLGCIJGBMNGDOPGEFQHHHCIJGBMNGDOPGEFQHHHAKLGRHHAKLGRHAKLGCIJGBMNGDOPGEFQHHHAKLGRHUQAKLGRHAKLGAKLGAKLGRUBAKLGUDTTCIJGBMNGDOPGEFQHHHAKLGRHHCIJGBMNGDOPGEFQHHCIJGBMNGDOPGEFQHHHAKLGRHHCIJGBMNGDOPGEFQHHHCIJGCIJGBMNGDOPGEFQHHHAKLGRHUBCIJGBMNGDOPGEFQHHHCIJGCIJGCIJGBMNGDOPGEFQHHUBCIJGUDTTABCDEFURUEUEABCDEFUST $. $}
