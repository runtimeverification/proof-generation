$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \app \kore-symbol-LblfillArray'LParUndsCommUndsCommUndsCommUndsRParUnds'ARRAY-SYNTAX'Unds'Array'Unds'Array'Unds'Int'Unds'Int'Unds'KItem \kore-symbol-LblfillArray'LParUndsCommUndsCommUndsCommUndsRParUnds'ARRAY-SYNTAX'Unds'Array'Unds'Array'Unds'Int'Unds'Int'Unds'KItem-symbol ) ( $.
$v ph0 ph2 sg0 ptn1 ptn3 ptn2 ph3 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-app.0 $e #Notation ph0 ph2 $.
   notation-app.1 $e #Notation ph1 ph3 $.
   notation-app $a #Notation ( \app ph0 ph1 ) ( \app ph2 ph3 ) $. $}
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
IMP-symbol-233-is-symbol $a #Symbol \kore-symbol-LblfillArray'LParUndsCommUndsCommUndsCommUndsRParUnds'ARRAY-SYNTAX'Unds'Array'Unds'Array'Unds'Int'Unds'Int'Unds'KItem-symbol $.
IMP-symbol-233-is-pattern $a #Pattern ( \kore-symbol-LblfillArray'LParUndsCommUndsCommUndsCommUndsRParUnds'ARRAY-SYNTAX'Unds'Array'Unds'Array'Unds'Int'Unds'Int'Unds'KItem ptn0 ptn1 ptn2 ptn3 ) $.
IMP-symbol-233-is-sugar $a #Notation ( \kore-symbol-LblfillArray'LParUndsCommUndsCommUndsCommUndsRParUnds'ARRAY-SYNTAX'Unds'Array'Unds'Array'Unds'Int'Unds'Int'Unds'KItem ptn0 ptn1 ptn2 ptn3 ) ( \app ( \app ( \app ( \app \kore-symbol-LblfillArray'LParUndsCommUndsCommUndsCommUndsRParUnds'ARRAY-SYNTAX'Unds'Array'Unds'Array'Unds'Int'Unds'Int'Unds'KItem-symbol ptn0 ) ptn1 ) ptn2 ) ptn3 ) $.
${ notation-cache-450 $p #Notation ( \kore-symbol-LblfillArray'LParUndsCommUndsCommUndsCommUndsRParUnds'ARRAY-SYNTAX'Unds'Array'Unds'Array'Unds'Int'Unds'Int'Unds'KItem ptn0 ptn1 ptn2 ptn3 ) ( \app ( \app ( \app ( \app \kore-symbol-LblfillArray'LParUndsCommUndsCommUndsCommUndsRParUnds'ARRAY-SYNTAX'Unds'Array'Unds'Array'Unds'Int'Unds'Int'Unds'KItem-symbol ptn0 ) ptn1 ) ptn2 ) ptn3 ) $= ( app-is-pattern IMP-symbol-233-is-symbol symbol-is-pattern notation-reflexivity notation-app IMP-symbol-233-is-pattern IMP-symbol-233-is-sugar notation-transitivity ) ABCDJFGAEBECEDEFGAEBECEDEABCDKFGAEBECEDFGAEBECEDFGAEBECFGAEBECFGAEBFGAEBFGAFGAFGHAHIBHICHIDHIL $. $}
