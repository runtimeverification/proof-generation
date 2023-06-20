$c \kore-circularity #Notation #SetVariable \kore-always \kore-next #ElementVariable #Symbol \or #Variable #Pattern \inhabitant \inh \and \kore-all-path-next #Fresh \kore-not \kore-next-symbol \imp \app \bot \not ) \kore-top ( $.
$v ph0 xX ph2 sg0 ph1 X $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
X-is-element-var $f #SetVariable X $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
${ fresh-in-imp.0 $e #Fresh xX ph0 $.
   fresh-in-imp.1 $e #Fresh xX ph1 $.
   fresh-in-imp $a #Fresh xX ( \imp ph0 ph1 ) $. $}
${ fresh-in-app.0 $e #Fresh xX ph0 $.
   fresh-in-app.1 $e #Fresh xX ph1 $.
   fresh-in-app $a #Fresh xX ( \app ph0 ph1 ) $. $}
${ $d xX ph0 $.
   fresh-disjoint $a #Fresh xX ph0 $. $}
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-fresh.0 $e #Fresh xX ph0 $.
   notation-fresh.1 $e #Notation ph1 ph0 $.
   notation-fresh $a #Fresh xX ph1 $. $}
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
kore-next-is-symbol $a #Symbol \kore-next-symbol $.
kore-next-is-pattern $a #Pattern ( \kore-next ph0 ph1 ) $.
kore-next-is-sugar $a #Notation ( \kore-next ph0 ph1 ) ( \app \kore-next-symbol ph1 ) $.
kore-all-path-next-is-pattern $a #Pattern ( \kore-all-path-next ph0 ph1 ) $.
kore-all-path-next-is-sugar $a #Notation ( \kore-all-path-next ph0 ph1 ) ( \kore-not ph0 ( \kore-next ph0 ( \kore-not ph0 ph1 ) ) ) $.
kore-always-is-pattern $a #Pattern ( \kore-always ph0 ph1 ) $.
kore-circularity-is-pattern $a #Pattern ( \kore-circularity ph0 ph1 ) $.
kore-circularity-is-sugar $a #Notation ( \kore-circularity ph0 ph1 ) ( \kore-all-path-next ph0 ( \kore-always ph0 ph1 ) ) $.
${ $d X xX $.
   $d X ph0 $.
   $d X ph1 $.
   fresh-in-kore-always.0 $e #Fresh xX ph0 $.
   fresh-in-kore-always.1 $e #Fresh xX ph1 $.
   fresh-in-kore-always $a #Fresh xX ( \kore-always ph0 ph1 ) $. $}
${ $d X xX $.
   $d X ph0 $.
   $d X ph1 $.
   fresh-in-kore-circularity.0 $e #Fresh xX ph0 $.
   fresh-in-kore-circularity.1 $e #Fresh xX ph1 $.
   fresh-in-kore-circularity $p #Fresh xX ( \kore-circularity ph0 ph1 ) $= ( not-is-pattern kore-always-is-pattern kore-not-is-pattern kore-top-is-pattern kore-next-is-pattern bot-is-pattern imp-is-pattern or-is-pattern notation-reflexivity notation-transitivity notation-fresh symbol-is-pattern fresh-disjoint and-is-pattern app-is-pattern fresh-in-imp inh-is-pattern inhabitant-is-symbol not-is-sugar kore-all-path-next-is-pattern kore-next-is-symbol fresh-in-app kore-circularity-is-pattern inh-is-sugar kore-top-is-sugar or-is-sugar and-is-sugar kore-not-is-sugar fresh-in-kore-always kore-next-is-sugar kore-all-path-next-is-sugar kore-circularity-is-sugar ) AABGUEABUHCAAAABGHJHAABGUECAAABGHJFAISAAAABGHJHCAAABGHJFFAIFMFAAABGHJFAISCAAABGHJFFAIFMKLAAABGHJFFAIFMFCAAABGHJFFAIFMKCAAABGHJFFFAIFLAAABGHJFFAIFMCAAABGHJFFFAIFCAAABGHJFFKLAAABGHJFFFCAAABGHJFFKCAAABGHJFKLAAABGHJFFCAAABGHJFKCAAABGHJKLAAABGHJFCAAABGHJKCUFQAABGHTAAABGHJCUFQAABGHCUFQCRABGFAISAABGHCABGFFAIFMFABGFAISCABGFFAIFMKLABGFFAIFMFCABGFFAIFMKCABGFFFAIFLABGFFAIFMCABGFFFAIFCABGFFKLABGFFFCABGFFKCABGFKLABGFFCABGFKCABGKLABGFCABGKCABCDEUNKCRUAABGFABGKLABGKLABGUDABGKLNOPKCRUAABGFFABGFKLABGFKLABGFUDABGFKLNOPKCRUAABGFFFABGFFKLABGFFKLABGFFUDABGFFKLNOPAIKLAIFCAIKCAUBAICUCQATAUBCUCQACUCQCRDUGAUBUCQATUCQATAUIUCQATNOPAIAUBAUBAUJAUBNOPKCRUAAIFAIKLAIKLAIUDAIKLNOPUAABGFFAIFMABGFFFAIFLABGFFFAIFLABGFFAIFUKABGFFFAIFLNOPKCRUAABGFFAIFMFABGFFAIFMKLABGFFAIFMKLABGFFAIFMUDABGFFAIFMKLNOPABGFAISABGFFAIFMFABGFFAIFMFABGFAIULABGFFAIFMFNOPAABGHABGFAISABGFAISAABGUMABGFAISNOPUGAAABGHJUFQAABGHTUFQAABGHTAAABGHUOUFQAABGHTNOPKCRUAAAABGHJFAAABGHJKLAAABGHJKLAAABGHJUDAAABGHJKLNOPKCRUAAAABGHJFFAAABGHJFKLAAABGHJFKLAAABGHJFUDAAABGHJFKLNOPKCRUAAAABGHJFFFAAABGHJFFKLAAABGHJFFKLAAABGHJFFUDAAABGHJFFKLNOPAIKLAIFCAIKCAUBAICUCQATAUBCUCQACUCQCRDUGAUBUCQATUCQATAUIUCQATNOPAIAUBAUBAUJAUBNOPKCRUAAIFAIKLAIKLAIUDAIKLNOPUAAAABGHJFFAIFMAAABGHJFFFAIFLAAABGHJFFFAIFLAAABGHJFFAIFUKAAABGHJFFFAIFLNOPKCRUAAAABGHJFFAIFMFAAABGHJFFAIFMKLAAABGHJFFAIFMKLAAABGHJFFAIFMUDAAABGHJFFAIFMKLNOPAAABGHJFAISAAABGHJFFAIFMFAAABGHJFFAIFMFAAABGHJFAIULAAABGHJFFAIFMFNOPAAAABGHJHAAABGHJFAISAAABGHJFAISAAAABGHJUMAAABGHJFAISNOPAABGUEAAAABGHJHAAAABGHJHAABGUPAAAABGHJHNOPABUHAABGUEAABGUEABUQAABGUENOP $. $}
