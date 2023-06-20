$c \iff #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp ( |- \not ) \and $.
$v ph0 ph2 ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-iff-intro.0 $e |- ( \imp ph0 ph1 ) $.
   rule-iff-intro.1 $e |- ( \imp ph1 ph0 ) $.
   rule-iff-intro $a |- ( \iff ph0 ph1 ) $. $}
${ rule-contrapositive-alt-sugar.0 $e |- ( \imp ( \not ph0 ) ( \not ph1 ) ) $.
   rule-contrapositive-alt-sugar $a |- ( \imp ph1 ph0 ) $. $}
${ rule-imp-compat-in-or.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-compat-in-or.1 $e |- ( \imp ph2 ph3 ) $.
   rule-imp-compat-in-or $a |- ( \imp ( \or ph0 ph2 ) ( \or ph1 ph3 ) ) $. $}
${ rule-imp-compat-in-and.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-compat-in-and.1 $e |- ( \imp ph2 ph3 ) $.
   rule-imp-compat-in-and $a |- ( \imp ( \and ph0 ph2 ) ( \and ph1 ph3 ) ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
${ rule-iff-elim-right.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-right $a |- ( \imp ph1 ph0 ) $. $}
de-morgan-and $a |- ( \iff ( \not ( \and ph0 ph1 ) ) ( \or ( \not ph0 ) ( \not ph1 ) ) ) $.
de-morgan-or $a |- ( \iff ( \not ( \or ph0 ph1 ) ) ( \and ( \not ph0 ) ( \not ph1 ) ) ) $.
or-left-distributivity $a |- ( \iff ( \or ( \and ph0 ph1 ) ph2 ) ( \and ( \or ph0 ph2 ) ( \or ph1 ph2 ) ) ) $.
${ and-left-distributivity $p |- ( \iff ( \and ( \or ph0 ph1 ) ph2 ) ( \or ( \and ph0 ph2 ) ( \and ph1 ph2 ) ) ) $= ( not-is-pattern and-is-pattern or-is-pattern rule-imp-transitivity rule-iff-elim-left de-morgan-and rule-iff-elim-right de-morgan-or rule-imp-compat-in-and or-left-distributivity imp-reflexivity rule-imp-compat-in-or rule-contrapositive-alt-sugar rule-iff-intro ) ABFCEACEBCEFACEBCEFABFCEACEBCEFDADCDFBDCDFEABFCEDACEBCEFDACEDBCEDEADCDFBDCDFEACEBCEFDACEDBCEDEACEBCEKHACEDADCDFBCEDBDCDFACEDADCDFACIHBCEDBDCDFBCIHLGADCDFBDCDFEADBDECDFABFCEDADBDECDFADCDFBDCDFEADBDCDMJADBDECDFABFDCDFABFCEDADBDEABFDCDCDABFDADBDEABKJCDNOABFCEDABFDCDFABFCIJGGGPABFCEACEBCEFABFCEDADBDECDFACEBCEFDABFCEDABFDCDFADBDECDFABFCEDABFDCDFABFCIHABFDADBDECDCDABFDADBDEABKHCDNOGADBDECDFACEDBCEDEACEBCEFDADBDECDFADCDFBDCDFEACEDBCEDEADBDECDFADCDFBDCDFEADBDCDMHADCDFACEDBDCDFBCEDACEDADCDFACIJBCEDBDCDFBCIJLGACEBCEFDACEDBCEDEACEBCEKJGGPQ $. $}
