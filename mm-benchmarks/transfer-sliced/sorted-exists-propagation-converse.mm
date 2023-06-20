$c \exists #Substitution #Notation \top #SetVariable #ElementVariable #Symbol \sorted-exists #Variable #Pattern #ApplicationContext \included \floor \inh \and \is-predicate #Fresh \imp |- ) \in-sort ( $.
$v ph2 ph0 xX x ph6 y ph3 ph4 yY ph5 ph1 $.
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
yY-is-var $f #Variable yY $.
element-var-is-var $a #Variable x $.
var-is-pattern $a #Pattern xX $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
fresh-in-exists-shadowed $a #Fresh x ( \exists x ph0 ) $.
${ $d xX ph0 $.
   fresh-disjoint $a #Fresh xX ph0 $. $}
${ fresh-after-substitution.0 $e #Fresh xX ph0 $.
   fresh-after-substitution.1 $e #Fresh xX ph1 $.
   fresh-after-substitution.2 $e #Substitution ph2 ph0 ph1 yY $.
   fresh-after-substitution $a #Fresh xX ph2 $. $}
substitution-identity $a #Substitution ph0 ph0 xX xX $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-symmetry.0 $e #Notation ph0 ph1 $.
   notation-symmetry $a #Notation ph1 ph0 $. $}
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-fresh.0 $e #Fresh xX ph0 $.
   notation-fresh.1 $e #Notation ph1 ph0 $.
   notation-fresh $a #Fresh xX ph1 $. $}
${ notation-proof.0 $e |- ph0 $.
   notation-proof.1 $e #Notation ph1 ph0 $.
   notation-proof $a |- ph1 $. $}
${ notation-imp.0 $e #Notation ph0 ph2 $.
   notation-imp.1 $e #Notation ph1 ph3 $.
   notation-imp $a #Notation ( \imp ph0 ph1 ) ( \imp ph2 ph3 ) $. $}
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-exists.0 $e #Substitution ph0 ph1 y x $.
   proof-rule-exists $a |- ( \imp ph0 ( \exists x ph1 ) ) $. $}
${ proof-rule-gen.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-gen.1 $e #Fresh x ph1 $.
   proof-rule-gen $a |- ( \imp ( \exists x ph0 ) ph1 ) $. $}
${ proof-rule-frame.0 $e #ApplicationContext xX ph0 $.
   proof-rule-frame.1 $e #Substitution ph1 ph0 ph3 xX $.
   proof-rule-frame.2 $e #Substitution ph2 ph0 ph4 xX $.
   proof-rule-frame.3 $e |- ( \imp ph3 ph4 ) $.
   proof-rule-frame $a |- ( \imp ph1 ph2 ) $. $}
floor-is-pattern $a #Pattern ( \floor ph0 ) $.
included-is-pattern $a #Pattern ( \included ph0 ph1 ) $.
included-is-sugar $a #Notation ( \included ph0 ph1 ) ( \floor ( \imp ph0 ph1 ) ) $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
in-sort-is-sugar $a #Notation ( \in-sort ph0 ph1 ) ( \included ph0 ( \inh ph1 ) ) $.
sorted-exists-is-pattern $a #Pattern ( \sorted-exists x ph0 ph1 ) $.
sorted-exists-is-sugar $a #Notation ( \sorted-exists x ph0 ph1 ) ( \exists x ( \and ( \in-sort x ph0 ) ph1 ) ) $.
is-predicate-is-pattern $a #Pattern ( \is-predicate ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ notation-is-predicate.0 $e #Notation ph0 ph1 $.
   notation-is-predicate $a #Notation ( \is-predicate ph0 ) ( \is-predicate ph1 ) $. $}
lemma-floor-is-predicate $a |- ( \is-predicate ( \floor ph0 ) ) $.
${ predicate-commutes-with-context.0 $e |- ( \is-predicate ph0 ) $.
   predicate-commutes-with-context.1 $e #ApplicationContext x ph1 $.
   predicate-commutes-with-context.2 $e #Substitution ph2 ph1 ph5 x $.
   predicate-commutes-with-context.3 $e #Substitution ph3 ph1 ( \and ph0 ph5 ) x $.
   predicate-commutes-with-context.4 $e #Substitution ph4 ph1 ( \and \top ph5 ) x $.
   predicate-commutes-with-context $a |- ( \imp ( \and ph0 ph2 ) ph3 ) $. $}
${ $d y ph0 $.
   sorted-exists-propagation-converse.0 $e #ApplicationContext x ph0 $.
   sorted-exists-propagation-converse.1 $e #Substitution ph1 ph0 ph5 x $.
   sorted-exists-propagation-converse.2 $e #Substitution ph2 ph0 ( \sorted-exists y ph6 ph5 ) x $.
   sorted-exists-propagation-converse.3 $e #Substitution ph3 ph0 ( \and ( \in-sort y ph6 ) ph5 ) x $.
   sorted-exists-propagation-converse.4 $e #Substitution ph4 ph0 ( \and \top ph5 ) x $.
   sorted-exists-propagation-converse $p |- ( \imp ( \sorted-exists y ph6 ph1 ) ph2 ) $= ( element-var-is-var var-is-pattern in-sort-is-pattern and-is-pattern exists-is-pattern inh-is-pattern imp-is-pattern sorted-exists-is-pattern included-is-pattern floor-is-pattern notation-reflexivity notation-symmetry notation-transitivity is-predicate-is-pattern notation-proof sorted-exists-is-sugar notation-is-predicate notation-imp lemma-floor-is-predicate included-is-sugar in-sort-is-sugar predicate-commutes-with-context substitution-identity proof-rule-exists proof-rule-frame rule-imp-transitivity fresh-disjoint fresh-in-exists-shadowed notation-fresh fresh-after-substitution proof-rule-gen ) IOPGQBRISCUAGBIUBCUAIOPGQBRCIIOPGQBRDCIOPGQABDEFHIOPGTUCUHIOPGQUHIOPGTUAUDUHIOPGTUCUHIOPGTUAUMIOPGTUCIOPGTUAUDIOPGTUCIOPGTUAUDIOPGTUAUDIOPGTUNIOPGTUAUDIOPGTUAUDIOPGTUAUDUEUFUGUKUIIOPGQIOPGTUCIOPGQIOPGTUCIOPGTUCIOPGUOIOPGTUCIOPGTUCIOPGTUCUEUFUGUKUIJKMNUPADCIOPGQFRGFIUBHOJMLIOPGQFRIOPGQFRISUAIOPGQFRGFIUBUAIOPGQFRIOPGQFRIIIOPGQFRIOUQURIOPGQFRGFIUBIOPGQFRIOPGQFRISIOPGQFRUEGFIUBIOPGQFRISIOPGQFRISGFIUJIOPGQFRISIOPGQFRISIOPGQFRISUEUFUGULUIUSUTAGFIUBCIOHOAIOVAIOPGQFRISGFIUBIOIOPGQFRIVBGFIUBIOPGQFRISIOPGQFRISGFIUJIOPGQFRISIOPGQFRISIOPGQFRISUEUFUGVCLVDVEGBIUBCIOPGQBRISCGBIUBIOPGQBRISIOPGQBRISGBIUJIOPGQBRISIOPGQBRISIOPGQBRISUEUFUGCUEULUI $. $}
