$c #Substitution \top #SetVariable \kore-sort-SortAExp #ElementVariable #Symbol \kore-sort-SortStmt #Variable #Pattern \kore-exists \imp \kore-dv ( "ret" \kore-sort-SortId \kore-valid ) \kore-equals \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp \in-sort \and $.
$v ph6 kore-element-var-x0 kore-element-var-Val ph3 kore-element-var-K1 ph1 kore-sort-var-R ph0 ph2 xX x y ph4 ph5 $.
$d kore-element-var-x0 kore-element-var-Val $.
$d kore-element-var-K1 kore-element-var-Val $.
$d kore-sort-var-R kore-element-var-Val $.
$d kore-element-var-K1 x $.
$d kore-sort-var-R kore-element-var-K1 $.
$d kore-element-var-Val x $.
$d kore-element-var-x0 kore-element-var-K1 $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-x0 kore-sort-var-R $.
$d y kore-element-var-Val $.
$d y kore-element-var-K1 $.
$d y kore-sort-var-R $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
top-is-pattern $a #Pattern \top $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
kore-exists-is-pattern $a #Pattern ( \kore-exists ph0 ph1 x ph2 ) $.
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
${ $d xX y $.
   $d y ph6 $.
   substitution-kore-exists-alt.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-exists-alt.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-exists-alt.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-exists-alt $a #Substitution ( \kore-exists ph0 ph1 y ph2 ) ( \kore-exists ph3 ph4 y ph5 ) ph6 xX $. $}
${ substitution-kore-valid.0 $e #Substitution ph0 ph2 ph4 xX $.
   substitution-kore-valid.1 $e #Substitution ph1 ph3 ph4 xX $.
   substitution-kore-valid $a #Substitution ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) ph4 xX $. $}
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-31-is-pattern $a #Pattern \kore-sort-SortStmt $.
kore-element-var-Val-elementvariable $f #ElementVariable kore-element-var-Val $.
kore-element-var-K1-elementvariable $f #ElementVariable kore-element-var-K1 $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-49 $a #Pattern kore-element-var-K1 $.
substitution-249 $a #Substitution kore-sort-var-R kore-sort-var-R kore-element-var-x0 kore-element-var-K1 $.
substitution-290 $a #Substitution ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortAExp ) \top ) ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) kore-element-var-x0 kore-element-var-K1 $.
substitution-291 $a #Substitution \kore-sort-SortStmt \kore-sort-SortStmt kore-element-var-x0 kore-element-var-K1 $.
typecode-cache-Pattern-127 $a #Pattern ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) kore-element-var-K1 ) ) $.
typecode-cache-Pattern-128 $a #Pattern ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) kore-element-var-x0 ) ) $.
substitution-365 $a #Substitution ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) kore-element-var-x0 ) ) ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) kore-element-var-K1 ) ) kore-element-var-x0 kore-element-var-K1 $.
${ substitution-366 $p #Substitution ( \imp ( \and ( \in-sort kore-element-var-x0 \kore-sort-SortAExp ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) kore-element-var-x0 ) ) ) ) ) ( \imp ( \and ( \in-sort kore-element-var-K1 \kore-sort-SortAExp ) \top ) ( \kore-valid kore-sort-var-R ( \kore-exists \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-equals \kore-sort-SortStmt kore-sort-var-R kore-element-var-Val ( \kore-symbol-Lbl'UndsEqlsUndsSClnUnds'IMP-SYNTAX'Unds'Stmt'Unds'Id'Unds'AExp ( \kore-dv \kore-sort-SortId "ret" ) kore-element-var-K1 ) ) ) ) ) kore-element-var-x0 kore-element-var-K1 $= ( typecode-cache-Pattern-0 IMP-sort-31-is-pattern typecode-cache-Pattern-25 kore-exists-is-pattern typecode-cache-Pattern-128 typecode-cache-Pattern-127 element-var-is-var IMP-sort-13-is-pattern in-sort-is-pattern top-is-pattern and-is-pattern kore-valid-is-pattern substitution-249 typecode-cache-Pattern-49 substitution-290 substitution-291 substitution-365 substitution-kore-exists-alt substitution-kore-valid substitution-imp ) DGDGLMNOAEFAEABDIBHPCRLMNOAEFAEABCJBHPCKCDSAEFAEABDIBHAEFAEABCJBHDGCKACDQFAEABDIFAEABCJDGBCKCDTACDQABCDUAUBUCUD $. $}
