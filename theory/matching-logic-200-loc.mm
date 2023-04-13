$( MATCHING LOGIC PROOF CHECKER has 200 LOC $)
$c #Pattern #ElementVariable #SetVariable #Variable #Symbol $.
$v ph0 ph1 ph2 ph3 ph4 ph5 x y X Y xX yY sg0 $.
ph0-is-pattern $f #Pattern ph0 $. ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $. ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $. ph5-is-pattern $f #Pattern ph5 $.
x-is-element-var $f #ElementVariable x $. 
y-is-element-var $f #ElementVariable y $.
X-is-element-var $f #SetVariable X $. Y-is-element-var $f #SetVariable Y $.
xX-is-var $f #Variable xX $. yY-is-var $f #Variable yY $. 
sg0-is-symbol $f #Symbol sg0 $.
element-var-is-var $a #Variable x $. set-var-is-var $a #Variable X $.
var-is-pattern     $a #Pattern xX $. symbol-is-pattern  $a #Pattern sg0 $.
$c #Positive #Negative #Fresh #ApplicationContext #Substitution #Notation |- $.
$c \bot \imp \app \exists \mu ( ) $. bot-is-pattern $a #Pattern \bot $. 
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
${ mu-is-pattern.0 $e #Positive X ph0 $. 
   mu-is-pattern   $a #Pattern ( \mu X ph0 ) $. $}
positive-in-var $a #Positive xX yY $. positive-in-symbol $a #Positive xX sg0 $.
positive-in-bot $a #Positive xX \bot $.
${ positive-in-imp.0 $e #Negative xX ph0 $.
   positive-in-imp.1 $e #Positive xX ph1 $.
   positive-in-imp   $a #Positive xX ( \imp ph0 ph1 ) $. $}
${ positive-in-app.0 $e #Positive xX ph0 $.
   positive-in-app.1 $e #Positive xX ph1 $.
   positive-in-app   $a #Positive xX ( \app ph0 ph1 ) $. $}
${ positive-in-exists.0 $e #Positive xX ph0 $.
   positive-in-exists   $a #Positive xX ( \exists x ph0 ) $. $}
${ positive-in-mu.0 $e #Positive xX ph0 $.
   positive-in-mu   $a #Positive xX ( \mu X ph0 ) $. $}
${ $d xX ph0 $. positive-disjoint $a #Positive xX ph0 $. $}
${ $d xX yY $. negative-in-var $a #Negative xX yY $. $}
negative-in-symbol $a #Negative xX sg0 $.
negative-in-bot $a #Negative xX \bot $.
${ negative-in-imp.0 $e #Positive xX ph0 $.
   negative-in-imp.1 $e #Negative xX ph1 $.
   negative-in-imp   $a #Negative xX ( \imp ph0 ph1 ) $. $}
${ negative-in-app.0 $e #Negative xX ph0 $.
   negative-in-app.1 $e #Negative xX ph1 $.
   negative-in-app   $a #Negative xX ( \app ph0 ph1 ) $. $}
${ negative-in-exists.0 $e #Negative xX ph0 $.
   negative-in-exists   $a #Negative xX ( \exists x ph0 ) $. $}
${ negative-in-mu.0 $e #Negative xX ph0 $.
   negative-in-mu   $a #Negative xX ( \mu X ph0 ) $. $}
${ $d xX ph0 $. negative-disjoint $a #Negative xX ph0 $. $}
${ $d xX yY $. fresh-in-var $a #Fresh xX yY $. $}
fresh-in-symbol $a #Fresh xX sg0 $. fresh-in-bot    $a #Fresh xX \bot $.
${ fresh-in-imp.0 $e #Fresh xX ph0 $. fresh-in-imp.1 $e #Fresh xX ph1 $.
   fresh-in-imp   $a #Fresh xX ( \imp ph0 ph1 ) $. $}
${ fresh-in-app.0 $e #Fresh xX ph0 $. fresh-in-app.1 $e #Fresh xX ph1 $.
   fresh-in-app   $a #Fresh xX ( \app ph0 ph1 ) $. $}
${ $d xX x $. fresh-in-exists.0 $e #Fresh xX ph0 $.
   fresh-in-exists $a #Fresh xX ( \exists x ph0 ) $. $}
fresh-in-exists-shadowed $a #Fresh x ( \exists x ph0 ) $.
${ $d xX X $. fresh-in-mu.0 $e #Fresh xX ph0 $.
   fresh-in-mu $a #Fresh xX ( \mu X ph0 ) $. $}
fresh-in-mu-shadowed $a #Fresh X ( \mu X ph0 ) $.
${ $d xX ph0 $. fresh-disjoint $a #Fresh xX ph0 $. $}
${ fresh-in-substitution.0 $e #Fresh xX ph1 $.
   fresh-in-substitution.1 $e #Substitution ph2 ph0 ph1 xX $. 
   fresh-in-substitution $a #Fresh xX ph2 $. $}
${ fresh-after-substitution.0 $e #Fresh xX ph0 $.
   fresh-after-substitution.1 $e #Fresh xX ph1 $.
   fresh-after-substitution.2 $e #Substitution ph2 ph0 ph1 yY $.
   fresh-after-substitution $a #Fresh xX ph2 $. $}
substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${ $d xX yY $. substitution-var-diff $a #Substitution yY yY ph0 xX $. $}
substitution-symbol $a #Substitution sg0 sg0 ph0 xX $.
substitution-bot    $a #Substitution \bot \bot ph0 xX $.
${ substitution-imp.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-imp.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-imp 
   $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $. $}
${ substitution-app.0  $e #Substitution ph1 ph3 ph0 xX $.
   substitution-app.1  $e #Substitution ph2 ph4 ph0 xX $.
   substitution-app    
   $a #Substitution ( \app ph1 ph2 ) ( \app ph3 ph4 ) ph0 xX $. $}
substitution-exists-shadowed 
   $a #Substitution ( \exists x ph1 ) ( \exists x ph1 ) ph0 x $.
${ $d xX x  $. $d y ph0 $.
   substitution-exists.0 $e #Substitution ph2 ph1 y x $.
   substitution-exists.1 $e #Substitution ph3 ph2 ph0 xX $.
   substitution-exists   
   $a #Substitution ( \exists y ph3 ) ( \exists x ph1 ) ph0 xX $. $}
substitution-mu-shadowed $a #Substitution ( \mu X ph1 ) ( \mu X ph1 ) ph0 X $.
${ $d xX X  $. $d Y ph0 $.
   substitution-mu.0 $e #Substitution ph2 ph1 Y X $.
   substitution-mu.1 $e #Substitution ph3 ph2 ph0 xX $.
   substitution-mu   $a #Substitution ( \mu Y ph3 ) ( \mu X ph1 ) ph0 xX $. $}
substitution-identity $a #Substitution ph0 ph0 xX xX $.
${ yY-free-in-ph0 $e #Fresh yY ph0 $. 
   ph1-definition $e #Substitution ph1 ph0 yY xX $.
   ${  substitution-fold.0   $e #Substitution ph2 ph1 ph3 yY $.
       substitution-fold     $a #Substitution ph2 ph0 ph3 xX $. $}
   ${  substitution-unfold.0 $e #Substitution ph2 ph0 ph3 xX $.
       substitution-unfold   $a #Substitution ph2 ph1 ph3 yY $. $} $}
${ substitution-inverse.0 $e #Fresh xX ph0 $.
   substitution-inverse.1 $e #Substitution ph1 ph0 xX yY $.
   substitution-inverse   $a #Substitution ph0 ph1 yY xX $. $}
${ substitution-fresh.0 $e #Fresh xX ph0 $.
   substitution-fresh $a #Substitution ph0 ph0 ph1 xX $. $}
application-context-var $a #ApplicationContext xX xX $.
${ $d xX ph1 $. application-context-app-left.0 $e #ApplicationContext xX ph0 $.
    application-context-app-left   
    $a #ApplicationContext xX ( \app ph0 ph1 ) $. $}
${ $d xX ph0 $. application-context-app-right.0 $e #ApplicationContext xX ph1 $.
    application-context-app-right   
    $a #ApplicationContext xX ( \app ph0 ph1 ) $. $}
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-symmetry.0 $e #Notation ph0 ph1 $.
   notation-symmetry   $a #Notation ph1 ph0 $. $}
${ notation-transitivity.0 $e #Notation ph0 ph1 $.
   notation-transitivity.1 $e #Notation ph1 ph2 $.
   notation-transitivity   $a #Notation ph0 ph2 $. $}
${ notation-positive.0 $e #Positive xX ph0 $.
   notation-positive.1 $e #Notation ph1 ph0 $.
   notation-positive   $a #Positive xX ph1 $. $}
${ notation-negative.0 $e #Negative xX ph0 $.
   notation-negative.1 $e #Notation ph1 ph0 $.
   notation-negative   $a #Negative xX ph1 $. $}
${ notation-fresh.0 $e #Fresh xX ph0 $.
   notation-fresh.1 $e #Notation ph1 ph0 $.
   notation-fresh   $a #Fresh xX ph1 $. $}
${ notation-substitution.0 $e #Substitution ph0 ph1 ph2 xX $.
   notation-substitution.1 $e #Notation ph3 ph0 $.
   notation-substitution.2 $e #Notation ph4 ph1 $.
   notation-substitution.3 $e #Notation ph5 ph2 $.
   notation-substitution   $a #Substitution ph3 ph4 ph5 xX $. $}
${ notation-notation.0 $e #Notation ph0 ph1 $.
   notation-notation.1 $e #Notation ph2 ph0 $.
   notation-notation.2 $e #Notation ph3 ph1 $.
   notation-notation   $p #Notation ph2 ph3 $=
   ( notation-transitivity notation-symmetry ) CADFABDEDBGIHH $. $}
${ notation-application-context.0 $e #ApplicationContext xX ph0 $.
   notation-application-context.1 $e #Notation ph1 ph0 $.
   notation-application-context   $a #ApplicationContext xX ph1 $. $}
${ notation-proof.0 $e |- ph0 $. notation-proof.1 $e #Notation ph1 ph0 $.
   notation-proof   $a |- ph1 $. $}
${ notation-imp.0 $e #Notation ph0 ph2 $. notation-imp.1 $e #Notation ph1 ph3 $.
   notation-imp $a #Notation ( \imp ph0 ph1 ) ( \imp ph2 ph3 ) $. $}
${ notation-app.0 $e #Notation ph0 ph2 $. notation-app.1 $e #Notation ph1 ph3 $.
   notation-app $a #Notation ( \app ph0 ph1 ) ( \app ph2 ph3 ) $. $}
${ notation-exists.0 $e #Notation ph0 ph1 $.
   notation-exists $a #Notation ( \exists x ph0 ) ( \exists x ph1 ) $. $}
${ notation-mu.0 $e #Notation ph0 ph1 $.
   notation-mu $a #Notation ( \mu X ph0 ) ( \mu X ph1 ) $. $}
$c \not $. not-is-pattern $a #Pattern ( \not ph0 ) $.
not-is-sugar $a #Notation ( \not ph0 ) ( \imp ph0 \bot ) $.
$c \or $. or-is-pattern $a #Pattern ( \or ph0 ph1 ) $.
or-is-sugar $a #Notation ( \or ph0 ph1 ) ( \imp ( \not ph0 ) ph1 ) $.
$c \and $. and-is-pattern $a #Pattern ( \and ph0 ph1 ) $.
and-is-sugar 
  $a #Notation ( \and ph0 ph1 ) ( \not ( \or ( \not ph0 ) ( \not ph1 ) ) ) $.
proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
proof-rule-prop-2 $a |- ( \imp ( \imp ph0 ( \imp ph1 ph2 ) ) 
                               ( \imp ( \imp ph0 ph1 ) ( \imp ph0 ph2 ) ) ) $.
proof-rule-prop-3 $a |- ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ph0 ) $.
${ proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-mp.1 $e |- ph0 $.
   proof-rule-mp   $a |- ph1 $. $}
${ proof-rule-exists.0 $e #Substitution ph0 ph1 y x $.
   proof-rule-exists   $a |- ( \imp ph0 ( \exists x ph1 ) ) $. $}
${ proof-rule-gen.0 $e |- ( \imp ph0 ph1 ) $.
   proof-rule-gen.1 $e #Fresh x ph1 $.
   proof-rule-gen   $a |- ( \imp ( \exists x ph0 ) ph1 ) $. $}
${ proof-rule-propagation-bot.0 $e #ApplicationContext xX ph0 $.
   proof-rule-propagation-bot.1 $e #Substitution ph1 ph0 \bot xX $.
   proof-rule-propagation-bot $a |- ( \imp ph1 \bot ) $. $}
${ proof-rule-propagation-or.0 $e #ApplicationContext xX ph0 $.
   proof-rule-propagation-or.1 $e #Substitution ph1 ph0 ( \or ph4 ph5 ) xX $.
   proof-rule-propagation-or.2 $e #Substitution ph2 ph0 ph4 xX $.
   proof-rule-propagation-or.3 $e #Substitution ph3 ph0 ph5 xX $.
   proof-rule-propagation-or $a |- ( \imp ph1 ( \or ph2 ph3 ) ) $. $}
${ proof-rule-propagation-exists.0 $e #ApplicationContext xX ph0 $.
   proof-rule-propagation-exists.1 
     $e #Substitution ph1 ph0 ( \exists y ph3 ) xX $.
   proof-rule-propagation-exists.2 $e #Substitution ph2 ph0 ph3 xX $.
   proof-rule-propagation-exists.3 $e #Fresh y ph0 $.
   proof-rule-propagation-exists $a |- ( \imp ph1 ( \exists y ph2 ) ) $. $}
${ proof-rule-frame.0 $e #ApplicationContext xX ph0 $.
   proof-rule-frame.1 $e #Substitution ph1 ph0 ph3 xX $.
   proof-rule-frame.2 $e #Substitution ph2 ph0 ph4 xX $.
   proof-rule-frame.3 $e |- ( \imp ph3 ph4 ) $.
   proof-rule-frame   $a |- ( \imp ph1 ph2 ) $. $}
${ proof-rule-prefixpoint.0 $e #Substitution ph0 ph1 ( \mu X ph1 ) X $.
   proof-rule-prefixpoint   $a |- ( \imp ph0 ( \mu X ph1 ) ) $. $}
${ proof-rule-kt.0 $e #Substitution ph0 ph1 ph2 X $.
   proof-rule-kt.1 $e |- ( \imp ph0 ph2 ) $.
   proof-rule-kt   $a |- ( \imp ( \mu X ph1 ) ph2 ) $. $}
${ proof-rule-set-var-substitution.0 $e #Substitution ph0 ph1 ph2 X $.
   proof-rule-set-var-substitution.1 $e |- ph1 $.
   proof-rule-set-var-substitution   $a |- ph0 $. $}
proof-rule-existence $a |- ( \exists x x ) $.
${ proof-rule-singleton.0 $e #ApplicationContext xX ph0 $.
   proof-rule-singleton.1 $e #ApplicationContext yY ph1 $.
   proof-rule-singleton.2 $e #Substitution ph3 ph0 ( \and x ph2 ) xX $.
   proof-rule-singleton.3 $e #Substitution ph4 ph1 ( \and x ( \not ph2 ) ) yY $.
   proof-rule-singleton $a |- ( \not ( \and ph3 ph4 ) ) $. $}
