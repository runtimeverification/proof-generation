$[ theory/matching-logic-prelude.mm $]

$( Substitution lemmas $)

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

$( Congruence lemmas $)

${
    equal-not.0 $e #Equal ph0 ph1 $.
    equal-not $p #Equal ( \not ph0 ) ( \not ph1 ) $= ph0-is-pattern not-is-pattern ph1-is-pattern bot-is-pattern imp-is-pattern ph1-is-pattern not-is-pattern ph0-is-pattern not-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern ph1-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern not-is-sugar ph0-is-pattern bot-is-pattern ph1-is-pattern bot-is-pattern equal-not.0 bot-is-pattern equal-reflexivity equal-imp equal-transitivity ph1-is-pattern not-is-pattern ph1-is-pattern bot-is-pattern imp-is-pattern ph1-is-pattern not-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-or.0 $e #Equal ph0 ph2 $.
    equal-or.1 $e #Equal ph1 ph3 $.
    equal-or $p #Equal ( \or ph0 ph1 ) ( \or ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern or-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern imp-is-pattern ph2-is-pattern ph3-is-pattern or-is-pattern ph0-is-pattern ph1-is-pattern or-is-pattern ph0-is-pattern not-is-pattern ph1-is-pattern imp-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern or-is-sugar ph0-is-pattern not-is-pattern ph1-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern ph0-is-pattern ph2-is-pattern equal-or.0 equal-not equal-or.1 equal-imp equal-transitivity ph2-is-pattern ph3-is-pattern or-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern imp-is-pattern ph2-is-pattern ph3-is-pattern or-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-and.0 $e #Equal ph0 ph2 $.
    equal-and.1 $e #Equal ph1 ph3 $.
    equal-and $p #Equal ( \and ph0 ph1 ) ( \and ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern and-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern or-is-pattern not-is-pattern ph2-is-pattern ph3-is-pattern and-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern ph0-is-pattern not-is-pattern ph1-is-pattern not-is-pattern or-is-pattern not-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern or-is-pattern not-is-pattern ph0-is-pattern ph1-is-pattern and-is-sugar ph0-is-pattern not-is-pattern ph1-is-pattern not-is-pattern or-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern or-is-pattern ph0-is-pattern not-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern ph0-is-pattern ph2-is-pattern equal-and.0 equal-not ph1-is-pattern ph3-is-pattern equal-and.1 equal-not equal-or equal-not equal-transitivity ph2-is-pattern ph3-is-pattern and-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern or-is-pattern not-is-pattern ph2-is-pattern ph3-is-pattern and-is-sugar equal-symmetry equal-transitivity $.
$}

equal-top $p #Equal \top \top $= top-is-pattern bot-is-pattern not-is-pattern top-is-pattern top-is-pattern bot-is-pattern not-is-pattern bot-is-pattern not-is-pattern top-is-sugar bot-is-pattern not-is-pattern equal-reflexivity equal-transitivity top-is-pattern bot-is-pattern not-is-pattern top-is-sugar equal-symmetry equal-transitivity $.

