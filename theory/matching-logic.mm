$( MATCHING LOGIC $)

$c #Pattern $.
$c #ElementVariable $.
$c #SetVariable $.
$c #Variable $.
$c #Symbol $.

$v ph0 ph1 ph2 ph3 ph4 ph5 ph6 ph7 ph8 $.
$v x y z w $.
$v X Y Z W $.
$v xX yY $.
$v sg0 sg1 sg2 sg3 sg4 $.

ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
ph6-is-pattern $f #Pattern ph6 $.
ph7-is-pattern $f #Pattern ph7 $.
ph8-is-pattern $f #Pattern ph8 $.

x-is-element-var $f #ElementVariable x $.
y-is-element-var $f #ElementVariable y $.
z-is-element-var $f #ElementVariable z $.
w-is-element-var $f #ElementVariable w $.

X-is-element-var $f #SetVariable X $.
Y-is-element-var $f #SetVariable Y $.
Z-is-element-var $f #SetVariable Z $.
W-is-element-var $f #SetVariable W $.

xX-is-var $f #Variable xX $.
yY-is-var $f #Variable yY $.

sg0-is-symbol $f #Symbol sg0 $.
sg1-is-symbol $f #Symbol sg1 $.
sg2-is-symbol $f #Symbol sg2 $.
sg3-is-symbol $f #Symbol sg3 $.
sg4-is-symbol $f #Symbol sg4 $.

element-var-is-var $a #Variable x $.
set-var-is-var     $a #Variable X $.
var-is-pattern     $a #Pattern xX $.

$c #Positive $.
$c #Negative $.
$c #Fresh $.
$c #ApplicationContext $.
$c #Substitution $.
$c #Equals $.
$c |- $.

$c \bot    $.
$c \imp    $.
$c \app    $.
$c \exists $.
$c \mu     $.
$c ( )     $.

bot-is-pattern $a #Pattern \bot $.
imp-is-pattern $a #Pattern ( \imp ph0 ph1 ) $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
exists-is-pattern $a #Pattern ( \exists x ph0 ) $.
${ 
    mu-is-pattern.0 $e #Positive X ph0 $.
    mu-is-pattern   $a #Pattern ( \mu X ph0 ) $.
$}

