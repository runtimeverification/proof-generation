$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \kore-symbol-LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String-symbol \kore-symbol-LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String \app ) ( $.
$v ph0 ptn2 ph2 sg0 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
ptn0-pattern $f #Pattern ptn0 $.
ptn2-pattern $f #Pattern ptn2 $.
IMP-symbol-230-is-symbol $a #Symbol \kore-symbol-LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String-symbol $.
IMP-symbol-230-is-pattern $a #Pattern ( \kore-symbol-LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String ptn0 ) $.
IMP-symbol-230-is-sugar $a #Notation ( \kore-symbol-LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String ptn0 ) ( \app \kore-symbol-LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String-symbol ptn0 ) $.
${ notation-cache-444 $p #Notation ( \kore-symbol-LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String ptn2 ) ( \app \kore-symbol-LbldirectionalityChar'LParUndsRParUnds'STRING-COMMON'Unds'String'Unds'String-symbol ptn2 ) $= ( IMP-symbol-230-is-symbol symbol-is-pattern app-is-pattern IMP-symbol-230-is-pattern IMP-symbol-230-is-sugar notation-reflexivity notation-transitivity ) AEBCADBCADAFBCADGH $. $}
