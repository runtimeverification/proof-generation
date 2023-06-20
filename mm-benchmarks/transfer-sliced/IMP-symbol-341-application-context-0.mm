$c #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern #ApplicationContext \kore-symbol-LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int-symbol \app ) \kore-symbol-LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int ( $.
$v ph0 xX xX0 sg0 ptn1 ptn2 ptn0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
${ $d xX ph1 $.
   application-context-app-left.0 $e #ApplicationContext xX ph0 $.
   application-context-app-left $a #ApplicationContext xX ( \app ph0 ph1 ) $. $}
${ $d xX ph0 $.
   application-context-app-right.0 $e #ApplicationContext xX ph1 $.
   application-context-app-right $a #ApplicationContext xX ( \app ph0 ph1 ) $. $}
${ notation-application-context.0 $e #ApplicationContext xX ph0 $.
   notation-application-context.1 $e #Notation ph1 ph0 $.
   notation-application-context $a #ApplicationContext xX ph1 $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
IMP-symbol-341-is-symbol $a #Symbol \kore-symbol-LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int-symbol $.
IMP-symbol-341-is-pattern $a #Pattern ( \kore-symbol-LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int ptn0 ptn1 ptn2 ) $.
notation-cache-737 $a #Notation ( \kore-symbol-LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int ptn0 ptn1 ptn2 ) ( \app ( \app ( \app \kore-symbol-LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int-symbol ptn0 ) ptn1 ) ptn2 ) $.
${ $d xX0 ptn1 $.
   $d xX0 ptn2 $.
   IMP-symbol-341-application-context-0.0 $e #ApplicationContext xX0 ptn0 $.
   IMP-symbol-341-application-context-0 $p #ApplicationContext xX0 ( \kore-symbol-LblrfindChar'LParUndsCommUndsCommUndsRParUnds'STRING-COMMON'Unds'Int'Unds'String'Unds'String'Unds'Int ptn0 ptn1 ptn2 ) $= ( app-is-pattern IMP-symbol-341-is-symbol symbol-is-pattern application-context-app-left IMP-symbol-341-is-pattern application-context-app-right notation-cache-737 notation-application-context ) GHBFCFDFBCDJAGHBFCFDAGHBFCAGHBAEKIIBCDLM $. $}
