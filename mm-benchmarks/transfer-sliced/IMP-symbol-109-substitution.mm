$c #Substitution #Notation #SetVariable #ElementVariable #Symbol #Variable #Pattern \app ( \kore-symbol-Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int-symbol ) \kore-symbol-Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int $.
$v ph0 xX xX0 ph2 sg0 ptn1 ptn2 ph3 ptn0 ph4 ph5 ph1 $.
ph0-is-pattern $f #Pattern ph0 $.
ph1-is-pattern $f #Pattern ph1 $.
ph2-is-pattern $f #Pattern ph2 $.
ph3-is-pattern $f #Pattern ph3 $.
ph4-is-pattern $f #Pattern ph4 $.
ph5-is-pattern $f #Pattern ph5 $.
xX-is-var $f #Variable xX $.
sg0-is-symbol $f #Symbol sg0 $.
symbol-is-pattern $a #Pattern sg0 $.
app-is-pattern $a #Pattern ( \app ph0 ph1 ) $.
${ substitution-app.0 $e #Substitution ph1 ph3 ph0 xX $.
   substitution-app.1 $e #Substitution ph2 ph4 ph0 xX $.
   substitution-app $a #Substitution ( \app ph1 ph2 ) ( \app ph3 ph4 ) ph0 xX $. $}
notation-reflexivity $a #Notation ph0 ph0 $.
${ notation-substitution.0 $e #Substitution ph0 ph1 ph2 xX $.
   notation-substitution.1 $e #Notation ph3 ph0 $.
   notation-substitution.2 $e #Notation ph4 ph1 $.
   notation-substitution.3 $e #Notation ph5 ph2 $.
   notation-substitution $a #Substitution ph3 ph4 ph5 xX $. $}
${ $d xX ph0 $.
   substitution-disjoint $a #Substitution ph0 ph0 ph1 xX $. $}
xX0-variable $f #Variable xX0 $.
ptn0-pattern $f #Pattern ptn0 $.
ptn1-pattern $f #Pattern ptn1 $.
ptn2-pattern $f #Pattern ptn2 $.
IMP-symbol-109-is-symbol $a #Symbol \kore-symbol-Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int-symbol $.
IMP-symbol-109-is-pattern $a #Pattern ( \kore-symbol-Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int ptn0 ) $.
notation-cache-122 $a #Notation ( \kore-symbol-Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int ptn1 ) ( \app \kore-symbol-Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int-symbol ptn1 ) $.
notation-cache-123 $a #Notation ( \kore-symbol-Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int ptn2 ) ( \app \kore-symbol-Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int-symbol ptn2 ) $.
${ IMP-symbol-109-substitution.0 $e #Substitution ptn1 ptn2 ptn0 xX0 $.
   IMP-symbol-109-substitution $p #Substitution ( \kore-symbol-Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int ptn1 ) ( \kore-symbol-Lbl'Hash'shutdownWrite'LParUndsRParUnds'K-IO'Unds'K'Unds'Int ptn2 ) ptn0 xX0 $= ( IMP-symbol-109-is-symbol symbol-is-pattern app-is-pattern IMP-symbol-109-is-pattern substitution-disjoint substitution-app notation-cache-122 notation-cache-123 notation-reflexivity notation-substitution ) FGCHFGDHBCIDIBABFGCFGDAFGBAJEKCLDMBNO $. $}
