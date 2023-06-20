$c #Substitution #Notation "amount" \kore-sort-SortBExp \top "balanceSender" \iff \ceil \kore-sort-SortAExp \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp \kore-symbol-kseq \or #Variable #ApplicationContext \included \floor \inh \kore-sort-SortBool \kore-sort-SortK \imp \kore-dv \kore-is-sort |- \kore-sort-SortId \kore-valid \bot ) \and \kore-sort-SortKResult #SetVariable #ElementVariable #Symbol \eq \sorted-exists #Pattern \is-predicate \kore-not \kore-sort-SortKItem \kore-in \not \kore-inj \kore-sort-SortInt \in-sort \kore-symbol-dotk ( $.
$v xX0 th0 kore-element-var-VE2 ph6 kore-element-var-x0 ptn3 ptn2 ph3 ptn0 ph1 kore-sort-var-R ph0 ph2 xX x ptn4 ptn1 y x0 ph4 ph5 $.
$d x0 x $.
$d y kore-element-var-VE2 $.
$d y x0 $.
$d kore-sort-var-R x $.
$d y x $.
$d kore-element-var-VE2 x0 $.
$d kore-element-var-x0 x $.
$d kore-element-var-x0 y $.
$d kore-element-var-x0 kore-sort-var-R $.
$d kore-sort-var-R kore-element-var-VE2 $.
$d kore-element-var-x0 kore-element-var-VE2 $.
$d kore-sort-var-R x0 $.
$d y kore-sort-var-R $.
$d kore-element-var-VE2 x $.
$d kore-element-var-x0 x0 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
th0-is-pattern $f #Pattern th0 $.
x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
xX-is-var $f #Variable xX $.
element-var-is-var $a #Variable x $.
bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
application-context-var $a #ApplicationContext xX xX $.
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity $a #Notation ph0 ph2 $. $}
${ notation-proof.0 $e |- ph0 $.
   notation-proof.1 $e #Notation ph1 ph0 $.
   notation-proof $a |- ph1 $. $}
or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
${ proof-rule-propagation-bot.0 $e #ApplicationContext xX ph0 $.
   proof-rule-propagation-bot.1 $e #Substitution ph1 ph0 \bot xX $.
   proof-rule-propagation-bot $a |- ( \imp ph1 \bot ) $. $}
${ proof-rule-frame.0 $e #ApplicationContext xX ph0 $.
   proof-rule-frame.1 $e #Substitution ph1 ph0 ph3 xX $.
   proof-rule-frame.2 $e #Substitution ph2 ph0 ph4 xX $.
   proof-rule-frame.3 $e |- ( \imp ph3 ph4 ) $.
   proof-rule-frame $a |- ( \imp ph1 ph2 ) $. $}
x0-is-element-var $f #ElementVariable x0 $.
top-is-pattern $a #Pattern \top $.
floor-is-pattern $a #Pattern ( \floor ph0 ) $.
included-is-pattern $a #Pattern ( \included ph0 ph1 ) $.
included-is-sugar $a #Notation ( \included ph0 ph1 ) ( \floor ( \imp ph0 ph1 ) ) $.
inh-is-pattern $a #Pattern ( \inh ph0 ) $.
in-sort-is-pattern $a #Pattern ( \in-sort ph0 ph1 ) $.
sorted-exists-is-pattern $a #Pattern ( \sorted-exists x ph0 ph1 ) $.
is-predicate-is-pattern $a #Pattern ( \is-predicate ph0 ) $.
imp-reflexivity $a |- ( \imp ph0 ph0 ) $.
${ rule-imp-transitivity.0 $e |- ( \imp ph0 ph1 ) $.
   rule-imp-transitivity.1 $e |- ( \imp ph1 ph2 ) $.
   rule-imp-transitivity $a |- ( \imp ph0 ph2 ) $. $}