${
    equal-iff.0 $e #Equal ph0 ph2 $.
    equal-iff.1 $e #Equal ph1 ph3 $.
    equal-iff $p #Equal ( \iff ph0 ph1 ) ( \iff ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern iff-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern ph3-is-pattern ph2-is-pattern imp-is-pattern and-is-pattern ph2-is-pattern ph3-is-pattern iff-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern ph0-is-pattern ph1-is-pattern imp-is-pattern ph1-is-pattern ph0-is-pattern imp-is-pattern and-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern ph3-is-pattern ph2-is-pattern imp-is-pattern and-is-pattern ph0-is-pattern ph1-is-pattern iff-is-sugar ph0-is-pattern ph1-is-pattern imp-is-pattern ph1-is-pattern ph0-is-pattern imp-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern ph3-is-pattern ph2-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern equal-iff.0 equal-iff.1 equal-imp ph1-is-pattern ph0-is-pattern ph3-is-pattern ph2-is-pattern equal-iff.1 equal-iff.0 equal-imp equal-and equal-transitivity ph2-is-pattern ph3-is-pattern iff-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern ph3-is-pattern ph2-is-pattern imp-is-pattern and-is-pattern ph2-is-pattern ph3-is-pattern iff-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-forall.0 $e #Equal ph0 ph1 $.
    equal-forall $p #Equal ( \forall x ph0 ) ( \forall x ph1 ) $= ph0-is-pattern x-is-element-var forall-is-pattern ph1-is-pattern not-is-pattern x-is-element-var exists-is-pattern not-is-pattern ph1-is-pattern x-is-element-var forall-is-pattern ph0-is-pattern x-is-element-var forall-is-pattern ph0-is-pattern not-is-pattern x-is-element-var exists-is-pattern not-is-pattern ph1-is-pattern not-is-pattern x-is-element-var exists-is-pattern not-is-pattern ph0-is-pattern x-is-element-var forall-is-sugar ph0-is-pattern not-is-pattern x-is-element-var exists-is-pattern ph1-is-pattern not-is-pattern x-is-element-var exists-is-pattern ph0-is-pattern not-is-pattern ph1-is-pattern not-is-pattern x-is-element-var ph0-is-pattern ph1-is-pattern equal-forall.0 equal-not equal-exists equal-not equal-transitivity ph1-is-pattern x-is-element-var forall-is-pattern ph1-is-pattern not-is-pattern x-is-element-var exists-is-pattern not-is-pattern ph1-is-pattern x-is-element-var forall-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-ceil.0 $e #Equal ph0 ph1 $.
    equal-ceil $p #Equal ( \ceil ph0 ) ( \ceil ph1 ) $= ph0-is-pattern ceil-is-pattern definedness-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph1-is-pattern ceil-is-pattern ph0-is-pattern ceil-is-pattern definedness-is-symbol symbol-is-pattern ph0-is-pattern app-is-pattern definedness-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph0-is-pattern ceil-is-sugar definedness-is-symbol symbol-is-pattern ph0-is-pattern definedness-is-symbol symbol-is-pattern ph1-is-pattern definedness-is-symbol symbol-is-pattern equal-reflexivity equal-ceil.0 equal-app equal-transitivity ph1-is-pattern ceil-is-pattern definedness-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph1-is-pattern ceil-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-floor.0 $e #Equal ph0 ph1 $.
    equal-floor $p #Equal ( \floor ph0 ) ( \floor ph1 ) $= ph0-is-pattern floor-is-pattern ph1-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph1-is-pattern floor-is-pattern ph0-is-pattern floor-is-pattern ph0-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph1-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph0-is-pattern floor-is-sugar ph0-is-pattern not-is-pattern ceil-is-pattern ph1-is-pattern not-is-pattern ceil-is-pattern ph0-is-pattern not-is-pattern ph1-is-pattern not-is-pattern ph0-is-pattern ph1-is-pattern equal-floor.0 equal-not equal-ceil equal-not equal-transitivity ph1-is-pattern floor-is-pattern ph1-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph1-is-pattern floor-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-in.0 $e #Equal ph0 ph1 $.
    equal-in $p #Equal ( \in x ph0 ) ( \in x ph1 ) $= ph0-is-pattern x-is-element-var in-is-pattern x-is-element-var element-var-is-var var-is-pattern ph1-is-pattern and-is-pattern ceil-is-pattern ph1-is-pattern x-is-element-var in-is-pattern ph0-is-pattern x-is-element-var in-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern and-is-pattern ceil-is-pattern x-is-element-var element-var-is-var var-is-pattern ph1-is-pattern and-is-pattern ceil-is-pattern ph0-is-pattern x-is-element-var in-is-sugar x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph1-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph1-is-pattern x-is-element-var element-var-is-var var-is-pattern equal-reflexivity equal-in.0 equal-and equal-ceil equal-transitivity ph1-is-pattern x-is-element-var in-is-pattern x-is-element-var element-var-is-var var-is-pattern ph1-is-pattern and-is-pattern ceil-is-pattern ph1-is-pattern x-is-element-var in-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-included.0 $e #Equal ph0 ph2 $.
    equal-included.1 $e #Equal ph1 ph3 $.
    equal-included $p #Equal ( \included ph0 ph1 ) ( \included ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern included-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern included-is-pattern ph0-is-pattern ph1-is-pattern included-is-pattern ph0-is-pattern ph1-is-pattern imp-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern included-is-sugar ph0-is-pattern ph1-is-pattern imp-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern equal-included.0 equal-included.1 equal-imp equal-floor equal-transitivity ph2-is-pattern ph3-is-pattern included-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern included-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-eq.0 $e #Equal ph0 ph2 $.
    equal-eq.1 $e #Equal ph1 ph3 $.
    equal-eq $p #Equal ( \eq ph0 ph1 ) ( \eq ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern eq-is-pattern ph2-is-pattern ph3-is-pattern iff-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern eq-is-pattern ph0-is-pattern ph1-is-pattern eq-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern eq-is-sugar ph0-is-pattern ph1-is-pattern iff-is-pattern ph2-is-pattern ph3-is-pattern iff-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern equal-eq.0 equal-eq.1 equal-iff equal-floor equal-transitivity ph2-is-pattern ph3-is-pattern eq-is-pattern ph2-is-pattern ph3-is-pattern iff-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern eq-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-inh.0 $e #Equal ph0 ph1 $.
    equal-inh $p #Equal ( \inh ph0 ) ( \inh ph1 ) $= ph0-is-pattern inh-is-pattern inhabitant-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph1-is-pattern inh-is-pattern ph0-is-pattern inh-is-pattern inhabitant-is-symbol symbol-is-pattern ph0-is-pattern app-is-pattern inhabitant-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph0-is-pattern inh-is-sugar inhabitant-is-symbol symbol-is-pattern ph0-is-pattern inhabitant-is-symbol symbol-is-pattern ph1-is-pattern inhabitant-is-symbol symbol-is-pattern equal-reflexivity equal-inh.0 equal-app equal-transitivity ph1-is-pattern inh-is-pattern inhabitant-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph1-is-pattern inh-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-in-sort.0 $e #Equal ph0 ph2 $.
    equal-in-sort.1 $e #Equal ph1 ph3 $.
    equal-in-sort $p #Equal ( \in-sort ph0 ph1 ) ( \in-sort ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern in-sort-is-pattern ph2-is-pattern ph3-is-pattern inh-is-pattern included-is-pattern ph2-is-pattern ph3-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern inh-is-pattern included-is-pattern ph2-is-pattern ph3-is-pattern inh-is-pattern included-is-pattern ph0-is-pattern ph1-is-pattern in-sort-is-sugar ph0-is-pattern ph1-is-pattern inh-is-pattern ph2-is-pattern ph3-is-pattern inh-is-pattern equal-in-sort.0 ph1-is-pattern ph3-is-pattern equal-in-sort.1 equal-inh equal-included equal-transitivity ph2-is-pattern ph3-is-pattern in-sort-is-pattern ph2-is-pattern ph3-is-pattern inh-is-pattern included-is-pattern ph2-is-pattern ph3-is-pattern in-sort-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-sorted-forall.0 $e #Equal ph0 ph2 $.
    equal-sorted-forall.1 $e #Equal ph1 ph3 $.
    equal-sorted-forall $p #Equal ( \sorted-forall x ph0 ph1 ) ( \sorted-forall x ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern x-is-element-var sorted-forall-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern imp-is-pattern x-is-element-var forall-is-pattern ph2-is-pattern ph3-is-pattern x-is-element-var sorted-forall-is-pattern ph0-is-pattern ph1-is-pattern x-is-element-var sorted-forall-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern imp-is-pattern x-is-element-var forall-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern imp-is-pattern x-is-element-var forall-is-pattern ph0-is-pattern ph1-is-pattern x-is-element-var sorted-forall-is-sugar x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern imp-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern imp-is-pattern x-is-element-var x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern x-is-element-var element-var-is-var var-is-pattern equal-reflexivity equal-sorted-forall.0 equal-in-sort equal-sorted-forall.1 equal-imp equal-forall equal-transitivity ph2-is-pattern ph3-is-pattern x-is-element-var sorted-forall-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern imp-is-pattern x-is-element-var forall-is-pattern ph2-is-pattern ph3-is-pattern x-is-element-var sorted-forall-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-sorted-exists.0 $e #Equal ph0 ph2 $.
    equal-sorted-exists.1 $e #Equal ph1 ph3 $.
    equal-sorted-exists $p #Equal ( \sorted-exists x ph0 ph1 ) ( \sorted-exists x ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph2-is-pattern ph3-is-pattern x-is-element-var sorted-exists-is-pattern ph0-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph0-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-sugar x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern and-is-pattern x-is-element-var x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern x-is-element-var element-var-is-var var-is-pattern equal-reflexivity equal-sorted-exists.0 equal-in-sort equal-sorted-exists.1 equal-and equal-exists equal-transitivity ph2-is-pattern ph3-is-pattern x-is-element-var sorted-exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph2-is-pattern ph3-is-pattern x-is-element-var sorted-exists-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-forall-sort.0 $e #Equal ph0 ph1 $.
    equal-forall-sort $p #Equal ( \forall-sort s0 ph0 ) ( \forall-sort s0 ph1 ) $= ph0-is-pattern s0-is-element-var forall-sort-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-forall-is-pattern ph1-is-pattern s0-is-element-var forall-sort-is-pattern ph0-is-pattern s0-is-element-var forall-sort-is-pattern sort-is-symbol symbol-is-pattern ph0-is-pattern s0-is-element-var sorted-forall-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-forall-is-pattern ph0-is-pattern s0-is-element-var forall-sort-is-sugar sort-is-symbol symbol-is-pattern ph0-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sort-is-symbol symbol-is-pattern equal-reflexivity equal-forall-sort.0 equal-sorted-forall equal-transitivity ph1-is-pattern s0-is-element-var forall-sort-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-forall-is-pattern ph1-is-pattern s0-is-element-var forall-sort-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-exists-sort.0 $e #Equal ph0 ph1 $.
    equal-exists-sort $p #Equal ( \exists-sort s0 ph0 ) ( \exists-sort s0 ph1 ) $= ph0-is-pattern s0-is-element-var exists-sort-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-exists-is-pattern ph1-is-pattern s0-is-element-var exists-sort-is-pattern ph0-is-pattern s0-is-element-var exists-sort-is-pattern sort-is-symbol symbol-is-pattern ph0-is-pattern s0-is-element-var sorted-exists-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-exists-is-pattern ph0-is-pattern s0-is-element-var exists-sort-is-sugar sort-is-symbol symbol-is-pattern ph0-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sort-is-symbol symbol-is-pattern equal-reflexivity equal-exists-sort.0 equal-sorted-exists equal-transitivity ph1-is-pattern s0-is-element-var exists-sort-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-exists-is-pattern ph1-is-pattern s0-is-element-var exists-sort-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-is-top.0 $e #Equal ph0 ph1 $.
    equal-is-top $p #Equal ( \is-top ph0 ) ( \is-top ph1 ) $= ph0-is-pattern is-top-is-pattern ph1-is-pattern top-is-pattern eq-is-pattern ph1-is-pattern is-top-is-pattern ph0-is-pattern is-top-is-pattern ph0-is-pattern top-is-pattern eq-is-pattern ph1-is-pattern top-is-pattern eq-is-pattern ph0-is-pattern is-top-is-sugar ph0-is-pattern top-is-pattern ph1-is-pattern top-is-pattern equal-is-top.0 top-is-pattern equal-reflexivity equal-eq equal-transitivity ph1-is-pattern is-top-is-pattern ph1-is-pattern top-is-pattern eq-is-pattern ph1-is-pattern is-top-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-is-bot.0 $e #Equal ph0 ph1 $.
    equal-is-bot $p #Equal ( \is-bot ph0 ) ( \is-bot ph1 ) $= ph0-is-pattern is-bot-is-pattern ph1-is-pattern bot-is-pattern eq-is-pattern ph1-is-pattern is-bot-is-pattern ph0-is-pattern is-bot-is-pattern ph0-is-pattern bot-is-pattern eq-is-pattern ph1-is-pattern bot-is-pattern eq-is-pattern ph0-is-pattern is-bot-is-sugar ph0-is-pattern bot-is-pattern ph1-is-pattern bot-is-pattern equal-is-bot.0 bot-is-pattern equal-reflexivity equal-eq equal-transitivity ph1-is-pattern is-bot-is-pattern ph1-is-pattern bot-is-pattern eq-is-pattern ph1-is-pattern is-bot-is-sugar equal-symmetry equal-transitivity $.
$}

