$c #Notation #SetVariable \ceil #ElementVariable #Symbol #Variable #Pattern \included \floor \inh \imp ( |- \bot \not ) \in-sort \and $.
$v ph0 ph2 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
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
not-is-pattern $a #Pattern ( \not ph0 ) $.
not-is-sugar $a #Notation ( \not ph0 ) ( \imp ph0 \bot ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
ceil-is-pattern $a #Pattern ( \ceil ph0 ) $.
floor-is-pattern $a #Pattern ( \floor ph0 ) $.
floor-is-sugar $a #Notation ( \floor ph0 ) ( \not ( \ceil ( \not ph0 ) ) ) $.
included-is-pattern $a #Pattern ( \included ph0 ph1 ) $.
included-is-sugar $a #Notation ( \included ph0 ph1 ) ( \floor ( \imp ph0 ph1 ) ) $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
in-sort-is-sugar $a #Notation ( \in-sort ph0 ph1 ) ( \included ph0 ( \inh ph1 ) ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-contrapositive-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-contrapositive-sugar $a |- ( \imp ( \not ph1 ) ( \not ph0 ) ) $. $}
${ lemma-floor-elim.0 $e |- ( \floor ph0 ) $.
   lemma-floor-elim $a |- ph0 $. $}
${ disjointness-in-sort.0 $e |- ( \in-sort ph0 ph2 ) $.
   disjointness-in-sort.1 $e |- ( \not ( \and ( \inh ph2 ) ph1 ) ) $.
   disjointness-in-sort $p |- ( \not ( \and ph0 ph1 ) ) $= ( imp-is-pattern inh-is-pattern not-is-pattern ceil-is-pattern bot-is-pattern notation-symmetry and-is-pattern floor-is-pattern notation-transitivity included-is-pattern in-sort-is-pattern floor-is-sugar not-is-sugar and-elim-left-sugar in-sort-is-sugar included-is-sugar notation-reflexivity notation-proof lemma-floor-elim rule-imp-transitivity and-elim-right-sugar rule-and-intro-alt2-sugar rule-contrapositive-sugar proof-rule-mp ) CGBLHABLHABLCGBLABLCGBABLACGABSACGFACPACGFMDACGFMACGFHIHACPACGFQACPACGFHIHACPACGOACGFHIHACTACGFHIHACGOACGFHIHACGFHIJFACGOACGFHIRACGOACGFHIJFACGOACGFMACGFHIJFACGUAACGFHIJFACGFMACGFMACGFHIJFACGFMACGFHIHACGFHIJFACGFQACGFHIJFACGFHIHACGFHIHACGFHIJFACGFHIHACGFHIJFACGFHIJFACGFHIRACGFHIJFACGFHIJFACGFHIJFUBKNKKNKKNKNKNKNUCUDUEABUFUGUHEUI $. $}
