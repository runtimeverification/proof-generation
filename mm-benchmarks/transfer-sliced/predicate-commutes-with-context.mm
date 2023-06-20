$c #Substitution #Notation \iff \top #SetVariable #ElementVariable #Symbol \or \eq #Variable #Pattern #ApplicationContext \floor \is-predicate \imp ( |- \bot \not ) \is-top \is-bot \and $.
$v ph0 ph2 xX x ph3 ph4 ph5 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
x-is-element-var $f #ElementVariable x $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
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
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
or-is-sugar $a #Notation ( \or ph0 ph1 ) ( \imp ( \not ph0 ) ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp $a |- ph1 $. $}
${ proof-rule-frame.0 $e #ApplicationContext xX ph0 $.
   proof-rule-frame.1 $e #Substitution ph1 ph0 ph3 xX $.
   proof-rule-frame.2 $e #Substitution ph2 ph0 ph4 xX $.
   proof-rule-frame.3 $e |- ( \imp ph3 ph4 ) $.
   proof-rule-frame $a |- ( \imp ph1 ph2 ) $. $}
top-is-pattern $a #Pattern \top $.
iff-is-pattern $a #Pattern ( \iff ph0 ph1 ) $.
iff-is-sugar $a #Notation ( \iff ph0 ph1 ) ( \and ( \imp ph0 ph1 ) ( \imp ph1 ph0 ) ) $.
floor-is-pattern $a #Pattern ( \floor ph0 ) $.
eq-is-pattern $a #Pattern ( \eq ph0 ph1 ) $.
eq-is-sugar $a #Notation ( \eq ph0 ph1 ) ( \floor ( \iff ph0 ph1 ) ) $.
${ eq-elim.0 $e #Substitution ph2 ph4 ph0 x $.
   eq-elim.1 $e #Substitution ph3 ph4 ph1 x $.
   eq-elim $a |- ( \imp ( \eq ph0 ph1 ) ( \imp ph2 ph3 ) ) $. $}
is-top-is-pattern $a #Pattern ( \is-top ph0 ) $.
is-top-is-sugar $a #Notation ( \is-top ph0 ) ( \eq ph0 \top ) $.
is-bot-is-pattern $a #Pattern ( \is-bot ph0 ) $.
is-bot-is-sugar $a #Notation ( \is-bot ph0 ) ( \eq ph0 \bot ) $.
is-predicate-is-pattern $a #Pattern ( \is-predicate ph0 ) $.
is-predicate-is-sugar $a #Notation ( \is-predicate ph0 ) ( \or ( \is-top ph0 ) ( \is-bot ph0 ) ) $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
imp-transitivity $a |- ( \imp ( \imp ph0 ph1 ) ( \imp ( \imp ph1 ph2 ) ( \imp ph0 ph2 ) ) ) $.
top-intro $a |- \top $.
mp $a |- ( \imp ph0 ( \imp ( \imp ph0 ph1 ) ph1 ) ) $.
not-elim-alt $a |- ( \imp ( \imp ph0 \bot ) ( \imp ph0 ph1 ) ) $.
and-elim-left-sugar $a |- ( \imp ( \and ph0 ph1 ) ph0 ) $.
and-elim-right-sugar $a |- ( \imp ( \and ph0 ph1 ) ph1 ) $.
${ rule-and-intro-alt2-sugar.0 $e |- ( \imp ph0 ph1 ) $.
   rule-and-intro-alt2-sugar.1 $e |- ( \imp ph0 ph2 ) $.
   rule-and-intro-alt2-sugar $a |- ( \imp ph0 ( \and ph1 ph2 ) ) $. $}
${ rule-case-alt.0 $e |- ( \or ph0 ph1 ) $.
   rule-case-alt.1 $e |- ( \imp ph0 ph2 ) $.
   rule-case-alt.2 $e |- ( \imp ph1 ph2 ) $.
   rule-case-alt $a |- ph2 $. $}
lemma-curry-left $a |- ( \imp ( \imp ( \and ph0 ph1 ) ph2 ) ( \imp ph0 ( \imp ph1 ph2 ) ) ) $.
${ lemma-imp-compat-in-floor.0 $e |- ( \imp ph0 ph1 ) $.
   lemma-imp-compat-in-floor $a |- ( \imp ( \floor ph0 ) ( \floor ph1 ) ) $. $}