${
    equal-is-predicate.0 $e #Equal ph0 ph1 $.
    equal-is-predicate $p #Equal ( \is-predicate ph0 ) ( \is-predicate ph1 ) $= ph0-is-pattern is-predicate-is-pattern ph1-is-pattern is-top-is-pattern ph1-is-pattern is-bot-is-pattern or-is-pattern ph1-is-pattern is-predicate-is-pattern ph0-is-pattern is-predicate-is-pattern ph0-is-pattern is-top-is-pattern ph0-is-pattern is-bot-is-pattern or-is-pattern ph1-is-pattern is-top-is-pattern ph1-is-pattern is-bot-is-pattern or-is-pattern ph0-is-pattern is-predicate-is-sugar ph0-is-pattern is-top-is-pattern ph0-is-pattern is-bot-is-pattern ph1-is-pattern is-top-is-pattern ph1-is-pattern is-bot-is-pattern ph0-is-pattern ph1-is-pattern equal-is-predicate.0 equal-is-top ph0-is-pattern ph1-is-pattern equal-is-predicate.0 equal-is-bot equal-or equal-transitivity ph1-is-pattern is-predicate-is-pattern ph1-is-pattern is-top-is-pattern ph1-is-pattern is-bot-is-pattern or-is-pattern ph1-is-pattern is-predicate-is-sugar equal-symmetry equal-transitivity $.
$}

