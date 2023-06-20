$c \kore-symbol-Lbl'-LT-'T'-GT-' \kore-symbol-Lbl'Hash'freezer'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' \top \kore-sort-SortAExp \kore-symbol-LblisKResult \kore-symbol-dotk \kore-symbol-kseq #Variable \kore-sort-SortBool \kore-sort-SortK \imp \kore-dv "0" |- \kore-valid ) \kore-equals \kore-symbol-Lbl'-LT-'k'-GT-' \in-sort \and \kore-and #SetVariable \kore-sort-SortGeneratedTopCell \kore-rewrites #ElementVariable #Symbol \kore-symbol-Lbl'-LT-'generatedTop'-GT-' #Pattern \kore-sort-SortKItem \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' "true" \kore-inj \kore-sort-SortInt \kore-symbol-Lbl'Unds'andBool'Unds' \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp \kore-top \kore-sort-SortStateCell ( $.
$v ph0 ph2 kore-element-var-VE1 kore-element-var-VE3 kore-element-var-VE2 ptn1 kore-element-var-VE5 kore-element-var-VE4 ph3 ptn0 ph1 $.
$d kore-element-var-VE3 kore-element-var-VE1 $.
$d kore-element-var-VE3 kore-element-var-VE4 $.
$d kore-element-var-VE5 kore-element-var-VE2 $.
$d kore-element-var-VE4 kore-element-var-VE2 $.
$d kore-element-var-VE5 kore-element-var-VE4 $.
$d kore-element-var-VE2 kore-element-var-VE1 $.
$d kore-element-var-VE4 kore-element-var-VE1 $.
$d kore-element-var-VE5 kore-element-var-VE3 $.
$d kore-element-var-VE3 kore-element-var-VE2 $.
$d kore-element-var-VE5 kore-element-var-VE1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
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
kore-equals-is-pattern $a #Pattern ( \kore-equals ph0 ph1 ph2 ph3 ) $.
kore-rewrites-is-pattern $a #Pattern ( \kore-rewrites ph0 ph1 ph2 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
kore-element-var-VE1-elementvariable $f #ElementVariable kore-element-var-VE1 $.
kore-element-var-VE3-elementvariable $f #ElementVariable kore-element-var-VE3 $.
kore-element-var-VE4-elementvariable $f #ElementVariable kore-element-var-VE4 $.
IMP-sort-8-is-pattern $a #Pattern \kore-sort-SortGeneratedTopCell $.
IMP-sort-9-is-pattern $a #Pattern \kore-sort-SortStateCell $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-126-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ptn0 ptn1 ) $.
IMP-symbol-128-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ptn0 ) $.
IMP-symbol-129-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ptn0 ptn1 ) $.
IMP-symbol-131-is-pattern $a #Pattern ( \kore-symbol-Lbl'-LT-'k'-GT-' ptn0 ) $.
IMP-symbol-205-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds'andBool'Unds' ptn0 ptn1 ) $.
IMP-symbol-271-is-pattern $a #Pattern ( \kore-symbol-LblisKResult ptn0 ) $.
string-literal-0-is-pattern $a #Pattern "true" $.
string-literal-1-is-pattern $a #Pattern "0" $.
kore-element-var-VE5-elementvariable $f #ElementVariable kore-element-var-VE5 $.
typecode-cache-Pattern-146 $a #Pattern kore-element-var-VE1 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
typecode-cache-Pattern-178 $a #Pattern kore-element-var-VE3 $.
typecode-cache-Pattern-179 $a #Pattern kore-element-var-VE4 $.
typecode-cache-Pattern-253 $a #Pattern kore-element-var-VE5 $.
typecode-cache-Pattern-324 $a #Pattern ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) $.
sorting-cache-1493 $a |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortAExp ) \top ) ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) $.
typecode-cache-Pattern-408 $a #Pattern ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp kore-element-var-VE4 kore-element-var-VE1 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) $.
typecode-cache-Pattern-409 $a #Pattern ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE1 ) \kore-symbol-dotk ) ) kore-element-var-VE2 ) $.
sorting-rearrange-1211 $a |- ( \imp ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-equals \kore-sort-SortBool \kore-sort-SortGeneratedTopCell ( \kore-symbol-Lbl'Unds'andBool'Unds' ( \kore-dv \kore-sort-SortBool "true" ) ( \kore-symbol-LblisKResult ( \kore-symbol-kseq kore-element-var-VE5 \kore-symbol-dotk ) ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-and \kore-sort-SortKItem ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE5 ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE1 ) \kore-symbol-dotk ) ) kore-element-var-VE2 ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp kore-element-var-VE4 kore-element-var-VE1 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $.
${ sorting-rearrange-1213 $p |- ( \imp ( \and ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortK ) ( \and ( \in-sort kore-element-var-VE3 \kore-sort-SortStateCell ) ( \and ( \in-sort kore-element-var-VE4 \kore-sort-SortAExp ) ( \and ( \in-sort kore-element-var-VE5 \kore-sort-SortKItem ) \top ) ) ) ) ( \and ( \in-sort kore-element-var-VE1 \kore-sort-SortAExp ) \top ) ) ( \kore-valid \kore-sort-SortGeneratedTopCell ( \kore-rewrites \kore-sort-SortGeneratedTopCell ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-equals \kore-sort-SortBool \kore-sort-SortGeneratedTopCell ( \kore-symbol-Lbl'Unds'andBool'Unds' ( \kore-dv \kore-sort-SortBool "true" ) ( \kore-symbol-LblisKResult ( \kore-symbol-kseq kore-element-var-VE5 \kore-symbol-dotk ) ) ) ( \kore-dv \kore-sort-SortBool "true" ) ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-and \kore-sort-SortKItem ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE4 ) kore-element-var-VE5 ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem kore-element-var-VE1 ) \kore-symbol-dotk ) ) kore-element-var-VE2 ) ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ( \kore-and \kore-sort-SortGeneratedTopCell ( \kore-top \kore-sort-SortGeneratedTopCell ) ( \kore-symbol-Lbl'-LT-'generatedTop'-GT-' ( \kore-symbol-Lbl'-LT-'T'-GT-' ( \kore-symbol-Lbl'-LT-'k'-GT-' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortAExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds'-'UndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp kore-element-var-VE4 kore-element-var-VE1 ) ) kore-element-var-VE2 ) ) kore-element-var-VE3 ) ( \kore-symbol-Lbl'-LT-'generatedCounter'-GT-' ( \kore-dv \kore-sort-SortInt "0" ) ) ) ) ) ) ) $= ( in-sort-is-pattern and-is-pattern typecode-cache-Pattern-178 IMP-sort-9-is-pattern typecode-cache-Pattern-177 BASIC-K-sort-0-is-pattern typecode-cache-Pattern-324 IMP-sort-13-is-pattern typecode-cache-Pattern-146 top-is-pattern rule-imp-transitivity IMP-sort-8-is-pattern and-elim-left-sugar kore-dv-is-pattern IMP-sort-32-is-pattern kore-and-is-pattern imp-reflexivity rule-and-intro-alt2-sugar string-literal-0-is-pattern typecode-cache-Pattern-253 KSEQ-symbol-0-is-pattern BASIC-K-sort-1-is-pattern IMP-sort-23-is-pattern string-literal-1-is-pattern IMP-symbol-128-is-pattern IMP-symbol-129-is-pattern and-elim-right-sugar KSEQ-symbol-1-is-pattern IMP-symbol-271-is-pattern IMP-symbol-205-is-pattern kore-equals-is-pattern typecode-cache-Pattern-179 kore-inj-is-pattern typecode-cache-Pattern-409 IMP-symbol-131-is-pattern IMP-symbol-126-is-pattern kore-top-is-pattern typecode-cache-Pattern-408 kore-rewrites-is-pattern kore-valid-is-pattern sorting-cache-1493 sorting-rearrange-1211 ) AJKFCHIFDELGGBNMFOGGBNMFAJKFCHIFDELGGGQQQTQTUDSEUEUMUFUNUOTUDSUPUGMUGDUQUREUEUAABUSUFUTCHVAUHUISUJUKUAQQVBABCDVCUHUISUJUKUAVDVEAJKFCHIFDELGGBNMFOGGBNMFAJKFCHIFDELGGAJKFCHIFDELGGBNMFOGGBNMFOGBNMFAJKFCHIFDELGGBNMFOGULBNMFOGBNMFBNMFBNMFORBNMFUBPPAJKFCHIFDELGGBNMFOGGAJKFCHIFDELGAJKFCHIFDELGGBNMFOGGAJKFCHIFDELGGAJKFAJKFCHIFDELGGBNMFOGRAJKFCHIFDELGGAJKFAJKFAJKFCHIFDELGRAJKFUBPPAJKFCHIFDELGGBNMFOGGCHIFDELAJKFCHIFDELGGBNMFOGGAJKFCHIFDELGGCHIFAJKFCHIFDELGGBNMFOGRAJKFCHIFDELGGCHIFDELGCHIFAJKFCHIFDELGULCHIFDELGCHIFCHIFCHIFDELRCHIFUBPPPABCDEVFUCUCUCABCDEVGP $. $}