${ rule-iff-elim-left.0 $e |- ( \iff ph0 ph1 ) $.
   rule-iff-elim-left $a |- ( \imp ph0 ph1 ) $. $}
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
${ notation-is-predicate.0 $e #Notation ph0 ph1 $.
   notation-is-predicate $a #Notation ( \is-predicate ph0 ) ( \is-predicate ph1 ) $. $}
${ rule-eq-to-iff.0 $e |- ( \eq ph0 ph1 ) $.
   rule-eq-to-iff $a |- ( \iff ph0 ph1 ) $. $}
${ imp-compat-in-sorted-exists.0 $e |- ( \imp ph0 ph1 ) $.
   imp-compat-in-sorted-exists $a |- ( \imp ( \sorted-exists x ph2 ph0 ) ( \sorted-exists x ph2 ph1 ) ) $. $}
kore-valid-is-pattern $a #Pattern ( \kore-valid ph0 ph1 ) $.
kore-not-is-pattern $a #Pattern ( \kore-not ph0 ph1 ) $.
kore-in-is-pattern $a #Pattern ( \kore-in ph0 ph1 ph2 ph3 ) $.
kore-dv-is-pattern $a #Pattern ( \kore-dv ph0 ph1 ) $.
kore-inj-is-pattern $a #Pattern ( \kore-inj ph0 ph1 ph2 ) $.
kore-inj-id $a |- ( \eq ( \kore-inj ph0 ph1 ph2 ) ph2 ) $.
${ substitution-kore-inj.0 $e #Substitution ph0 ph3 ph6 xX $.
   substitution-kore-inj.1 $e #Substitution ph1 ph4 ph6 xX $.
   substitution-kore-inj.2 $e #Substitution ph2 ph5 ph6 xX $.
   substitution-kore-inj $a #Substitution ( \kore-inj ph0 ph1 ph2 ) ( \kore-inj ph3 ph4 ph5 ) ph6 xX $. $}
lemma-floor-is-predicate $a |- ( \is-predicate ( \floor ph0 ) ) $.
${ disjointness-eq.0 $e |- ( \eq ph0 ph2 ) $.
   disjointness-eq.1 $e |- ( \eq ph1 ph3 ) $.
   disjointness-eq.2 $e |- ( \not ( \and ph2 ph3 ) ) $.
   disjointness-eq $a |- ( \not ( \and ph0 ph1 ) ) $. $}
${ disjointness-simplify.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
   disjointness-simplify.1 $e |- ( \imp ph2 ph1 ) $.
   disjointness-simplify $a |- ( \not ( \and ph0 ph2 ) ) $. $}
${ $d y ph0 $.
   sorted-exists-propagation-converse.0 $e #ApplicationContext x ph0 $.
   sorted-exists-propagation-converse.1 $e #Substitution ph1 ph0 ph5 x $.
   sorted-exists-propagation-converse.2 $e #Substitution ph2 ph0 ( \sorted-exists y ph6 ph5 ) x $.
   sorted-exists-propagation-converse.3 $e #Substitution ph3 ph0 ( \and ( \in-sort y ph6 ) ph5 ) x $.
   sorted-exists-propagation-converse.4 $e #Substitution ph4 ph0 ( \and \top ph5 ) x $.
   sorted-exists-propagation-converse $a |- ( \imp ( \sorted-exists y ph6 ph1 ) ph2 ) $. $}
${ disjointness-case.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
   disjointness-case.1 $e |- ( \not ( \and ph0 ph2 ) ) $.
   disjointness-case $a |- ( \not ( \and ph0 ( \or ph1 ph2 ) ) ) $. $}
${ $d x ph1 $.
   disjointness-sort.0 $e |- ( \not ( \and ph0 ( \inh ph1 ) ) ) $.
   disjointness-sort $a |- ( \not ( \and ph0 ( \sorted-exists x ph1 x ) ) ) $. $}
${ $d x ph1 $.
   disjointness-exists.0 $e |- ( \not ( \and ph1 ( \sorted-exists x ph2 ph3 ) ) ) $.
   disjointness-exists $a |- ( \imp ( \in-sort x ph2 ) ( \not ( \and ph1 ph3 ) ) ) $. $}
${ disjointness-to-not-in.0 $e |- ( \is-predicate th0 ) $.
   disjointness-to-not-in.1 $e |- ( \imp th0 ( \ceil ph1 ) ) $.
   disjointness-to-not-in.2 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
   disjointness-to-not-in.3 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
   disjointness-to-not-in.4 $e |- ( \imp th0 ( \not ( \and ph1 ph2 ) ) ) $.
   disjointness-to-not-in $a |- ( \imp th0 ( \kore-valid ph3 ( \kore-not ph3 ( \kore-in ph0 ph3 ph1 ph2 ) ) ) ) $. $}
${ desugar-not-to-imp.0 $e |- ( \not ph0 ) $.
   desugar-not-to-imp $a |- ( \imp ph0 \bot ) $. $}
${ sugar-imp-to-not.0 $e |- ( \imp ph0 \bot ) $.
   sugar-imp-to-not $a |- ( \not ph0 ) $. $}
BASIC-K-sort-0-is-pattern $a #Pattern \kore-sort-SortK $.
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
BASIC-K-sort-1-is-pattern $a #Pattern \kore-sort-SortKItem $.
ptn1-pattern $f #Pattern ptn1 $.
KSEQ-symbol-0-is-pattern $a #Pattern ( \kore-symbol-kseq ptn0 ptn1 ) $.
ptn2-pattern $f #Pattern ptn2 $.
ptn3-pattern $f #Pattern ptn3 $.
ptn4-pattern $f #Pattern ptn4 $.
${ KSEQ-symbol-0-substitution.0 $e #Substitution ptn1 ptn3 ptn0 xX0 $.
   KSEQ-symbol-0-substitution.1 $e #Substitution ptn2 ptn4 ptn0 xX0 $.
   KSEQ-symbol-0-substitution $a #Substitution ( \kore-symbol-kseq ptn1 ptn2 ) ( \kore-symbol-kseq ptn3 ptn4 ) ptn0 xX0 $. $}
${ $d xX0 ptn1 $.
   KSEQ-symbol-0-application-context-0.0 $e #ApplicationContext xX0 ptn0 $.
   KSEQ-symbol-0-application-context-0 $a #ApplicationContext xX0 ( \kore-symbol-kseq ptn0 ptn1 ) $. $}
KSEQ-symbol-1-is-pattern $a #Pattern \kore-symbol-dotk $.
kore-sort-var-R-elementvariable $f #ElementVariable kore-sort-var-R $.
kore-element-var-VE2-elementvariable $f #ElementVariable kore-element-var-VE2 $.
${ $d xX0 ptn0 $.
   $d xX0 ptn1 $.
   kore-inj-application-context-2.0 $e #ApplicationContext xX0 ptn2 $.
   kore-inj-application-context-2 $a #ApplicationContext xX0 ( \kore-inj ptn0 ptn1 ptn2 ) $. $}
IMP-sort-13-is-pattern $a #Pattern \kore-sort-SortAExp $.
IMP-sort-17-is-pattern $a #Pattern \kore-sort-SortId $.
IMP-sort-22-is-pattern $a #Pattern \kore-sort-SortBExp $.
IMP-sort-23-is-pattern $a #Pattern \kore-sort-SortInt $.
IMP-sort-28-is-pattern $a #Pattern \kore-sort-SortKResult $.
IMP-sort-32-is-pattern $a #Pattern \kore-sort-SortBool $.
IMP-symbol-192-is-pattern $a #Pattern ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) $.
kore-element-var-x0-elementvariable $f #ElementVariable kore-element-var-x0 $.
no-junk-axiom-30 $a |- ( \eq ( \inh \kore-sort-SortKResult ) ( \or ( \sorted-exists kore-element-var-x0 \kore-sort-SortInt kore-element-var-x0 ) ( \sorted-exists kore-element-var-x0 \kore-sort-SortBool kore-element-var-x0 ) ) ) $.
string-literal-10-is-pattern $a #Pattern "balanceSender" $.
string-literal-14-is-pattern $a #Pattern "amount" $.
typecode-cache-Pattern-0 $a #Pattern kore-sort-var-R $.
typecode-cache-Pattern-25 $a #Pattern kore-element-var-x0 $.
typecode-cache-Pattern-177 $a #Pattern kore-element-var-VE2 $.
hooked-sort-no-confusion-IMP-sort-23-IMP-symbol-192 $a |- ( \not ( \and ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) ( \inh \kore-sort-SortInt ) ) ) $.
hooked-sort-no-confusion-IMP-sort-32-IMP-symbol-192 $a |- ( \not ( \and ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ptn0 ptn1 ) ( \inh \kore-sort-SortBool ) ) ) $.
typecode-cache-Pattern-283 $a #Pattern x0 $.
substitution-853 $a #Substitution ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem x0 ) kore-element-var-VE2 x0 $.
substitution-854 $a #Substitution \kore-sort-SortKItem \kore-sort-SortKItem ( \sorted-exists kore-element-var-VE2 \kore-sort-SortKResult kore-element-var-VE2 ) x0 $.
substitution-857 $a #Substitution ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem ( \and \top kore-element-var-VE2 ) ) ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem x0 ) ( \and \top kore-element-var-VE2 ) x0 $.
KSEQ-symbol-0-no-confusion $a |- ( \imp ( \and ( \kore-symbol-kseq ptn0 ptn1 ) ( \kore-symbol-kseq ptn2 ptn3 ) ) ( \kore-symbol-kseq ( \and ptn0 ptn2 ) ( \and ptn1 ptn3 ) ) ) $.
substitution-858 $a #Substitution \kore-symbol-dotk \kore-symbol-dotk ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) x0 $.
substitution-859 $a #Substitution \kore-symbol-dotk \kore-symbol-dotk ( \and \top ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) ) x0 $.
notation-cache-770 $a #Notation ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \included kore-element-var-VE2 ( \inh \kore-sort-SortKResult ) ) $.
sorting-rearrange-753 $a |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \ceil ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ) \kore-symbol-dotk ) ) ) $.
sorting-cache-1208 $a |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
sorting-cache-1212 $a |- ( \imp ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ( \in-sort ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) \kore-sort-SortK ) ) $.
typecode-cache-Pattern-284 $a #Pattern ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) \top ) ) $.
sorting-cache-1213 $a |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) \top ) ) ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) ) $.
${ sorting-rearrange-754 $p |- ( \imp ( \and ( \kore-is-sort kore-sort-var-R ) ( \and ( \in-sort kore-element-var-VE2 \kore-sort-SortKResult ) \top ) ) ( \kore-valid kore-sort-var-R ( \kore-not kore-sort-var-R ( \kore-in \kore-sort-SortK kore-sort-var-R ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortBExp \kore-sort-SortKItem ( \kore-symbol-Lbl'Unds-GT-UndsUnds'IMP-SYNTAX'Unds'BExp'Unds'AExp'Unds'AExp ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "amount" ) ) ( \kore-inj \kore-sort-SortId \kore-sort-SortAExp ( \kore-dv \kore-sort-SortId "balanceSender" ) ) ) ) \kore-symbol-dotk ) ( \kore-symbol-kseq ( \kore-inj \kore-sort-SortKResult \kore-sort-SortKItem kore-element-var-VE2 ) \kore-symbol-dotk ) ) ) ) ) $= ( IMP-sort-28-is-pattern kore-inj-is-pattern IMP-sort-17-is-pattern typecode-cache-Pattern-177 BASIC-K-sort-1-is-pattern KSEQ-symbol-1-is-pattern x0-is-element-var IMP-sort-13-is-pattern kore-dv-is-pattern and-is-pattern sorted-exists-is-pattern element-var-is-var KSEQ-symbol-0-is-pattern string-literal-14-is-pattern string-literal-10-is-pattern IMP-symbol-192-is-pattern IMP-sort-22-is-pattern kore-element-var-x0-elementvariable typecode-cache-Pattern-283 in-sort-is-pattern inh-is-pattern bot-is-pattern substitution-var-same substitution-disjoint typecode-cache-Pattern-25 KSEQ-symbol-0-substitution imp-is-pattern included-is-pattern floor-is-pattern IMP-sort-23-is-pattern IMP-sort-32-is-pattern top-is-pattern rule-imp-transitivity typecode-cache-Pattern-0 is-predicate-is-pattern application-context-var KSEQ-symbol-0-application-context-0 or-is-pattern disjointness-sort disjointness-simplify BASIC-K-sort-0-is-pattern notation-is-predicate notation-proof kore-inj-id imp-reflexivity imp-compat-in-sorted-exists substitution-kore-inj sorted-exists-propagation-converse typecode-cache-Pattern-284 kore-in-is-pattern kore-not-is-pattern kore-valid-is-pattern sorting-cache-1213 lemma-floor-is-predicate included-is-sugar notation-reflexivity notation-transitivity notation-cache-770 sorting-rearrange-753 sorting-cache-1208 sorting-cache-1212 KSEQ-symbol-0-no-confusion hooked-sort-no-confusion-IMP-sort-23-IMP-symbol-192 hooked-sort-no-confusion-IMP-sort-32-IMP-symbol-192 disjointness-case no-junk-axiom-30 rule-eq-to-iff rule-iff-elim-left disjointness-eq kore-inj-application-context-2 substitution-853 substitution-854 substitution-857 desugar-not-to-imp proof-rule-frame proof-rule-propagation-bot sugar-imp-to-not substitution-858 substitution-859 disjointness-exists disjointness-to-not-in ) ABVKBFCUBAUPAUPVCAUPSGEJEPKDEJEQKDRDHOCGBFDHOVLVMVNABVOVCSGEJEPKDEJEQKDRDHOCGBFDHOAUPBFCUBBFCUCUJUQBFCUBUQBFCUCUIUKUQBFCUCUJUQBFCUCUIVPBFCUCUJBFCUCUIUKBFCUCUJBFCUCUIUKBFCUCUIUKBFCUCVQBFCUCUIUKVRVSVDVEBFCUBBFCUCUJBVTVDVEBWABWBBWCSGEJEPKDEJEQKDRDHOCCGBFDHOBSGEJEPKDEJEQKDRDHOCCGBFDBMHOCCGBFDHOBMSGEJEPKDEJEQKDRDHOCCGBFDBMHOLSGEJEPKDEJEQKDRDHOCCGBFDBMHOLSGEJEPKDEJEQKDRDCCGBFDBMLHHLOUDSGEJEPKDEJEQKDRDHCCGBFDBMHWDSGEJEPKDEJEQKDRDCCGBFDBMLHHLOUDHHLOUDIUAHHLOSGEJEPKDEJEQKDRDCCGBFDBMLHHLOUDHHLOSGEJEPKDEJEQKDRDCCGBFDBMLUDININIUAHHLINURUSINSGEJEPKDEJEQKDRDCCGBFDBMLSGEJEPKDEJEQKDRDCCGBFDBMLHHLIUAHHLSGEJEPKDEJEQKDRDCCGBFDBMLINUEHHLSGEJEPKDEJEQKDRDCCGBFDBMLINUFUHINUDUDHHLIUAHHLUDINUEHHLUDINUFUHSGEJEPKDEJEQKDRDCCGBFDBMLSGEJEPKDEJEQKDRDCGCBFBMDCCGBFDBMSGEJEPKDEJEQKDRDCGCBFBMDEJEPKDEJEQKDRCBFBMSGEJEPKDEJEQKDRVFCGCBFBMVFEJEPKDEJEQKDRCBEJEPKDEJEQKDRULTUGTMUMTUGTMUTCUCEJEPKDEJEQKDRULTUGTMUMTUGTMEJEPKDEJEQKDRULTEJEPKDEJEQKDWEVAEJEPKDEJEQKDRUMTEJEPKDEJEQKDWFVAWGCUCULTUGTMUMTUGTMUTCUCULTUGTMUMTUGTMUTTWHWIWJVBVAWKCCGBFDBMCCGBFDBMCGCBFBMDCGBFDCGBFDCBCGBFDVGVHCGIUADCGBFDCGCBFBMDCGBFCUBBFLDCGUNBFLDBFCIBINCGIUAINURWLIBWMCGCBFBMCGIUACBFBMINCCBFBMINUFIBWNCBFBMINUEVICGBFCUBBFLCGIUABFCUBBFLINCBFCUBBFLINUFGBFCUBBFLINUFBFCUBBFLINUEVIIBWOVJUOVBWPWQIUAHHLOUDHHLOININIUAHHLINURUSINUDUDHHLIUAHHLUDINUEHHLUDINUFUHWRUOUOWSCCGBFDHOBMCCGBFDHOBMCCGBFDBMHOCGBFDHOCGBFDHOCBCGBFDHOVGVHIUAHOCGBFDHOCCGBFDBMHOBFCUBCGBFDLHOUNCGBFDLHOCGBFDCIBINIUAHINURUSINCGBFDCGBFDHIUAHCGBFDINUEIBWTUHINCCGBFDBMCCGBFDBMHIUAHCCGBFDBMINUEHCCGBFDBMINUFUHINBFCUBCGBFDLBFCUBCGBFDLHIUAHBFCUBCGBFDLINUEHBFCUBCGBFDLINUFUHINUNCGBFDLUNCGBFDLHIUAHUNCGBFDLINUEIBXAUHVJUOVBXBXCUO $. $}
