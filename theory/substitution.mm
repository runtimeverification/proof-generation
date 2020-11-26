$( Substitution lemmas for constructs $)

$[ theory/matching-logic-prelude.mm $]

${
    substitution-not.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-not $p #Substitution ( \not ph1 ) ( \not ph2 ) ph0 xX $= ph1-is-pattern bot-is-pattern imp-is-pattern ph2-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern bot-is-pattern ph2-is-pattern bot-is-pattern xX-is-var substitution-not.0 ph0-is-pattern xX-is-var substitution-bot substitution-imp ph1-is-pattern not-is-sugar ph2-is-pattern not-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-or.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-or.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-or $p #Substitution ( \or ph1 ph2 ) ( \or ph3 ph4 ) ph0 xX $= ph1-is-pattern not-is-pattern ph2-is-pattern imp-is-pattern ph3-is-pattern not-is-pattern ph4-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern or-is-pattern ph3-is-pattern ph4-is-pattern or-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern ph3-is-pattern not-is-pattern ph4-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph3-is-pattern xX-is-var substitution-or.0 substitution-not substitution-or.1 substitution-imp ph1-is-pattern ph2-is-pattern or-is-sugar ph3-is-pattern ph4-is-pattern or-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-and.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-and.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-and $p #Substitution ( \and ph1 ph2 ) ( \and ph3 ph4 ) ph0 xX $= ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern or-is-pattern not-is-pattern ph3-is-pattern not-is-pattern ph4-is-pattern not-is-pattern or-is-pattern not-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern and-is-pattern ph3-is-pattern ph4-is-pattern and-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern or-is-pattern ph3-is-pattern not-is-pattern ph4-is-pattern not-is-pattern or-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern ph4-is-pattern not-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph3-is-pattern xX-is-var substitution-and.0 substitution-not ph0-is-pattern ph2-is-pattern ph4-is-pattern xX-is-var substitution-and.1 substitution-not substitution-or substitution-not ph1-is-pattern ph2-is-pattern and-is-sugar ph3-is-pattern ph4-is-pattern and-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-iff.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-iff.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-iff $p #Substitution ( \iff ph1 ph2 ) ( \iff ph3 ph4 ) ph0 xX $= ph1-is-pattern ph2-is-pattern imp-is-pattern ph2-is-pattern ph1-is-pattern imp-is-pattern and-is-pattern ph3-is-pattern ph4-is-pattern imp-is-pattern ph4-is-pattern ph3-is-pattern imp-is-pattern and-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern ph3-is-pattern ph4-is-pattern iff-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern imp-is-pattern ph2-is-pattern ph1-is-pattern imp-is-pattern ph3-is-pattern ph4-is-pattern imp-is-pattern ph4-is-pattern ph3-is-pattern imp-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern ph4-is-pattern xX-is-var substitution-iff.0 substitution-iff.1 substitution-imp ph0-is-pattern ph2-is-pattern ph1-is-pattern ph4-is-pattern ph3-is-pattern xX-is-var substitution-iff.1 substitution-iff.0 substitution-imp substitution-and ph1-is-pattern ph2-is-pattern iff-is-sugar ph3-is-pattern ph4-is-pattern iff-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-ceil.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-ceil $p #Substitution ( \ceil ph1 ) ( \ceil ph2 ) ph0 xX $= definedness-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern definedness-is-symbol symbol-is-pattern ph2-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern ceil-is-pattern ph2-is-pattern ceil-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern definedness-is-symbol symbol-is-pattern ph1-is-pattern definedness-is-symbol symbol-is-pattern ph2-is-pattern xX-is-var ph0-is-pattern xX-is-var definedness-is-symbol substitution-symbol substitution-ceil.0 substitution-app ph1-is-pattern ceil-is-sugar ph2-is-pattern ceil-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-floor.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-floor $p #Substitution ( \floor ph1 ) ( \floor ph2 ) ph0 xX $= ph1-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph2-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph0-is-pattern ph1-is-pattern floor-is-pattern ph2-is-pattern floor-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern not-is-pattern ceil-is-pattern ph2-is-pattern not-is-pattern ceil-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern xX-is-var substitution-floor.0 substitution-not substitution-ceil substitution-not ph1-is-pattern floor-is-sugar ph2-is-pattern floor-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-included.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-included.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-included $p #Substitution ( \included ph1 ph2 ) ( \included ph3 ph4 ) ph0 xX $= ph1-is-pattern ph2-is-pattern imp-is-pattern floor-is-pattern ph3-is-pattern ph4-is-pattern imp-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern included-is-pattern ph3-is-pattern ph4-is-pattern included-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern imp-is-pattern ph3-is-pattern ph4-is-pattern imp-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern ph4-is-pattern xX-is-var substitution-included.0 substitution-included.1 substitution-imp substitution-floor ph1-is-pattern ph2-is-pattern included-is-sugar ph3-is-pattern ph4-is-pattern included-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-eq.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-eq.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-eq $p #Substitution ( \eq ph1 ph2 ) ( \eq ph3 ph4 ) ph0 xX $= ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph3-is-pattern ph4-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern eq-is-pattern ph3-is-pattern ph4-is-pattern eq-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern ph3-is-pattern ph4-is-pattern iff-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern ph4-is-pattern xX-is-var substitution-eq.0 substitution-eq.1 substitution-iff substitution-floor ph1-is-pattern ph2-is-pattern eq-is-sugar ph3-is-pattern ph4-is-pattern eq-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-inh.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-inh $p #Substitution ( \inh ph1 ) ( \inh ph2 ) ph0 xX $= inhabitant-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern inhabitant-is-symbol symbol-is-pattern ph2-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern inh-is-pattern ph2-is-pattern inh-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern inhabitant-is-symbol symbol-is-pattern ph1-is-pattern inhabitant-is-symbol symbol-is-pattern ph2-is-pattern xX-is-var ph0-is-pattern xX-is-var inhabitant-is-symbol substitution-symbol substitution-inh.0 substitution-app ph1-is-pattern inh-is-sugar ph2-is-pattern inh-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-in-sort.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-in-sort.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-in-sort $p #Substitution ( \in-sort ph1 ph2 ) ( \in-sort ph3 ph4 ) ph0 xX $= ph1-is-pattern ph2-is-pattern inh-is-pattern included-is-pattern ph3-is-pattern ph4-is-pattern inh-is-pattern included-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern ph4-is-pattern in-sort-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern inh-is-pattern ph3-is-pattern ph4-is-pattern inh-is-pattern xX-is-var substitution-in-sort.0 ph0-is-pattern ph2-is-pattern ph4-is-pattern xX-is-var substitution-in-sort.1 substitution-inh substitution-included ph1-is-pattern ph2-is-pattern in-sort-is-sugar ph3-is-pattern ph4-is-pattern in-sort-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-pair-sort.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-pair-sort.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-pair-sort $p #Substitution ( \pair-sort ph1 ph2 ) ( \pair-sort ph3 ph4 ) ph0 xX $= pair-sort-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph2-is-pattern app-is-pattern pair-sort-symbol-is-symbol symbol-is-pattern ph3-is-pattern app-is-pattern ph4-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern pair-sort-is-pattern ph3-is-pattern ph4-is-pattern pair-sort-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern pair-sort-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph2-is-pattern pair-sort-symbol-is-symbol symbol-is-pattern ph3-is-pattern app-is-pattern ph4-is-pattern xX-is-var ph0-is-pattern pair-sort-symbol-is-symbol symbol-is-pattern ph1-is-pattern pair-sort-symbol-is-symbol symbol-is-pattern ph3-is-pattern xX-is-var ph0-is-pattern xX-is-var pair-sort-symbol-is-symbol substitution-symbol substitution-pair-sort.0 substitution-app substitution-pair-sort.1 substitution-app ph1-is-pattern ph2-is-pattern pair-sort-is-sugar ph3-is-pattern ph4-is-pattern pair-sort-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-pair.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-pair.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-pair $p #Substitution ( \pair ph1 ph2 ) ( \pair ph3 ph4 ) ph0 xX $= pair-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph2-is-pattern app-is-pattern pair-symbol-is-symbol symbol-is-pattern ph3-is-pattern app-is-pattern ph4-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern pair-is-pattern ph3-is-pattern ph4-is-pattern pair-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern pair-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph2-is-pattern pair-symbol-is-symbol symbol-is-pattern ph3-is-pattern app-is-pattern ph4-is-pattern xX-is-var ph0-is-pattern pair-symbol-is-symbol symbol-is-pattern ph1-is-pattern pair-symbol-is-symbol symbol-is-pattern ph3-is-pattern xX-is-var ph0-is-pattern xX-is-var pair-symbol-is-symbol substitution-symbol substitution-pair.0 substitution-app substitution-pair.1 substitution-app ph1-is-pattern ph2-is-pattern pair-is-sugar ph3-is-pattern ph4-is-pattern pair-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-pair-fst.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-pair-fst $p #Substitution ( \pair-fst ph1 ) ( \pair-fst ph2 ) ph0 xX $= pair-fst-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern pair-fst-symbol-is-symbol symbol-is-pattern ph2-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern pair-fst-is-pattern ph2-is-pattern pair-fst-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern pair-fst-symbol-is-symbol symbol-is-pattern ph1-is-pattern pair-fst-symbol-is-symbol symbol-is-pattern ph2-is-pattern xX-is-var ph0-is-pattern xX-is-var pair-fst-symbol-is-symbol substitution-symbol substitution-pair-fst.0 substitution-app ph1-is-pattern pair-fst-is-sugar ph2-is-pattern pair-fst-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}

${
    substitution-pair-snd.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-pair-snd $p #Substitution ( \pair-snd ph1 ) ( \pair-snd ph2 ) ph0 xX $= pair-snd-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern pair-snd-symbol-is-symbol symbol-is-pattern ph2-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern pair-snd-is-pattern ph2-is-pattern pair-snd-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern pair-snd-symbol-is-symbol symbol-is-pattern ph1-is-pattern pair-snd-symbol-is-symbol symbol-is-pattern ph2-is-pattern xX-is-var ph0-is-pattern xX-is-var pair-snd-symbol-is-symbol substitution-symbol substitution-pair-snd.0 substitution-app ph1-is-pattern pair-snd-is-sugar ph2-is-pattern pair-snd-is-sugar ph0-is-pattern equal-reflexivity equal-substitution $.
$}