lemma-eq-imp $a |- ( \imp ( \eq ph0 ph1 ) ( \imp ph0 ph1 ) ) $.
${ rule-weakening.0 $e |- ph1 $.
   rule-weakening $a |- ( \imp ph0 ph1 ) $. $}
${ predicate-commutes-with-context.0 $e |- ( \is-predicate ph0 ) $.
   predicate-commutes-with-context.1 $e #ApplicationContext x ph1 $.
   predicate-commutes-with-context.2 $e #Substitution ph2 ph1 ph5 x $.
   predicate-commutes-with-context.3 $e #Substitution ph3 ph1 ( \and ph0 ph5 ) x $.
   predicate-commutes-with-context.4 $e #Substitution ph4 ph1 ( \and \top ph5 ) x $.
   predicate-commutes-with-context $p |- ( \imp ( \and ph0 ph2 ) ph3 ) $= ( and-is-pattern top-is-pattern imp-is-pattern is-bot-is-pattern eq-is-pattern is-top-is-pattern iff-is-pattern bot-is-pattern floor-is-pattern not-is-pattern notation-symmetry notation-reflexivity notation-transitivity rule-imp-transitivity or-is-pattern notation-proof and-elim-right-sugar is-predicate-is-pattern proof-rule-mp rule-and-intro-alt2-sugar notation-imp top-intro rule-weakening or-is-sugar and-elim-left-sugar iff-is-sugar eq-is-sugar imp-transitivity is-predicate-is-sugar lemma-curry-left mp lemma-imp-compat-in-floor eq-elim element-var-is-var imp-reflexivity proof-rule-frame is-top-is-sugar lemma-eq-imp is-bot-is-sugar not-elim-alt rule-case-alt ) ARAPACMDOAUJARAPUGHARAPUGARUBAPOAUJARAPUPAUJARUBAPOAUJARAPUGARUBAPOAVAARUBAPOARAPUGARAPUGARUBAPOARAPUGARUBAPOARUBAPOARAPUPARUBAPOARUBAPOARUBAPOUDUCUEUCUCUEUCUEUHANQACMDOOARACMDOOANQNFMAFMQACMDOANSUANFMAFMSUAOANQNFMAFMQOANSNFMAFMSANONAOMNFMAFMOAFMNFMOMOANSNFMAFMSOANONAOMNFMAFMOAFMNFMOANONAOMNFMMAFMOANONAOMNFMAFMOOANONAOMNFMAFMVBANONAOMNFMMAFANONAOMNFMMANONAOMAANONAOMNFMUQANONAOMNAOAANONAOUINNAOAONAVCUNUKUFUFANONAOMNFMMNFMFANONAOMNFMUINFUIUFULUKANONAOMAFMNFMOAFMNFAFMNUNUOAFUIULUOULANSNFMAFMSANONAOMNFMAFMOAFMNFMOMANSANONAOMANONAOMANURANONAOMANONAOMANONAOMUDUCUENFMAFMSNFMAFMOAFMNFMOMNFMAFMOAFMNFMOMNFMAFMURNFMAFMOAFMNFMOMNFMAFMOAFMNFMOMNFMAFMOAFMNFMOMUDUCUEUMUHVDANQNFMAFMQANSUANFMAFMSUAANQANSUAANSUAANUSANSUAANSUAANSUAUDUCUENFMAFMQNFMAFMSUANFMAFMSUANFMAFMUSNFMAFMSUANFMAFMSUANFMAFMSUAUDUCUEUMUHNFMAFMQEDOACMDONFMAFMEDBGLKVEACMEOEDOACMDOOACMEDUTACMCEACUIBCEFNFMGVFIJLFNFFNUNUOFVGULVHUFUKUFUFARACMDOANQACMDOARANQANQAVIANQANQANQUDUCUEACMDOUDUMUHAPATOACMDOATQATOOAPATOOATVJAPATOATQATOAPATQATQAVKATQATQATQUDUCUEATOUDUMUHATOACMTOACMDOACMAOATOACMTOOACMATUTACUQUKACMDVLUFUFVM $. $}