$( Other lemmas $)

${
    equal-not.0 $e #Equal ph0 ph1 $.
    equal-not $p #Equal ( \not ph0 ) ( \not ph1 ) $=
        ph0-is-pattern not-is-pattern ph0-is-pattern bot-is-pattern
        imp-is-pattern ph1-is-pattern not-is-pattern ph0-is-pattern not-is-sugar
        ph0-is-pattern bot-is-pattern imp-is-pattern ph1-is-pattern
        bot-is-pattern imp-is-pattern ph1-is-pattern not-is-pattern
        ph0-is-pattern bot-is-pattern ph1-is-pattern bot-is-pattern equal-not.0
        bot-is-pattern equal-reflexivity equal-imp ph1-is-pattern not-is-pattern
        ph1-is-pattern bot-is-pattern imp-is-pattern ph1-is-pattern not-is-sugar
        equal-symmetry equal-transitivity equal-transitivity $.
$}

${
    lemma-forall-gen.0 $e |- ( \imp ph0 ph1 ) $.
    lemma-forall-gen.1 $e #Fresh x ph0 $.
    lemma-forall-gen $p |- ( \imp ph0 ( \forall x ph1 ) ) $= ? $.
$}

lemma-dn-intro $p |- ( \imp ph0 ( \imp ( \imp ph0 \bot ) \bot ) ) $= ? $.

lemma-top $p |- \top $= ? $.

${
    $d x ph2 $.
    lemma-sorted-forall-gen.0 $e |- ( \imp ph0 ph1 ) $.
    lemma-sorted-forall-gen.1 $e #Fresh x ph0 $.
    lemma-sorted-forall-gen $p |- ( \imp ph0 ( \sorted-forall x ph2 ph1 ) ) $= ? $.
$}

${
    $d x ph1 $.
    lemma-sort-forall-gen-variant.0 $e |- ph0 $.
    lemma-sort-forall-gen-variant $p |- ( \sorted-forall x ph1 ph0 ) $= ? $.
$}

lemma-eq-reflexivity $p |- ( \eq ph0 ph0 ) $= ? $.
