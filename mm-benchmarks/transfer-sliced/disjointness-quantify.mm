$c \exists #Notation \iff #SetVariable #ElementVariable \forall #Symbol \sorted-exists #Variable #Pattern #Fresh \imp ( |- \not ) \in-sort \and $.
$v ph0 ph2 xX x ph3 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
var-is-pattern $a #Pattern xX $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
${ $d xX ph0 $.
   fresh-disjoint $a #Fresh xX ph0 $. $}
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
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
sorted-exists-is-pattern $a #Pattern ( \sorted-exists x ph0 ph1 ) $.
sorted-exists-is-sugar $a #Notation ( \sorted-exists x ph0 ph1 ) ( \exists x ( \and ( \in-sort x ph0 ) ph1 ) ) $.
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
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
and-commutativity $a |- ( \iff ( \and ph0 ph1 ) ( \and ph1 ph0 ) ) $.
${ notation-not.0 $e #Notation ph0 ph1 $.
   notation-not $a #Notation ( \not ph0 ) ( \not ph1 ) $. $}
${ notation-and.0 $e #Notation ph0 ph2 $.
   notation-and.1 $e #Notation ph1 ph3 $.
   notation-and $a #Notation ( \and ph0 ph1 ) ( \and ph2 ph3 ) $. $}
${ lemma-forall-intro.0 $e |- ph0 $.
   lemma-forall-intro $a |- ( \forall x ph0 ) $. $}
${ prenex-exists-and-left.0 $e #Fresh x ph1 $.
   prenex-exists-and-left $a |- ( \imp ( \and ( \exists x ph0 ) ph1 ) ( \exists x ( \and ph0 ph1 ) ) ) $. $}
${ forall-not-to-not-exists.0 $e |- ( \forall x ( \not ph0 ) ) $.
   forall-not-to-not-exists $a |- ( \not ( \exists x ph0 ) ) $. $}
${ $d x ph0 $.
   disjointness-quantify.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
   disjointness-quantify $p |- ( \not ( \and ph0 ( \sorted-exists x ph2 ph1 ) ) ) $= ( and-is-pattern element-var-is-var var-is-pattern in-sort-is-pattern exists-is-pattern not-is-pattern sorted-exists-is-pattern rule-imp-transitivity rule-contrapositive-sugar and-elim-right-sugar proof-rule-mp notation-reflexivity and-commutativity rule-iff-elim-left fresh-disjoint prenex-exists-and-left and-elim-left-sugar rule-and-intro-alt2-sugar lemma-forall-intro forall-not-to-not-exists sorted-exists-is-sugar notation-symmetry notation-transitivity notation-and notation-not notation-proof ) ADGHCIBFDJFKACBDLFKDGHCIBFAFDJKADGHCIBFDJFKADGHCIBFDJFDGHCIBFAFDJADGHCIBFDJFDGHCIBFDJAFDGHCIBFAFDJADGHCIBFDJFDGHCIBFDJAFADGHCIBFDJRSDGHCIBFADADGTUAMNDGHCIBFAFDDGHCIBFAFKDABFKDGHCIBFAFKDGHCIBFAFABFDGHCIBFAFABDGHCIBFAODGHCIBFAFDGHCIBFBDGHCIBFAUBDGHCIBOMUCNEPUDUEPACBDLFADGHCIBFDJFACBDLADGHCIBFDJAQCBDLDGHCIBFDJDGHCIBFDJCBDUFDGHCIBFDJDGHCIBFDJDGHCIBFDJQUGUHUIUJUK $. $}
