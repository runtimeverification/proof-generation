$c "1" "amount" \top \kore-sort-SortAExp \kore-symbol-kseq \kore-sort-SortStmt #Variable "200" \kore-sort-SortK \imp \kore-dv |- \kore-sort-SortId ) \and \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' \kore-symbol-Lbl'Hash'freezer'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp1'Unds' #SetVariable #ElementVariable #Symbol #Pattern \kore-sort-SortKItem "ret" \kore-inj \kore-sort-SortInt \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \in-sort \kore-symbol-dotk "balanceTo" ( $.
$v ph0 ph2 ptn0 ph1 ptn1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
KSEQ-symbol-0-sorting $a |- ( \imp ( \and ( \in-sort ptn0 \kore-sort-SortKItem ) ( \in-sort ptn1 \kore-sort-SortK ) ) ( \in-sort ( \kore-symbol-kseq ptn0 ptn1 ) \kore-sort-SortK ) ) $.
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
IMP-symbol-79-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' ptn0 ) $.
IMP-symbol-91-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'freezer'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp1'Unds' ptn0 ) $.
IMP-symbol-185-is-pattern $a #Pattern ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ptn0 ptn1 ) $.
string-literal-4-is-pattern $a #Pattern "1" $.
string-literal-11-is-pattern $a #Pattern "ret" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
string-literal-15-is-pattern $a #Pattern "200" $.
string-literal-17-is-pattern $a #Pattern "balanceTo" $.
sorting-cache-84 $a |- ( \imp \top ( \in-sort ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) \kore-sort-SortKItem ) ) $.
sorting-cache-216 $a |- ( \imp \top ( \in-sort ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) \kore-sort-SortK ) ) $.
sorting-cache-222 $a |- ( \imp \top ( \in-sort ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-symbol-dotk ) ) \kore-sort-SortKItem ) ) $.
${ sorting-cache-223 $p |- ( \imp \top ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortInt \kore-sort-SortKItem ( \kore-dv \kore-sort-SortInt "200" ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsPlusUndsUnds'IMP-SYNTAX'Unds'AExp'Unds'AExp'Unds'AExp0'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "amount" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-symbol-Lbl'Hash'freezer'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp1'Unds' ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortId \kore-sort-SortKItem ( \kore-dv \kore-sort-SortId "balanceTo" ) ) \kore-symbol-dotk ) ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortStmt \kore-sort-SortKItem ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) ( \kore-inj \kore-sort-SortInt \kore-sort-SortAExp ( \kore-dv \kore-sort-SortInt "1" ) ) ) ) \kore-symbol-dotk ) ) ) ) \kore-sort-SortK ) ) $= ( IMP-sort-17-is-pattern KSEQ-symbol-0-is-pattern kore-dv-is-pattern kore-inj-is-pattern BASIC-K-sort-1-is-pattern IMP-sort-23-is-pattern KSEQ-symbol-1-is-pattern in-sort-is-pattern string-literal-14-is-pattern IMP-symbol-79-is-pattern string-literal-17-is-pattern IMP-symbol-91-is-pattern IMP-sort-31-is-pattern string-literal-11-is-pattern IMP-sort-13-is-pattern string-literal-4-is-pattern IMP-symbol-185-is-pattern BASIC-K-sort-0-is-pattern top-is-pattern string-literal-15-is-pattern and-is-pattern rule-and-intro-alt2-sugar KSEQ-symbol-0-sorting rule-imp-transitivity sorting-cache-84 sorting-cache-222 sorting-cache-216 ) SFEFTCDEHAEAICDGBJAEAKCDGBLMEANCFOFPCDQDGBBBRHUAFEFTCDAEAICDGBJAEAKCDGBLMEANCFOFPCDQDGBBBBRHSFEFTCDEHAEAICDGBJAEAKCDGBLMEANCFOFPCDQDGBBBRHUESAEAICDGBJEHAEAKCDGBLMEANCFOFPCDQDGBBRHUAAEAICDGBJAEAKCDGBLMEANCFOFPCDQDGBBBRHSAEAICDGBJEHAEAKCDGBLMEANCFOFPCDQDGBBRHUFUGUBAEAICDGBJAEAKCDGBLMEANCFOFPCDQDGBBUCUDUBFEFTCDAEAICDGBJAEAKCDGBLMEANCFOFPCDQDGBBBUCUD $. $}
