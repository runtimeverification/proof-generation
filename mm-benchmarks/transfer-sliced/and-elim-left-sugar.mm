$c #Notation #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp ( |- \bot \not ) \and $.
$v ph0 ph2 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-symmetry.0 $e #Notation ph0 ph1 $.
   notation-symmetry $a #Notation ph1 ph0 $. $}
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-proof.0 $e |- ph0 $.
   notation-proof.1 $e #Notation ph1 ph0 $.
   notation-proof $a |- ph1 $. $}
${ notation-imp.0 $e #Notation ph0 ph2 $.
   notation-imp.1 $e #Notation ph1 ph3 $.
   notation-imp $a #Notation ( \imp ph0 ph1 ) ( \imp ph2 ph3 ) $. $}
not-is-pattern $a #Pattern ( \not ph0 ) $.
not-is-sugar $a #Notation ( \not ph0 ) ( \imp ph0 \bot ) $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
or-is-sugar $a #Notation ( \or ph0 ph1 ) ( \imp ( \not ph0 ) ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
and-is-sugar $a #Notation ( \and ph0 ph1 ) ( \not ( \or ( \not ph0 ) ( \not ph1 ) ) ) $.
and-elim-left $a |- ( \imp ( \imp ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ( \imp ph1 \bot ) ) \bot ) ph0 ) $.
${ and-elim-left-sugar $p |- ( \imp ( \and ph0 ph1 ) ph0 ) $= ( imp-is-pattern bot-is-pattern not-is-pattern notation-symmetry or-is-pattern notation-transitivity notation-reflexivity not-is-sugar notation-imp and-is-pattern and-elim-left and-is-sugar or-is-sugar notation-proof ) ADCDCBDCCDCACABLACABMABLAADCDCBDCCDCAABLAEBEGEADCDCBDCCDCABNADCDCBDCCDCAEBEGEAEBEGEADCDCBDCCDCAEBEGEAEBEGDCADCDCBDCCDCAEBEGJADCDCBDCCDCAEBEGDCADCDCBDCCDAEBEGDAEBEGADCDCBDCCAEBEGAEEBECADCDCBDCCAEBEOADCDCBDCCAEEBECADCDCBDCAEEBEAEEADCDCAEEAEDCADCDCAEJADCDCAEDCADCDAEDAEADCAEADCADCAJADCADCADCIFHFDIKFHFBEBDCBEBDCBDCBJBDCBDCBDCIFHFKFHFDIKFHFFHAIKP $. $}
