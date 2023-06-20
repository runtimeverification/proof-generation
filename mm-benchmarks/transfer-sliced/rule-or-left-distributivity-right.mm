$c #SetVariable #ElementVariable #Symbol \or #Variable #Pattern \imp ( |- \not ) \and $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
not-is-pattern $a #Pattern ( \not ph0 ) $.
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
proof-rule-prop-2 $a |- ( \imp ( \imp ph0 ( \imp ph1 ph2 ) ) ( \imp ( \imp ph0 ph1 ) ( \imp ph0 ph2 ) ) ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
imp-transitivity $a |- ( \imp ( \imp ph0 ph1 ) ( \imp ( \imp ph1 ph2 ) ( \imp ph0 ph2 ) ) ) $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
and-intro-sugar $a |- ( \imp ph0 ( \imp ph1 ( \and ph0 ph1 ) ) ) $.
or-intro-left-sugar $a |- ( \imp ph0 ( \or ph0 ph1 ) ) $.
or-intro-right-sugar $a |- ( \imp ph0 ( \or ph1 ph0 ) ) $.
case $a |- ( \imp ( \imp ph0 ph1 ) ( \imp ( \imp ( \not ph0 ) ph1 ) ph1 ) ) $.
or-commutativity-alt $a |- ( \imp ( \imp ( \not ph0 ) ph1 ) ( \imp ( \not ph1 ) ph0 ) ) $.
or-to-imp-alt $a |- ( \imp ( \or ph0 ph1 ) ( \imp ( \not ph0 ) ph1 ) ) $.
${ rule-or-left-distributivity-right.0 $e |- ( \and ( \or ph0 ph2 ) ( \or ph1 ph2 ) ) $.
   rule-or-left-distributivity-right $p |- ( \or ( \and ph0 ph1 ) ph2 ) $= ( imp-is-pattern and-is-pattern not-is-pattern or-is-pattern proof-rule-mp proof-rule-prop-2 or-commutativity-alt or-to-imp-alt case or-intro-right-sugar imp-transitivity proof-rule-prop-1 and-intro-sugar and-elim-left-sugar and-elim-right-sugar or-intro-left-sugar ) CGABFCHEABFCHCABFCHECGABFCHEABFCHECABFCHMCABFNIABFABFCHECGABFCHECGABFEABFABFCHECGABFCHEECGABFABFCHOCGBECGABFECGBABFEECGBECGABFEECGBABFJCGAECGBABFEECGABABFEEECGAECGBABFEEECGABABFEJABABFEECGABABFEEEABABFEECGPABQIIAGCECGAEACKACHAGCEACLACHBCHFACHACHBCHRDIIIIIBGCECGBEBCKBCHBGCEBCLACHBCHFBCHACHBCHSDIIIIIABFCTII $. $}
