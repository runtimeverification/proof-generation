$c #Notation #SetVariable #Positive #ElementVariable #Symbol \or #Variable #Pattern \inhabitant \inh \and \kore-not #Negative \imp \app \bot \not ) \kore-top ( $.
$v ph0 xX ph2 sg0 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
${ positive-in-imp.0 $e #Negative xX ph0 $.
   positive-in-imp.1 $e #Positive xX ph1 $.
   positive-in-imp $a #Positive xX ( \imp ph0 ph1 ) $. $}
${ $d xX ph0 $.
   positive-disjoint $a #Positive xX ph0 $. $}
${ negative-in-imp.0 $e #Positive xX ph0 $.
   negative-in-imp.1 $e #Negative xX ph1 $.
   negative-in-imp $a #Negative xX ( \imp ph0 ph1 ) $. $}
${ negative-in-app.0 $e #Negative xX ph0 $.
   negative-in-app.1 $e #Negative xX ph1 $.
   negative-in-app $a #Negative xX ( \app ph0 ph1 ) $. $}
${ $d xX ph0 $.
   negative-disjoint $a #Negative xX ph0 $. $}
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-positive.0 $e #Positive xX ph0 $.
   notation-positive.1 $e #Notation ph1 ph0 $.
   notation-positive $a #Positive xX ph1 $. $}
${ notation-negative.0 $e #Negative xX ph0 $.
   notation-negative.1 $e #Notation ph1 ph0 $.
   notation-negative $a #Negative xX ph1 $. $}
not-is-pattern $a #Pattern ( \not ph0 ) $.
not-is-sugar $a #Notation ( \not ph0 ) ( \imp ph0 \bot ) $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
or-is-sugar $a #Notation ( \or ph0 ph1 ) ( \imp ( \not ph0 ) ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
and-is-sugar $a #Notation ( \and ph0 ph1 ) ( \not ( \or ( \not ph0 ) ( \not ph1 ) ) ) $.
inhabitant-is-symbol $a #Symbol \inhabitant $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
inh-is-sugar $a #Notation ( \inh ph0 ) ( \app \inhabitant ph0 ) $.
kore-top-is-pattern $a #Pattern ( \kore-top ph0 ) $.
kore-top-is-sugar $a #Notation ( \kore-top ph0 ) ( \inh ph0 ) $.
kore-not-is-pattern $a #Pattern ( \kore-not ph0 ph1 ) $.
kore-not-is-sugar $a #Notation ( \kore-not ph0 ph1 ) ( \and ( \not ph1 ) ( \kore-top ph0 ) ) $.
${ negative-in-kore-not.0 $e #Negative xX ph0 $.
   negative-in-kore-not.1 $e #Positive xX ph1 $.
   negative-in-kore-not $p #Negative xX ( \kore-not ph0 ph1 ) $= ( not-is-pattern kore-top-is-pattern bot-is-pattern imp-is-pattern or-is-pattern notation-reflexivity notation-transitivity notation-negative and-is-pattern inh-is-pattern inhabitant-is-symbol symbol-is-pattern not-is-sugar negative-disjoint app-is-pattern negative-in-imp positive-in-imp notation-positive kore-not-is-pattern positive-disjoint negative-in-app inh-is-sugar kore-top-is-sugar or-is-sugar and-is-sugar kore-not-is-sugar ) BFAGNABUDCBFFAGFJFBFAGNCBFFAGFJHIBFFAGFJFCBFFAGFJHCBFFFAGFIBFFAGFJCBFFFAGFCBFFHIBFFFCBFFHCBFHIBFFCBFHCBHIBFCBHCEHCSUABFBHIBHIBRBHIKLMHCUEUBBFFBFHIBFHIBFRBFHIKLUCHCSUABFFFBFFHIBFFHIBFFRBFFHIKLMAGHIAGFCAGHCAOAGCPQATAOCPQACPQCSDUFAOPQATPQATAUGPQATKLMAGAOAOAUHAOKLMHCUEUBAGFAGHIAGHIAGRAGHIKLUCUBBFFAGFJBFFFAGFIBFFFAGFIBFFAGFUIBFFFAGFIKLUCHCSUABFFAGFJFBFFAGFJHIBFFAGFJHIBFFAGFJRBFFAGFJHIKLMBFAGNBFFAGFJFBFFAGFJFBFAGUJBFFAGFJFKLMABUDBFAGNBFAGNABUKBFAGNKLM $. $}
