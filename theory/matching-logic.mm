$(
    Functional matching logic
$)

$c #Pattern $.
$c #ElementVariable $.
$c #SetVariable $.
$c #Variable $.
$c ( ) $.

$v ph0 ph1 ph2 ph3 ph4 ph5 ph6 ph7 ph8 $.
$v x y z w $.
$v X Y Z W $.
$v xX yY $.

ph0-pattern $f #Pattern ph0 $.
ph1-pattern $f #Pattern ph1 $.
ph2-pattern $f #Pattern ph2 $.
ph3-pattern $f #Pattern ph3 $.
ph4-pattern $f #Pattern ph4 $.
ph5-pattern $f #Pattern ph5 $.
ph6-pattern $f #Pattern ph6 $.
ph7-pattern $f #Pattern ph7 $.
ph8-pattern $f #Pattern ph8 $.

x-element-var $f #ElementVariable x $.
y-element-var $f #ElementVariable y $.
z-element-var $f #ElementVariable z $.
w-element-var $f #ElementVariable w $.

X-element-var $f #SetVariable X $.
Y-element-var $f #SetVariable Y $.
Z-element-var $f #SetVariable Z $.
W-element-var $f #SetVariable W $.

xX-var $f #Variable xX $.
yY-var $f #Variable yY $.

element-var-is-var $a #Variable x $.
set-var-is-var $a #Variable X $.
var-is-pattern $a #Pattern xX $.

$( Substitution $)
$c #Substitution $.

substitution-var $a #Substitution ph0 xX ph0 xX $.
${
    $d xX yY $.
    substitution-distinct-var $a #Substitution yY yY ph0 xX $.
$}

$( Provability $)
$c |- $.