$( #Positive and #Negative $)

positive-in-var $a #Positive xX yY $.
positive-in-symbol $a #Positive xX sg0 $.
positive-in-bot $a #Positive xX \bot $.
${
    positive-in-imp.0 $e #Negative xX ph0 $.
    positive-in-imp.1 $e #Positive xX ph1 $.
    positive-in-imp   $a #Positive xX ( \imp ph0 ph1 ) $.
$}
${
    positive-in-app.0 $e #Positive xX ph0 $.
    positive-in-app.1 $e #Positive xX ph1 $.
    positive-in-app   $a #Positive xX ( \app ph0 ph1 ) $.
$}
${
    positive-in-exists.0 $e #Positive xX ph0 $.
    positive-in-exists   $a #Positive xX ( \exists x ph0 ) $.
$}
${
    positive-in-mu.0 $e #Positive xX ph0 $.
    positive-in-mu   $a #Positive xX ( \mu X ph0 ) $.
$}

${
    $d xX yY $.
    negative-in-var $a #Negative xX yY $.
$}
${
    negative-in-imp.0 $e #Positive xX ph0 $.
    negative-in-imp.1 $e #Negative xX ph1 $.
    negative-in-imp   $a #Negative xX ( \imp ph0 ph1 ) $.
$}
${
    negative-in-app.0 $e #Negative xX ph0 $.
    negative-in-app.1 $e #Negative xX ph1 $.
    negative-in-app   $a #Negative xX ( \app ph0 ph1 ) $.
$}
${
    negative-in-exists.0 $e #Negative xX ph0 $.
    negative-in-exists   $a #Negative xX ( \exists x ph0 ) $.
$}
${
    negative-in-mu.0 $e #Negative xX ph0 $.
    negative-in-mu   $a #Negative xX ( \mu X ph0 ) $.
$}

$( Fresh $)

${
    $d xX yY $.
    fresh-in-var $a #Fresh xX yY $.
$}
fresh-in-symbol $a #Fresh xX sg0 $.
fresh-in-bot    $a #Fresh xX \bot $.
${
    fresh-in-imp.0 $e #Fresh xX ph0 $.
    fresh-in-imp.1 $e #Fresh xX ph1 $.
    fresh-in-imp   $a #Fresh xX ( \imp ph0 ph1 ) $.
$}
${
    fresh-in-app.0 $e #Fresh xX ph0 $.
    fresh-in-app.1 $e #Fresh xX ph1 $.
    fresh-in-app   $a #Fresh xX ( \app ph0 ph1 ) $.
$}
${
    $d xX x $.
    fresh-in-exists $a #Fresh xX ( \exists x ph0 ) $.
$}
fresh-in-exists-shadowed $a #Fresh x ( \exists x ph0 ) $.
${
    $d xX X $.
    fresh-in-mu $a #Fresh xX ( \mu X ph0 ) $.
$}
fresh-in-mu-shadowed $a #Fresh X ( \mu X ph0 ) $.

$( Substitution $)
$( #Substitution ph0 ph1 ph2 Xx means ph0 === ph1[ph2/xX] $)

substitution-var-same $a #Substitution ph0 xX ph0 xX $.
${
    $d xX yY $.
    substitution-var-diff $a #Substitution yY yY ph0 xX $.
$}
substitution-symbol $a #Substitution sg0 sg0 ph0 xX $.
substitution-bot    $a #Substitution \bot \bot ph0 xX $.
${
    substitution-imp.0  $e #Substitution ph1 ph3 ph0 xX $.
    substitution-imp.1  $e #Substitution ph2 ph4 ph0 xX $.
    substitution-imp    $a #Substitution ( \imp ph1 ph2 ) ( \imp ph3 ph4 ) ph0 xX $.
$}
${
    substitution-app.0  $e #Substitution ph1 ph3 ph0 xX $.
    substitution-app.1  $e #Substitution ph2 ph4 ph0 xX $.
    substitution-app    $a #Substitution ( \app ph1 ph2 ) ( \app ph3 ph4 ) ph0 xX $.
$}
substitution-exists-shadowed $a #Substitution ( \exists x ph1 ) ( \exists x ph1 ) ph0 x $.
${
    $d xX x  $.
    $d y ph0 $.
    substitution-exists.0 $e #Substitution ph2 ph1 y x $.
    substitution-exists.1 $e #Substitution ph3 ph2 ph0 xX $.
    substitution-exists   $a #Substitution ( \exists y ph3 ) ( \exists x ph1 ) ph0 xX $.
$}
substitution-mu-shadowed $a #Substitution ( \mu X ph1 ) ( \mu X ph1 ) ph0 X $.
${
    $d xX X  $.
    $d Y ph0 $.
    substitution-mu.0 $e #Substitution ph2 ph1 Y X $.
    substitution-mu.1 $e #Substitution ph3 ph2 ph0 xX $.
    substitution-mu   $a #Substitution ( \mu Y ph3 ) ( \mu X ph1 ) ph0 xX $.
$}

$( Application Contexts $)

application-context-var $a #ApplicationContext xX xX $.
${
    $d xX ph1 $.
    application-context-app-left.0 $e #ApplicationContext xX ph0 $.
    application-context-app-left   $a #ApplicationContext xX ( \app ph0 ph1 ) $.
$}
${
    $d xX ph0 $.
    application-context-app-right.0 $e #ApplicationContext xX ph1 $.
    application-context-app-right   $a #ApplicationContext xX ( \app ph0 ph1 ) $.
$}

$( Matching Logic Proof System $)
$(
   Part 1 (7 rules). FOL Reasoning
   Part 2 (8 rules). Frame Reasoning
   Part 3 (2 rules). Fixpoint Reasoning
   Part 4 (3 rules). Misc
   Total (20 rules).
$)

$c |- $.

$( Proof System Part 1 (7 rules) $)

proof-rule-prop-1 $a |- ( \imp ph0 ( \imp ph1 ph0 ) ) $.
proof-rule-prop-2 $a |- ( \imp ( \imp ph0 ( \imp ph1 ph2 ) ) ( \imp ( \imp ph0 ph1 ) ( \imp ph0 ph2 ) ) ) $.
proof-rule-prop-3 $a |- ( \imp ( \imp ( ph0 \bot ) \bot ) ph0 ) $.
${
    proof-rule-mp.0 $e |- ( \imp ph0 ph1 ) $.
    proof-rule-mp.1 $e |- ph0 $.
    proof-rule-mp   $a |- ph1 $.
$}
${
    proof-rule-exists.0 $e #Substitution ph0 ph1 y x $.
    proof-rule-exists   $a |- ( \imp ph0 ( \exists x ph1 ) ) $.
$}
${
    proof-rule-gen.0 $e |- ( \imp ph0 ph1 ) $.
    proof-rule-gen   $a |- ( \imp ( \exists x ph0 ) ph1 ) $.
$}

$( Proof System Part 1 (8 rules) $)

proof-rule-propagation-bot-left  $a |- ( \imp ( \app \bot ph0 ) \bot ) $.
proof-rule-propagation-bot-right $a |- ( \imp ( \app ph0 \bot ) \bot ) $.
$( proof-rule-propagation-or-left  $)
$( proof-rule-propagation-or-right $)
${
    proof-rule-propagation-exists-left.0 $e #Fresh x ph1 $.
    proof-rule-propagation-exists-left   $a |- ( \imp ( ( \app ( \exists x ph0 ) ph1 ) ) 
                                                      ( \exists x ( \app ph0 ph1 ) ) ) $.
$}
${
    proof-rule-propagation-exists-right.0 $e #Fresh x ph0 $.
    proof-rule-propagation-exists-right   $a |- ( \imp ( ( \app ph0 ( \exists x ph1 ) ) ) 
                                                       ( \exists x ( \app ph0 ph1 ) ) ) $.
$}
${
    proof-rule-frame-left.0 $e |- ( \imp ph0 ph1 ) $.
    proof-rule-frame-left   $a |- ( \imp ( \app ph0 ph2 ) ( \app ph1 ph2 ) ) $.
$}
${
    proof-rule-frame-right.0 $e |- ( \imp ph1 ph2 ) $.
    proof-rule-frame-right   $a |- ( \imp ( \app ph0 ph1 ) ( \app ph0 ph2 ) ) $.
$}


