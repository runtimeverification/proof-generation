$[ theory/matching-logic-prelude.mm $]
$[ theory/propositional.mm $]

$( Substitution lemmas $)

${
    substitution-not.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-not $p #Substitution ( \not ph1 ) ( \not ph2 ) ph0 xX $= ph1-is-pattern bot-is-pattern imp-is-pattern ph2-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern bot-is-pattern ph2-is-pattern bot-is-pattern xX-is-var substitution-not.0 ph0-is-pattern xX-is-var substitution-bot substitution-imp ph1-is-pattern not-is-sugar ph2-is-pattern not-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-or.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-or.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-or $p #Substitution ( \or ph1 ph2 ) ( \or ph3 ph4 ) ph0 xX $= ph1-is-pattern not-is-pattern ph2-is-pattern imp-is-pattern ph3-is-pattern not-is-pattern ph4-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern or-is-pattern ph3-is-pattern ph4-is-pattern or-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern ph3-is-pattern not-is-pattern ph4-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph3-is-pattern xX-is-var substitution-or.0 substitution-not substitution-or.1 substitution-imp ph1-is-pattern ph2-is-pattern or-is-sugar ph3-is-pattern ph4-is-pattern or-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-and.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-and.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-and $p #Substitution ( \and ph1 ph2 ) ( \and ph3 ph4 ) ph0 xX $= ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern or-is-pattern not-is-pattern ph3-is-pattern not-is-pattern ph4-is-pattern not-is-pattern or-is-pattern not-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern and-is-pattern ph3-is-pattern ph4-is-pattern and-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern or-is-pattern ph3-is-pattern not-is-pattern ph4-is-pattern not-is-pattern or-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern ph4-is-pattern not-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph3-is-pattern xX-is-var substitution-and.0 substitution-not ph0-is-pattern ph2-is-pattern ph4-is-pattern xX-is-var substitution-and.1 substitution-not substitution-or substitution-not ph1-is-pattern ph2-is-pattern and-is-sugar ph3-is-pattern ph4-is-pattern and-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-iff.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-iff.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-iff $p #Substitution ( \iff ph1 ph2 ) ( \iff ph3 ph4 ) ph0 xX $= ph1-is-pattern ph2-is-pattern imp-is-pattern ph2-is-pattern ph1-is-pattern imp-is-pattern and-is-pattern ph3-is-pattern ph4-is-pattern imp-is-pattern ph4-is-pattern ph3-is-pattern imp-is-pattern and-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern ph3-is-pattern ph4-is-pattern iff-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern imp-is-pattern ph2-is-pattern ph1-is-pattern imp-is-pattern ph3-is-pattern ph4-is-pattern imp-is-pattern ph4-is-pattern ph3-is-pattern imp-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern ph4-is-pattern xX-is-var substitution-iff.0 substitution-iff.1 substitution-imp ph0-is-pattern ph2-is-pattern ph1-is-pattern ph4-is-pattern ph3-is-pattern xX-is-var substitution-iff.1 substitution-iff.0 substitution-imp substitution-and ph1-is-pattern ph2-is-pattern iff-is-sugar ph3-is-pattern ph4-is-pattern iff-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-ceil.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-ceil $p #Substitution ( \ceil ph1 ) ( \ceil ph2 ) ph0 xX $= definedness-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern definedness-is-symbol symbol-is-pattern ph2-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern ceil-is-pattern ph2-is-pattern ceil-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern definedness-is-symbol symbol-is-pattern ph1-is-pattern definedness-is-symbol symbol-is-pattern ph2-is-pattern xX-is-var ph0-is-pattern xX-is-var definedness-is-symbol substitution-symbol substitution-ceil.0 substitution-app ph1-is-pattern ceil-is-sugar ph2-is-pattern ceil-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-floor.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-floor $p #Substitution ( \floor ph1 ) ( \floor ph2 ) ph0 xX $= ph1-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph2-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph0-is-pattern ph1-is-pattern floor-is-pattern ph2-is-pattern floor-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern not-is-pattern ceil-is-pattern ph2-is-pattern not-is-pattern ceil-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern xX-is-var substitution-floor.0 substitution-not substitution-ceil substitution-not ph1-is-pattern floor-is-sugar ph2-is-pattern floor-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-included.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-included.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-included $p #Substitution ( \included ph1 ph2 ) ( \included ph3 ph4 ) ph0 xX $= ph1-is-pattern ph2-is-pattern imp-is-pattern floor-is-pattern ph3-is-pattern ph4-is-pattern imp-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern included-is-pattern ph3-is-pattern ph4-is-pattern included-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern imp-is-pattern ph3-is-pattern ph4-is-pattern imp-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern ph4-is-pattern xX-is-var substitution-included.0 substitution-included.1 substitution-imp substitution-floor ph1-is-pattern ph2-is-pattern included-is-sugar ph3-is-pattern ph4-is-pattern included-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-eq.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-eq.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-eq $p #Substitution ( \eq ph1 ph2 ) ( \eq ph3 ph4 ) ph0 xX $= ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph3-is-pattern ph4-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern eq-is-pattern ph3-is-pattern ph4-is-pattern eq-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern ph3-is-pattern ph4-is-pattern iff-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern ph4-is-pattern xX-is-var substitution-eq.0 substitution-eq.1 substitution-iff substitution-floor ph1-is-pattern ph2-is-pattern eq-is-sugar ph3-is-pattern ph4-is-pattern eq-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-inh.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-inh $p #Substitution ( \inh ph1 ) ( \inh ph2 ) ph0 xX $= inhabitant-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern inhabitant-is-symbol symbol-is-pattern ph2-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern inh-is-pattern ph2-is-pattern inh-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern inhabitant-is-symbol symbol-is-pattern ph1-is-pattern inhabitant-is-symbol symbol-is-pattern ph2-is-pattern xX-is-var ph0-is-pattern xX-is-var inhabitant-is-symbol substitution-symbol substitution-inh.0 substitution-app ph1-is-pattern inh-is-sugar ph2-is-pattern inh-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-in-sort.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-in-sort.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-in-sort $p #Substitution ( \in-sort ph1 ph2 ) ( \in-sort ph3 ph4 ) ph0 xX $= ph1-is-pattern ph2-is-pattern inh-is-pattern included-is-pattern ph3-is-pattern ph4-is-pattern inh-is-pattern included-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern ph4-is-pattern in-sort-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern ph1-is-pattern ph2-is-pattern inh-is-pattern ph3-is-pattern ph4-is-pattern inh-is-pattern xX-is-var substitution-in-sort.0 ph0-is-pattern ph2-is-pattern ph4-is-pattern xX-is-var substitution-in-sort.1 substitution-inh substitution-included ph1-is-pattern ph2-is-pattern in-sort-is-sugar ph3-is-pattern ph4-is-pattern in-sort-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-pair-sort.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-pair-sort.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-pair-sort $p #Substitution ( \pair-sort ph1 ph2 ) ( \pair-sort ph3 ph4 ) ph0 xX $= pair-sort-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph2-is-pattern app-is-pattern pair-sort-symbol-is-symbol symbol-is-pattern ph3-is-pattern app-is-pattern ph4-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern pair-sort-is-pattern ph3-is-pattern ph4-is-pattern pair-sort-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern pair-sort-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph2-is-pattern pair-sort-symbol-is-symbol symbol-is-pattern ph3-is-pattern app-is-pattern ph4-is-pattern xX-is-var ph0-is-pattern pair-sort-symbol-is-symbol symbol-is-pattern ph1-is-pattern pair-sort-symbol-is-symbol symbol-is-pattern ph3-is-pattern xX-is-var ph0-is-pattern xX-is-var pair-sort-symbol-is-symbol substitution-symbol substitution-pair-sort.0 substitution-app substitution-pair-sort.1 substitution-app ph1-is-pattern ph2-is-pattern pair-sort-is-sugar ph3-is-pattern ph4-is-pattern pair-sort-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-pair.0 $e #Substitution ph1 ph3 ph0 xX $.
    substitution-pair.1 $e #Substitution ph2 ph4 ph0 xX $.
    substitution-pair $p #Substitution ( \pair ph1 ph2 ) ( \pair ph3 ph4 ) ph0 xX $= pair-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph2-is-pattern app-is-pattern pair-symbol-is-symbol symbol-is-pattern ph3-is-pattern app-is-pattern ph4-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern pair-is-pattern ph3-is-pattern ph4-is-pattern pair-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern pair-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph2-is-pattern pair-symbol-is-symbol symbol-is-pattern ph3-is-pattern app-is-pattern ph4-is-pattern xX-is-var ph0-is-pattern pair-symbol-is-symbol symbol-is-pattern ph1-is-pattern pair-symbol-is-symbol symbol-is-pattern ph3-is-pattern xX-is-var ph0-is-pattern xX-is-var pair-symbol-is-symbol substitution-symbol substitution-pair.0 substitution-app substitution-pair.1 substitution-app ph1-is-pattern ph2-is-pattern pair-is-sugar ph3-is-pattern ph4-is-pattern pair-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-pair-fst.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-pair-fst $p #Substitution ( \pair-fst ph1 ) ( \pair-fst ph2 ) ph0 xX $= pair-fst-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern pair-fst-symbol-is-symbol symbol-is-pattern ph2-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern pair-fst-is-pattern ph2-is-pattern pair-fst-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern pair-fst-symbol-is-symbol symbol-is-pattern ph1-is-pattern pair-fst-symbol-is-symbol symbol-is-pattern ph2-is-pattern xX-is-var ph0-is-pattern xX-is-var pair-fst-symbol-is-symbol substitution-symbol substitution-pair-fst.0 substitution-app ph1-is-pattern pair-fst-is-sugar ph2-is-pattern pair-fst-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

${
    substitution-pair-snd.0 $e #Substitution ph1 ph2 ph0 xX $.
    substitution-pair-snd $p #Substitution ( \pair-snd ph1 ) ( \pair-snd ph2 ) ph0 xX $= pair-snd-symbol-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern pair-snd-symbol-is-symbol symbol-is-pattern ph2-is-pattern app-is-pattern ph0-is-pattern ph1-is-pattern pair-snd-is-pattern ph2-is-pattern pair-snd-is-pattern ph0-is-pattern xX-is-var ph0-is-pattern pair-snd-symbol-is-symbol symbol-is-pattern ph1-is-pattern pair-snd-symbol-is-symbol symbol-is-pattern ph2-is-pattern xX-is-var ph0-is-pattern xX-is-var pair-snd-symbol-is-symbol substitution-symbol substitution-pair-snd.0 substitution-app ph1-is-pattern pair-snd-is-sugar ph2-is-pattern pair-snd-is-sugar ph0-is-pattern notation-reflexivity notation-substitution $.
$}

$( Congruence lemmas $)

${
    notation-not.0 $e #Notation ph0 ph1 $.
    notation-not $p #Notation ( \not ph0 ) ( \not ph1 ) $= ph0-is-pattern not-is-pattern ph1-is-pattern bot-is-pattern imp-is-pattern ph1-is-pattern not-is-pattern ph0-is-pattern not-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern ph1-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern not-is-sugar ph0-is-pattern bot-is-pattern ph1-is-pattern bot-is-pattern notation-not.0 bot-is-pattern notation-reflexivity notation-imp notation-transitivity ph1-is-pattern not-is-pattern ph1-is-pattern bot-is-pattern imp-is-pattern ph1-is-pattern not-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-or.0 $e #Notation ph0 ph2 $.
    notation-or.1 $e #Notation ph1 ph3 $.
    notation-or $p #Notation ( \or ph0 ph1 ) ( \or ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern or-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern imp-is-pattern ph2-is-pattern ph3-is-pattern or-is-pattern ph0-is-pattern ph1-is-pattern or-is-pattern ph0-is-pattern not-is-pattern ph1-is-pattern imp-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern or-is-sugar ph0-is-pattern not-is-pattern ph1-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern ph0-is-pattern ph2-is-pattern notation-or.0 notation-not notation-or.1 notation-imp notation-transitivity ph2-is-pattern ph3-is-pattern or-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern imp-is-pattern ph2-is-pattern ph3-is-pattern or-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-and.0 $e #Notation ph0 ph2 $.
    notation-and.1 $e #Notation ph1 ph3 $.
    notation-and $p #Notation ( \and ph0 ph1 ) ( \and ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern and-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern or-is-pattern not-is-pattern ph2-is-pattern ph3-is-pattern and-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern ph0-is-pattern not-is-pattern ph1-is-pattern not-is-pattern or-is-pattern not-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern or-is-pattern not-is-pattern ph0-is-pattern ph1-is-pattern and-is-sugar ph0-is-pattern not-is-pattern ph1-is-pattern not-is-pattern or-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern or-is-pattern ph0-is-pattern not-is-pattern ph1-is-pattern not-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern ph0-is-pattern ph2-is-pattern notation-and.0 notation-not ph1-is-pattern ph3-is-pattern notation-and.1 notation-not notation-or notation-not notation-transitivity ph2-is-pattern ph3-is-pattern and-is-pattern ph2-is-pattern not-is-pattern ph3-is-pattern not-is-pattern or-is-pattern not-is-pattern ph2-is-pattern ph3-is-pattern and-is-sugar notation-symmetry notation-transitivity $.
$}

notation-top $p #Notation \top \top $= top-is-pattern bot-is-pattern not-is-pattern top-is-pattern top-is-pattern bot-is-pattern not-is-pattern bot-is-pattern not-is-pattern top-is-sugar bot-is-pattern not-is-pattern notation-reflexivity notation-transitivity top-is-pattern bot-is-pattern not-is-pattern top-is-sugar notation-symmetry notation-transitivity $.

${
    notation-iff.0 $e #Notation ph0 ph2 $.
    notation-iff.1 $e #Notation ph1 ph3 $.
    notation-iff $p #Notation ( \iff ph0 ph1 ) ( \iff ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern iff-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern ph3-is-pattern ph2-is-pattern imp-is-pattern and-is-pattern ph2-is-pattern ph3-is-pattern iff-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern ph0-is-pattern ph1-is-pattern imp-is-pattern ph1-is-pattern ph0-is-pattern imp-is-pattern and-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern ph3-is-pattern ph2-is-pattern imp-is-pattern and-is-pattern ph0-is-pattern ph1-is-pattern iff-is-sugar ph0-is-pattern ph1-is-pattern imp-is-pattern ph1-is-pattern ph0-is-pattern imp-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern ph3-is-pattern ph2-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern notation-iff.0 notation-iff.1 notation-imp ph1-is-pattern ph0-is-pattern ph3-is-pattern ph2-is-pattern notation-iff.1 notation-iff.0 notation-imp notation-and notation-transitivity ph2-is-pattern ph3-is-pattern iff-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern ph3-is-pattern ph2-is-pattern imp-is-pattern and-is-pattern ph2-is-pattern ph3-is-pattern iff-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-forall.0 $e #Notation ph0 ph1 $.
    notation-forall $p #Notation ( \forall x ph0 ) ( \forall x ph1 ) $= ph0-is-pattern x-is-element-var forall-is-pattern ph1-is-pattern not-is-pattern x-is-element-var exists-is-pattern not-is-pattern ph1-is-pattern x-is-element-var forall-is-pattern ph0-is-pattern x-is-element-var forall-is-pattern ph0-is-pattern not-is-pattern x-is-element-var exists-is-pattern not-is-pattern ph1-is-pattern not-is-pattern x-is-element-var exists-is-pattern not-is-pattern ph0-is-pattern x-is-element-var forall-is-sugar ph0-is-pattern not-is-pattern x-is-element-var exists-is-pattern ph1-is-pattern not-is-pattern x-is-element-var exists-is-pattern ph0-is-pattern not-is-pattern ph1-is-pattern not-is-pattern x-is-element-var ph0-is-pattern ph1-is-pattern notation-forall.0 notation-not notation-exists notation-not notation-transitivity ph1-is-pattern x-is-element-var forall-is-pattern ph1-is-pattern not-is-pattern x-is-element-var exists-is-pattern not-is-pattern ph1-is-pattern x-is-element-var forall-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-ceil.0 $e #Notation ph0 ph1 $.
    notation-ceil $p #Notation ( \ceil ph0 ) ( \ceil ph1 ) $= ph0-is-pattern ceil-is-pattern definedness-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph1-is-pattern ceil-is-pattern ph0-is-pattern ceil-is-pattern definedness-is-symbol symbol-is-pattern ph0-is-pattern app-is-pattern definedness-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph0-is-pattern ceil-is-sugar definedness-is-symbol symbol-is-pattern ph0-is-pattern definedness-is-symbol symbol-is-pattern ph1-is-pattern definedness-is-symbol symbol-is-pattern notation-reflexivity notation-ceil.0 notation-app notation-transitivity ph1-is-pattern ceil-is-pattern definedness-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph1-is-pattern ceil-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-floor.0 $e #Notation ph0 ph1 $.
    notation-floor $p #Notation ( \floor ph0 ) ( \floor ph1 ) $= ph0-is-pattern floor-is-pattern ph1-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph1-is-pattern floor-is-pattern ph0-is-pattern floor-is-pattern ph0-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph1-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph0-is-pattern floor-is-sugar ph0-is-pattern not-is-pattern ceil-is-pattern ph1-is-pattern not-is-pattern ceil-is-pattern ph0-is-pattern not-is-pattern ph1-is-pattern not-is-pattern ph0-is-pattern ph1-is-pattern notation-floor.0 notation-not notation-ceil notation-not notation-transitivity ph1-is-pattern floor-is-pattern ph1-is-pattern not-is-pattern ceil-is-pattern not-is-pattern ph1-is-pattern floor-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-in.0 $e #Notation ph0 ph1 $.
    notation-in $p #Notation ( \in x ph0 ) ( \in x ph1 ) $= ph0-is-pattern x-is-element-var in-is-pattern x-is-element-var element-var-is-var var-is-pattern ph1-is-pattern and-is-pattern ceil-is-pattern ph1-is-pattern x-is-element-var in-is-pattern ph0-is-pattern x-is-element-var in-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern and-is-pattern ceil-is-pattern x-is-element-var element-var-is-var var-is-pattern ph1-is-pattern and-is-pattern ceil-is-pattern ph0-is-pattern x-is-element-var in-is-sugar x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph1-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph1-is-pattern x-is-element-var element-var-is-var var-is-pattern notation-reflexivity notation-in.0 notation-and notation-ceil notation-transitivity ph1-is-pattern x-is-element-var in-is-pattern x-is-element-var element-var-is-var var-is-pattern ph1-is-pattern and-is-pattern ceil-is-pattern ph1-is-pattern x-is-element-var in-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-included.0 $e #Notation ph0 ph2 $.
    notation-included.1 $e #Notation ph1 ph3 $.
    notation-included $p #Notation ( \included ph0 ph1 ) ( \included ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern included-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern included-is-pattern ph0-is-pattern ph1-is-pattern included-is-pattern ph0-is-pattern ph1-is-pattern imp-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern included-is-sugar ph0-is-pattern ph1-is-pattern imp-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern notation-included.0 notation-included.1 notation-imp notation-floor notation-transitivity ph2-is-pattern ph3-is-pattern included-is-pattern ph2-is-pattern ph3-is-pattern imp-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern included-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-eq.0 $e #Notation ph0 ph2 $.
    notation-eq.1 $e #Notation ph1 ph3 $.
    notation-eq $p #Notation ( \eq ph0 ph1 ) ( \eq ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern eq-is-pattern ph2-is-pattern ph3-is-pattern iff-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern eq-is-pattern ph0-is-pattern ph1-is-pattern eq-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern eq-is-sugar ph0-is-pattern ph1-is-pattern iff-is-pattern ph2-is-pattern ph3-is-pattern iff-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern ph3-is-pattern notation-eq.0 notation-eq.1 notation-iff notation-floor notation-transitivity ph2-is-pattern ph3-is-pattern eq-is-pattern ph2-is-pattern ph3-is-pattern iff-is-pattern floor-is-pattern ph2-is-pattern ph3-is-pattern eq-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-inh.0 $e #Notation ph0 ph1 $.
    notation-inh $p #Notation ( \inh ph0 ) ( \inh ph1 ) $= ph0-is-pattern inh-is-pattern inhabitant-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph1-is-pattern inh-is-pattern ph0-is-pattern inh-is-pattern inhabitant-is-symbol symbol-is-pattern ph0-is-pattern app-is-pattern inhabitant-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph0-is-pattern inh-is-sugar inhabitant-is-symbol symbol-is-pattern ph0-is-pattern inhabitant-is-symbol symbol-is-pattern ph1-is-pattern inhabitant-is-symbol symbol-is-pattern notation-reflexivity notation-inh.0 notation-app notation-transitivity ph1-is-pattern inh-is-pattern inhabitant-is-symbol symbol-is-pattern ph1-is-pattern app-is-pattern ph1-is-pattern inh-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-in-sort.0 $e #Notation ph0 ph2 $.
    notation-in-sort.1 $e #Notation ph1 ph3 $.
    notation-in-sort $p #Notation ( \in-sort ph0 ph1 ) ( \in-sort ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern in-sort-is-pattern ph2-is-pattern ph3-is-pattern inh-is-pattern included-is-pattern ph2-is-pattern ph3-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern inh-is-pattern included-is-pattern ph2-is-pattern ph3-is-pattern inh-is-pattern included-is-pattern ph0-is-pattern ph1-is-pattern in-sort-is-sugar ph0-is-pattern ph1-is-pattern inh-is-pattern ph2-is-pattern ph3-is-pattern inh-is-pattern notation-in-sort.0 ph1-is-pattern ph3-is-pattern notation-in-sort.1 notation-inh notation-included notation-transitivity ph2-is-pattern ph3-is-pattern in-sort-is-pattern ph2-is-pattern ph3-is-pattern inh-is-pattern included-is-pattern ph2-is-pattern ph3-is-pattern in-sort-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-sorted-forall.0 $e #Notation ph0 ph2 $.
    notation-sorted-forall.1 $e #Notation ph1 ph3 $.
    notation-sorted-forall $p #Notation ( \sorted-forall x ph0 ph1 ) ( \sorted-forall x ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern x-is-element-var sorted-forall-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern imp-is-pattern x-is-element-var forall-is-pattern ph2-is-pattern ph3-is-pattern x-is-element-var sorted-forall-is-pattern ph0-is-pattern ph1-is-pattern x-is-element-var sorted-forall-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern imp-is-pattern x-is-element-var forall-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern imp-is-pattern x-is-element-var forall-is-pattern ph0-is-pattern ph1-is-pattern x-is-element-var sorted-forall-is-sugar x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern imp-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern imp-is-pattern x-is-element-var x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern x-is-element-var element-var-is-var var-is-pattern notation-reflexivity notation-sorted-forall.0 notation-in-sort notation-sorted-forall.1 notation-imp notation-forall notation-transitivity ph2-is-pattern ph3-is-pattern x-is-element-var sorted-forall-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern imp-is-pattern x-is-element-var forall-is-pattern ph2-is-pattern ph3-is-pattern x-is-element-var sorted-forall-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-sorted-exists.0 $e #Notation ph0 ph2 $.
    notation-sorted-exists.1 $e #Notation ph1 ph3 $.
    notation-sorted-exists $p #Notation ( \sorted-exists x ph0 ph1 ) ( \sorted-exists x ph2 ph3 ) $= ph0-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph2-is-pattern ph3-is-pattern x-is-element-var sorted-exists-is-pattern ph0-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph0-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-sugar x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern and-is-pattern x-is-element-var x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern in-sort-is-pattern ph1-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern x-is-element-var element-var-is-var var-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern x-is-element-var element-var-is-var var-is-pattern notation-reflexivity notation-sorted-exists.0 notation-in-sort notation-sorted-exists.1 notation-and notation-exists notation-transitivity ph2-is-pattern ph3-is-pattern x-is-element-var sorted-exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph3-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph2-is-pattern ph3-is-pattern x-is-element-var sorted-exists-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-forall-sort.0 $e #Notation ph0 ph1 $.
    notation-forall-sort $p #Notation ( \forall-sort s0 ph0 ) ( \forall-sort s0 ph1 ) $= ph0-is-pattern s0-is-element-var forall-sort-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-forall-is-pattern ph1-is-pattern s0-is-element-var forall-sort-is-pattern ph0-is-pattern s0-is-element-var forall-sort-is-pattern sort-is-symbol symbol-is-pattern ph0-is-pattern s0-is-element-var sorted-forall-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-forall-is-pattern ph0-is-pattern s0-is-element-var forall-sort-is-sugar sort-is-symbol symbol-is-pattern ph0-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sort-is-symbol symbol-is-pattern notation-reflexivity notation-forall-sort.0 notation-sorted-forall notation-transitivity ph1-is-pattern s0-is-element-var forall-sort-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-forall-is-pattern ph1-is-pattern s0-is-element-var forall-sort-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-exists-sort.0 $e #Notation ph0 ph1 $.
    notation-exists-sort $p #Notation ( \exists-sort s0 ph0 ) ( \exists-sort s0 ph1 ) $= ph0-is-pattern s0-is-element-var exists-sort-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-exists-is-pattern ph1-is-pattern s0-is-element-var exists-sort-is-pattern ph0-is-pattern s0-is-element-var exists-sort-is-pattern sort-is-symbol symbol-is-pattern ph0-is-pattern s0-is-element-var sorted-exists-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-exists-is-pattern ph0-is-pattern s0-is-element-var exists-sort-is-sugar sort-is-symbol symbol-is-pattern ph0-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sort-is-symbol symbol-is-pattern notation-reflexivity notation-exists-sort.0 notation-sorted-exists notation-transitivity ph1-is-pattern s0-is-element-var exists-sort-is-pattern sort-is-symbol symbol-is-pattern ph1-is-pattern s0-is-element-var sorted-exists-is-pattern ph1-is-pattern s0-is-element-var exists-sort-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-is-top.0 $e #Notation ph0 ph1 $.
    notation-is-top $p #Notation ( \is-top ph0 ) ( \is-top ph1 ) $= ph0-is-pattern is-top-is-pattern ph1-is-pattern top-is-pattern eq-is-pattern ph1-is-pattern is-top-is-pattern ph0-is-pattern is-top-is-pattern ph0-is-pattern top-is-pattern eq-is-pattern ph1-is-pattern top-is-pattern eq-is-pattern ph0-is-pattern is-top-is-sugar ph0-is-pattern top-is-pattern ph1-is-pattern top-is-pattern notation-is-top.0 top-is-pattern notation-reflexivity notation-eq notation-transitivity ph1-is-pattern is-top-is-pattern ph1-is-pattern top-is-pattern eq-is-pattern ph1-is-pattern is-top-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-is-bot.0 $e #Notation ph0 ph1 $.
    notation-is-bot $p #Notation ( \is-bot ph0 ) ( \is-bot ph1 ) $= ph0-is-pattern is-bot-is-pattern ph1-is-pattern bot-is-pattern eq-is-pattern ph1-is-pattern is-bot-is-pattern ph0-is-pattern is-bot-is-pattern ph0-is-pattern bot-is-pattern eq-is-pattern ph1-is-pattern bot-is-pattern eq-is-pattern ph0-is-pattern is-bot-is-sugar ph0-is-pattern bot-is-pattern ph1-is-pattern bot-is-pattern notation-is-bot.0 bot-is-pattern notation-reflexivity notation-eq notation-transitivity ph1-is-pattern is-bot-is-pattern ph1-is-pattern bot-is-pattern eq-is-pattern ph1-is-pattern is-bot-is-sugar notation-symmetry notation-transitivity $.
$}

${
    notation-is-predicate.0 $e #Notation ph0 ph1 $.
    notation-is-predicate $p #Notation ( \is-predicate ph0 ) ( \is-predicate ph1 ) $= ph0-is-pattern is-predicate-is-pattern ph1-is-pattern is-top-is-pattern ph1-is-pattern is-bot-is-pattern or-is-pattern ph1-is-pattern is-predicate-is-pattern ph0-is-pattern is-predicate-is-pattern ph0-is-pattern is-top-is-pattern ph0-is-pattern is-bot-is-pattern or-is-pattern ph1-is-pattern is-top-is-pattern ph1-is-pattern is-bot-is-pattern or-is-pattern ph0-is-pattern is-predicate-is-sugar ph0-is-pattern is-top-is-pattern ph0-is-pattern is-bot-is-pattern ph1-is-pattern is-top-is-pattern ph1-is-pattern is-bot-is-pattern ph0-is-pattern ph1-is-pattern notation-is-predicate.0 notation-is-top ph0-is-pattern ph1-is-pattern notation-is-predicate.0 notation-is-bot notation-or notation-transitivity ph1-is-pattern is-predicate-is-pattern ph1-is-pattern is-top-is-pattern ph1-is-pattern is-bot-is-pattern or-is-pattern ph1-is-pattern is-predicate-is-sugar notation-symmetry notation-transitivity $.
$}

$( Other lemmas $)

lemma-top $p |- \top $= bot-is-pattern not-is-pattern top-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern bot-is-pattern not-is-pattern bot-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern imp-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern bot-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern bot-is-pattern imp-is-pattern imp-is-pattern bot-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern imp-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern imp-is-pattern bot-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern bot-is-pattern proof-rule-prop-2 bot-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern proof-rule-prop-1 proof-rule-mp bot-is-pattern bot-is-pattern proof-rule-prop-1 proof-rule-mp bot-is-pattern not-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern bot-is-pattern not-is-sugar bot-is-pattern bot-is-pattern imp-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern bot-is-pattern bot-is-pattern imp-is-pattern notation-reflexivity notation-symmetry notation-transitivity notation-proof top-is-pattern bot-is-pattern not-is-pattern bot-is-pattern not-is-pattern top-is-sugar bot-is-pattern not-is-pattern bot-is-pattern not-is-pattern bot-is-pattern not-is-pattern notation-reflexivity notation-symmetry notation-transitivity notation-proof $.

${
    lemma-forall-gen.0 $e |- ( \imp ph0 ph1 ) $.
    lemma-forall-gen.1 $e #Fresh x ph0 $.
    lemma-forall-gen $p |- ( \imp ph0 ( \forall x ph1 ) ) $= ? $.
$}

lemma-dn-intro $p |- ( \imp ph0 ( \imp ( \imp ph0 \bot ) \bot ) ) $= ? $.

$( ${
    $d x ph2 $.
    lemma-sorted-forall-gen.0 $e |- ( \imp ph0 ph1 ) $.
    lemma-sorted-forall-gen.1 $e #Fresh x ph0 $.
    lemma-sorted-forall-gen $p |- ( \imp ph0 ( \sorted-forall x ph2 ph1 ) ) $= ? $.
$}

${
    $d x ph1 $.
    lemma-sort-forall-gen-variant.0 $e |- ph0 $.
    lemma-sort-forall-gen-variant $p |- ( \sorted-forall x ph1 ph0 ) $= ? $.
$} $)

$( ==================================== $)

${
    lemma-floor-intro.0 $e |- ph0 $.
    lemma-floor-intro $p |- ( \floor ph0 ) $= ? $. 
$}

${
    lemma-floor-elim.0 $e |- ( \floor ph0 ) $.
    lemma-floor-elim $p |- ph0 $= ? $. 
$}

${
    lemma-eq-intro.0 $e |- ( \imp ph0 ph1 ) $.
    lemma-eq-intro.1 $e |- ( \imp ph1 ph0 ) $.
    lemma-eq-intro $p |- ( \eq ph0 ph1 ) $= ? $.
$}

${
    lemma-eq-1.0 $e |- ph0 $.
    lemma-eq-1 $p |- ( \eq ( \and ph0 ph1 ) ph1 ) $= ? $.
$}

$( Implication Reflexivity $)
$( Same as the one for propositional logic $)

lemma-imp-reflexivity $p |- ( \imp ph0 ph0 ) $= ph0-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern imp-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern ph0-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern ph0-is-pattern imp-is-pattern imp-is-pattern ph0-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern imp-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern imp-is-pattern ph0-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern ph0-is-pattern proof-rule-prop-2 ph0-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern proof-rule-prop-1 proof-rule-mp ph0-is-pattern ph0-is-pattern proof-rule-prop-1 proof-rule-mp $.

lemma-eq-imp $p |- ( \imp ( \eq ph0 ph1 ) ( \imp ph0 ph1 ) ) $= ? $.

$(================== Equality ==================$)

$( Reflexivity $)

lemma-eq-reflexivity $p |- ( \eq ph0 ph0 ) $= ? $.

$( Symmetry $)

${
    lemma-eq-symmetry.0 $e |- ( \eq ph1 ph0 ) $.
    lemma-eq-symmetry $p |- ( \eq ph0 ph1 ) $= ? $.
$}

$( Transitivity $)

${
    lemma-eq-transitivity.0 $e |- ( \eq ph0 ph1 ) $.
    lemma-eq-transitivity.1 $e |- ( \eq ph1 ph2 ) $.
    lemma-eq-transitivity $p |- ( \eq ph0 ph2 ) $= 
    $(
        desugar \eq
        apply lemma-floor-intro
        apply rule-iff-transitivity
        let $2 = ph1
        apply lemma-floor-elim
        apply proof-rule-mp
        let $5 = "( \eq ph0 ph1 )"
        desugar \eq
        apply lemma-imp-reflexivity
        apply lemma-eq-transitivity.0
        apply lemma-floor-elim
        apply proof-rule-mp
        let $9 = "( \eq ph1 ph2 )"
        desugar \eq
        apply lemma-imp-reflexivity
        apply lemma-eq-transitivity.1 
    $)
    ph0-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph2-is-pattern eq-is-pattern ph0-is-pattern ph2-is-pattern iff-is-pattern ph0-is-pattern ph1-is-pattern ph2-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern ph0-is-pattern ph1-is-pattern eq-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern eq-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern imp-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern lemma-imp-reflexivity ph0-is-pattern ph1-is-pattern eq-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern eq-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern eq-is-sugar ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern notation-reflexivity notation-symmetry notation-transitivity ph0-is-pattern ph1-is-pattern iff-is-pattern floor-is-pattern notation-reflexivity notation-imp notation-proof lemma-eq-transitivity.0 proof-rule-mp lemma-floor-elim ph1-is-pattern ph2-is-pattern iff-is-pattern ph1-is-pattern ph2-is-pattern eq-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern imp-is-pattern ph1-is-pattern ph2-is-pattern eq-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern imp-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern lemma-imp-reflexivity ph1-is-pattern ph2-is-pattern eq-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph1-is-pattern ph2-is-pattern eq-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph1-is-pattern ph2-is-pattern eq-is-sugar ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern notation-reflexivity notation-symmetry notation-transitivity ph1-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern notation-reflexivity notation-imp notation-proof lemma-eq-transitivity.1 proof-rule-mp lemma-floor-elim rule-iff-transitivity lemma-floor-intro ph0-is-pattern ph2-is-pattern eq-is-pattern ph0-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph2-is-pattern eq-is-sugar ph0-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern ph0-is-pattern ph2-is-pattern iff-is-pattern floor-is-pattern notation-reflexivity notation-symmetry notation-transitivity notation-proof
    $.
$}

$( Congruence $)

${
    lemma-eq-congruence-or.0 $e |- ( \eq ph0 ph2 ) $.
    lemma-eq-congruence-or.1 $e |- ( \eq ph1 ph3 ) $.
    lemma-eq-congruence-or $p |- ( \eq ( \or ph0 ph1 ) ( \or ph2 ph3 ) ) $= ? $.
$}

${
    lemma-eq-congruence-and.0 $e |- ( \eq ph0 ph2 ) $.
    lemma-eq-congruence-and.1 $e |- ( \eq ph1 ph3 ) $.
    lemma-eq-congruence-and $p |- ( \eq ( \and ph0 ph1 ) ( \and ph2 ph3 ) ) $= ? $.
$}

${
    lemma-eq-congruence-not.0 $e |- ( \eq ph0 ph1 ) $.
    lemma-eq-congruence-not $p |- ( \eq ( \not ph0 ) ( \not ph1 ) ) $= ? $.
$}