$[ theory/kore.mm $]

${
    notation-kore-valid.0 $e #Notation ph0 ph2 $.
    notation-kore-valid.1 $e #Notation ph1 ph3 $.
    notation-kore-valid $p #Notation ( \kore-valid ph0 ph1 ) ( \kore-valid ph2 ph3 ) $= ( kore-top-is-pattern eq-is-pattern inh-is-pattern kore-valid-is-pattern notation-symmetry notation-transitivity kore-valid-is-sugar kore-top-is-sugar notation-inh notation-eq ) ABJBAGHCDJABMCDJBAGHCDJDCGHBAGHCDMBAGHDCGHBAGDCGFAGAICGANCGAICGCIAICNAICIACEOKLKLPKLKL $.
$}

${
    notation-kore-next.0 $e #Notation ph0 ph2 $.
    notation-kore-next.1 $e #Notation ph1 ph3 $.
    notation-kore-next $p #Notation ( \kore-next ph0 ph1 ) ( \kore-next ph2 ph3 ) $= ( kore-next-is-symbol symbol-is-pattern app-is-pattern kore-next-is-pattern kore-next-is-sugar notation-symmetry notation-transitivity notation-reflexivity notation-app ) ABJGHBICDJABKCDJGHBICDJGHDIGHBICDKGHBIGHDIGHBGHDGHNFOLMLM $.
$}

${
    notation-kore-or.0 $e #Notation ph0 ph3 $.
    notation-kore-or.1 $e #Notation ph1 ph4 $.
    notation-kore-or.2 $e #Notation ph2 ph5 $.
    notation-kore-or $p #Notation ( \kore-or ph0 ph1 ph2 ) ( \kore-or ph3 ph4 ph5 ) $= ( or-is-pattern kore-or-is-pattern kore-or-is-sugar notation-symmetry notation-transitivity notation-or ) ABCKBCJDEFKABCLDEFKBCJDEFKEFJBCJDEFLBCJEFJBCEFHIOMNMN $.
$}

${
    notation-kore-implies.0 $e #Notation ph0 ph3 $.
    notation-kore-implies.1 $e #Notation ph1 ph4 $.
    notation-kore-implies.2 $e #Notation ph2 ph5 $.
    notation-kore-implies $p #Notation ( \kore-implies ph0 ph1 ph2 ) ( \kore-implies ph3 ph4 ph5 ) $= ( kore-not-is-pattern kore-top-is-pattern not-is-pattern kore-or-is-pattern and-is-pattern inh-is-pattern notation-symmetry notation-transitivity kore-implies-is-pattern kore-implies-is-sugar kore-not-is-sugar kore-top-is-sugar notation-not notation-inh notation-and notation-kore-or ) ABCRAABJCMDEFRABCSDEFRAABJCMDEFRDDEJFMAABJCMDEFSAABJCMDDEJFMAABJCDDEJFGABJBLAKNDEJABTDEJBLAKNDEJELDKNBLAKNDETBLAKNELDKNBLAKELDKBEHUBAKAODKAUADKAODKDOAODUAAODOADGUCPQPQUDPQPQIUEPQPQ $.
$}
