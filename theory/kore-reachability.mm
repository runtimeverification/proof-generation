$[ theory/kore.mm $]
$[ theory/kore-predicate.mm $]

${
    kore-rewrites-star-reflexivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-star-reflexivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph1 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-union.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ( \kore-and ph0 ph1 ph3 ) ph4 ) ) ) $.
    kore-rewrites-star-union.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ( \kore-and ph0 ph2 ph3 ) ph5 ) ) ) $.
    kore-rewrites-star-union   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ( \kore-and ph0 ( \kore-or ph0 ph1 ph2 ) ph3 ) ( \kore-or ph0 ph4 ph5 ) ) ) ) $= ? $.
$}

${
    kore-rewrites-plus-union.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ( \kore-and ph0 ph1 ph3 ) ph4 ) ) ) $.
    kore-rewrites-plus-union.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ( \kore-and ph0 ph2 ph3 ) ph5 ) ) ) $.
    kore-rewrites-plus-union   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ( \kore-and ph0 ( \kore-or ph0 ph1 ph2 ) ph3 ) ( \kore-or ph0 ph4 ph5 ) ) ) ) $= ? $.
$}

${
    kore-rewrites-star-subsumption-lhs.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-subsumption-lhs.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-star-subsumption-lhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph3 ) ) ) $=
        $(
            apply "kore-implies-transitivity-alt"
            apply "kore-rewrites-star-subsumption-lhs.0"
            apply "kore-rewrites-star-subsumption-lhs.1"
        $)
        ( kore-evetually-is-pattern kore-implies-is-pattern kore-rewrites-star-is-pattern kore-valid-is-pattern notation-reflexivity imp-is-pattern kore-rewrites-star-is-sugar notation-transitivity notation-kore-valid notation-imp notation-proof notation-symmetry kore-implies-transitivity-alt ) EAABADHIKMEAABDJKMABCADHEFEAACDJKMEAACADHIKMGEAACADHIKEAACDJKELAACADHIAACDJALACADHIACADHIACDJACADHILACDJACADHIACDNSOPQRTEAABDJKEAABADHIKELAABDJAABADHIALABDJABADHIABADHIABDNABADHILOPQR $.
$}

${
    kore-rewrites-star-subsumption-rhs.0 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-star-subsumption-rhs.1 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-star-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-star-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-rewrites-plus-subsumption-lhs.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-plus-subsumption-lhs.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-plus-subsumption-lhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph3 ) ) ) $=
        $(
            apply "kore-implies-transitivity-alt"
            apply "kore-rewrites-plus-subsumption-lhs.0"
            apply "kore-rewrites-plus-subsumption-lhs.1"
        $)
        ( kore-evetually-is-pattern kore-next-is-pattern kore-implies-is-pattern kore-rewrites-plus-is-pattern kore-valid-is-pattern notation-reflexivity imp-is-pattern kore-rewrites-plus-is-sugar notation-transitivity notation-kore-valid notation-imp notation-proof notation-symmetry kore-implies-transitivity-alt ) EAABAADHIJLNEAABDKLNABCAADHIEFEAACDKLNEAACAADHIJLNGEAACAADHIJLEAACDKLEMAACAADHIJAACDKAMACAADHIJACAADHIJACDKACAADHIJMACDKACAADHIJACDOTPQRSUAEAABDKLEAABAADHIJLEMAABDKAABAADHIJAMABDKABAADHIJABAADHIJABDOABAADHIJMPQRS $.
$}

${
    kore-rewrites-plus-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-plus-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-plus-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-prune.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-not ph0 ph2 ) ) ) $.
    kore-rewrites-star-prune.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ( \kore-or ph0 ( \kore-and ph0 ph2 ph3 ) ph4 ) ) ) ) $.
    kore-rewrites-star-prune   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph4 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-branch.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ( \kore-or ph0 ph2 ph3 ) ) ) ) $.
    kore-rewrites-star-branch.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph4 ) ) ) $.
    kore-rewrites-star-branch   $p |- ( \imp th0  ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ( \kore-or ph0 ph4 ph3 ) ) ) ) $= ? $.
$}

${
    kore-rewrites-plus-branch.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ( \kore-or ph0 ph2 ph3 ) ) ) ) $.
    kore-rewrites-plus-branch.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph4 ) ) ) $.
    kore-rewrites-plus-branch   $p |- ( \imp th0  ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ( \kore-or ph0 ph4 ph3 ) ) ) ) $= ? $.
$}

${
    kore-rewrites-subsumption-lhs.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-subsumption-lhs.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-subsumption-lhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph3 ) ) ) $=
        $(
            apply "kore-implies-transitivity-alt"
            apply "kore-rewrites-subsumption-lhs.0"
            apply "kore-rewrites-subsumption-lhs.1"
        $)
        ( kore-next-is-pattern kore-implies-is-pattern kore-rewrites-is-pattern kore-valid-is-pattern notation-reflexivity imp-is-pattern kore-rewrites-is-sugar notation-transitivity notation-kore-valid notation-imp notation-proof notation-symmetry kore-implies-transitivity-alt ) EAABADHIKMEAABDJKMABCADHEFEAACDJKMEAACADHIKMGEAACADHIKEAACDJKELAACADHIAACDJALACADHIACADHIACDJACADHILACDJACADHIACDNSOPQRTEAABDJKEAABADHIKELAABDJAABADHIALABDJABADHIABADHIABDNABADHILOPQR $.
$}

${
    kore-rewrites-subsumption-rhs.0 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-subsumption-rhs.1 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    $( constraint before rewriting can be passed to the term after rewriting $)
    $( kore-rewrites-constraint-lemma.0 $e |- ( \kore-is-predicate ph0 ph1 ) $. $)
    kore-rewrites-constraint-lemma.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ( \kore-and ph0 ph1 ph2 ) ph3 ) ) ) $.
    kore-rewrites-constraint-lemma   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph0 ph1 ph3 ) ) ) ) $= ? $.
$}

${
    $( constraint before rewriting can be passed to the term after rewriting $)
    $( kore-one-path-reaches-plus-constraint-lemma-alt.0 $e |- ( \kore-is-predicate ph0 ph1 ) $. $)
    kore-one-path-reaches-plus-constraint-lemma.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ( \kore-and ph0 ph1 ph2 ) ph3 ) ) ) $.
    kore-one-path-reaches-plus-constraint-lemma   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph0 ph1 ph3 ) ) ) ) $= ? $.
$}

${
    $( constraint before rewriting can be passed to the term after rewriting $)
    $( kore-one-path-reaches-plus-constraint-lemma-alt.0 $e |- ( \kore-is-predicate ph0 ph1 ) $. $)
    kore-one-path-reaches-plus-constraint-lemma-alt.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph4 ( \kore-one-path-reaches-plus ph0 ( \kore-and ph0 ph1 ph2 ) ph3 ) ) ) ) $.
    kore-one-path-reaches-plus-constraint-lemma-alt   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph4 ( \kore-one-path-reaches-plus ph0 ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph0 ph1 ph3 ) ) ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-rewrites-star-intro.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-star-intro.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-star-intro.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-intro   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-rewrites-star-intro-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-star-intro-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-star-intro-alt.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-intro-alt   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-rewrites-plus-intro.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-plus-intro.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-plus-intro.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-plus-intro   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    kore-rewrites-star-transitivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-star-transitivity.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-star-transitivity.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-star-transitivity.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-star-transitivity.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-star-transitivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-rewrites-plus-transitivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-rewrites-plus-transitivity.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-rewrites-plus-transitivity.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-rewrites-plus-transitivity.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $.
    kore-rewrites-plus-transitivity.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph2 ph3 ) ) ) $.
    kore-rewrites-plus-transitivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-one-path-reaches-star-intro.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-star ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-intro   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-one-path-reaches-star-intro-alt.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-intro-alt   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-intro-alt2.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-intro-alt2   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-one-path-reaches-star-intro-alt3.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph3 ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) ) $.
    kore-one-path-reaches-star-intro-alt3   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph3 ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ) ) ) $= ? $.
$}

${
    $d X ph0 $.
    $d X ph2 $.
    kore-one-path-reaches-plus-intro.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-rewrites-plus ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-plus-intro   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-transitivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-one-path-reaches-star-transitivity.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-one-path-reaches-star-transitivity.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-one-path-reaches-star-transitivity.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-transitivity.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-star-transitivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-plus-transitivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-one-path-reaches-plus-transitivity.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-one-path-reaches-plus-transitivity.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-one-path-reaches-plus-transitivity.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-plus-transitivity.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-plus-transitivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-reflexivity.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-one-path-reaches-star-reflexivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph1 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-subsumption-lhs.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-subsumption-lhs.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-star-subsumption-lhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph3 ) ) ) $=
        $(
            apply "kore-implies-transitivity-alt"
            apply "kore-one-path-reaches-star-subsumption-lhs.0"
            apply "kore-one-path-reaches-star-subsumption-lhs.1"
        $)
        ( kore-weak-evetually-is-pattern kore-implies-is-pattern kore-one-path-reaches-star-is-pattern kore-valid-is-pattern notation-reflexivity imp-is-pattern kore-one-path-reaches-star-is-sugar notation-transitivity notation-kore-valid notation-imp notation-proof notation-symmetry kore-implies-transitivity-alt ) EAABADHIKMEAABDJKMABCADHEFEAACDJKMEAACADHIKMGEAACADHIKEAACDJKELAACADHIAACDJALACADHIACADHIACDJACADHILACDJACADHIACDNSOPQRTEAABDJKEAABADHIKELAABDJAABADHIALABDJABADHIABADHIABDNABADHILOPQR $.
$}

${
    kore-one-path-reaches-star-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-star-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-star-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-plus-subsumption-lhs.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-plus-subsumption-lhs.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-plus-subsumption-lhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph3 ) ) ) $=
        $(
            apply "kore-implies-transitivity-alt"
            apply "kore-one-path-reaches-plus-subsumption-lhs.0"
            apply "kore-one-path-reaches-plus-subsumption-lhs.1"
        $)
        ( kore-weak-evetually-is-pattern kore-next-is-pattern kore-implies-is-pattern kore-one-path-reaches-plus-is-pattern kore-valid-is-pattern notation-reflexivity imp-is-pattern kore-one-path-reaches-plus-is-sugar notation-transitivity notation-kore-valid notation-imp notation-proof notation-symmetry kore-implies-transitivity-alt ) EAABAADHIJLNEAABDKLNABCAADHIEFEAACDKLNEAACAADHIJLNGEAACAADHIJLEAACDKLEMAACAADHIJAACDKAMACAADHIJACAADHIJACDKACAADHIJMACDKACAADHIJACDOTPQRSUAEAABDKLEAABAADHIJLEMAABDKAABAADHIJAMABDKABAADHIJABAADHIJABDOABAADHIJMPQRS $.
$}

${
    kore-one-path-reaches-plus-subsumption-rhs.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-plus-subsumption-rhs.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-plus-subsumption-rhs   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ph3 ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-plus-subsumption-lhs-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-one-path-reaches-plus-subsumption-lhs-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-one-path-reaches-plus-subsumption-lhs-alt.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-one-path-reaches-plus-subsumption-lhs-alt.3 $e |- ( \imp th0 ( \in-sort ph4 ph0 ) ) $.
    kore-one-path-reaches-plus-subsumption-lhs-alt.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-one-path-reaches-plus-subsumption-lhs-alt.5 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph4 ( \kore-one-path-reaches-plus ph0 ph2 ph3 ) ) ) ) $.
    kore-one-path-reaches-plus-subsumption-lhs-alt   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph4 ( \kore-one-path-reaches-plus ph0 ph1 ph3 ) ) ) ) $=
        $(
            apply "kore-mp-alt"
            apply "kore-mp-alt"
            apply "kore-weakening-imp3"
            meh
            meh
            meh
            apply "kore-implies-transitivity-alt2"
            apply "kore-one-path-reaches-plus-subsumption-lhs-alt.0"
            meh
            apply "rule-weakening"
            sorting
            apply "kore-weakening"
            apply "kore-one-path-reaches-plus-subsumption-lhs-alt.4"
            apply "kore-one-path-reaches-plus-subsumption-lhs-alt.5"
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "weakening-imp3"
            meh
            apply "kore-one-path-reaches-plus-subsumption-lhs-alt.0"
            apply "kore-one-path-reaches-plus-subsumption-lhs-alt.1"
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "weakening-imp2"
            meh
            apply "kore-one-path-reaches-plus-subsumption-lhs-alt.1"
            apply "kore-one-path-reaches-plus-subsumption-lhs-alt.3"
            apply "kore-one-path-reaches-plus-subsumption-lhs-alt.1"
            apply "rule-curry"
            sorting
            sorting
        $)
        ( kore-implies-is-pattern in-sort-is-pattern kore-weak-evetually-is-pattern kore-next-is-pattern imp-is-pattern kore-one-path-reaches-plus-is-pattern notation-reflexivity proof-rule-mp kore-valid-is-pattern and-is-pattern rule-imp-transitivity top-is-pattern imp-reflexivity notation-kore-implies rule-and-intro-alt2-sugar kore-implies-sorting proof-rule-prop-1 kore-weak-eventually-sorting kore-next-sorting kore-one-path-reaches-plus-is-sugar notation-transitivity notation-kore-valid notation-imp notation-proof kore-mp-alt weakening-imp3 and-elim-left-sugar and-elim-right-sugar rule-curry weakening-imp2 top-intro rule-weakening kore-implies-transitivity-alt2 kore-weakening-imp3 kore-weakening notation-symmetry ) AAEACAADOPMMAEABDRMFAAEABCMMAAEACAADOPMMAEABDRMMFAABCMACAADOPMABDREFFCANQFABCMANQFBANQFCANQFABCMANQQBANCANABCMANQQFBANQFCANQFABCMANQQQBANCANABCMANFURBANCANABCMANBANCANUBBANCANUBABCMANBANCANUBBANCANBANCANUBBANBANBANCANUSBANUEUCBANCANUBCANCANBANCANUTCANUEUCUGABCUHUCVATGTHTFCANQFACAADOPMANQCANACAADOPMANQFCANQFACAADOPMANQQCANACAADOPMANFVBCANCANAADOPANUBACAADOPMANCANCANAADOPANCANUECANADOANAADOPANADOANCANADOANQADOANCANUIADUJTAADOUKUCUGACAADOPUHUCTHTJFAAABCMAACAADOPMABAADOPMMMUAQFAAABCMAACAADOPMABDRMMUAQABCAADOPFGHFAADOPANUDAADOPANUDADOANAADOPANADOANUDADOANQADOANUDUIADUJTAADOUKUCVCTVDVEFAAABCMAACAADOPMABDRMMUAFAAABCMAACAADOPMABAADOPMMMUAFSAAABCMAACAADOPMABDRMMAAABCMAACAADOPMABAADOPMMMASAABCMAACAADOPMABDRMAABCMAACAADOPMABAADOPMMASABCMSAACAADOPMABDRAACAADOPMABAADOPMASACAADOPMSABDRABAADOPMABAADOPMABDULABAADOPMSUMUFUFUNUOUPVFAEABCMFKVGUQFAAEACDRMUAQFAAEACAADOPMMUAQLFAAEACAADOPMMUAFAAEACDRMUAFSAAEACAADOPMMAAEACDRMASAEACAADOPMAEACDRASESACAADOPMACAADOPMACDRACAADOPMSACDRACAADOPMACDULVHUMUFUNUOUPUQ $.
$}

${
    kore-one-path-reaches-plus-subsumption-rhs-alt.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph4 ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) ) $.
    kore-one-path-reaches-plus-subsumption-rhs-alt.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph2 ph3 ) ) ) $.
    kore-one-path-reaches-plus-subsumption-rhs-alt   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph4 ( \kore-one-path-reaches-plus ph0 ph1 ph3 ) ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-branch.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ( \kore-or ph0 ph2 ph3 ) ) ) ) $.
    kore-one-path-reaches-star-branch.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph2 ph4 ) ) ) $.
    kore-one-path-reaches-star-branch   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph1 ( \kore-or ph0 ph4 ph3 ) ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-plus-branch.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ( \kore-or ph0 ph2 ph3 ) ) ) ) $.
    kore-one-path-reaches-plus-branch.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ph2 ph4 ) ) ) $.
    kore-one-path-reaches-plus-branch   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ph1 ( \kore-or ph0 ph4 ph3 ) ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-star-union.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ( \kore-and ph0 ph1 ph3 ) ph4 ) ) ) $.
    kore-one-path-reaches-star-union.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ( \kore-and ph0 ph2 ph3 ) ph5 ) ) ) $.
    kore-one-path-reaches-star-union   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-star ph0 ( \kore-and ph0 ( \kore-or ph0 ph1 ph2 ) ph3 ) ( \kore-or ph0 ph4 ph5 ) ) ) ) $= ? $.
$}

${
    kore-one-path-reaches-plus-union.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ( \kore-and ph0 ph1 ph3 ) ph4 ) ) ) $.
    kore-one-path-reaches-plus-union.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ( \kore-and ph0 ph2 ph3 ) ph5 ) ) ) $.
    kore-one-path-reaches-plus-union   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-one-path-reaches-plus ph0 ( \kore-and ph0 ( \kore-or ph0 ph1 ph2 ) ph3 ) ( \kore-or ph0 ph4 ph5 ) ) ) ) $= ? $.
$}

${
    kore-reachability-one-path-circularity-lemma.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-circularity ph0 ph1 ) ph1 ) ) ) $.
    kore-reachability-one-path-circularity-lemma   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-well-founded ph0 ) ph1 ) ) ) $= ? $.
$}

kore-reachability-permits-non-wf $p |- ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-implies ph0 ( \kore-well-founded ph0 ) ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ( \kore-one-path-reaches-plus ph0 ph1 ph2 ) ) ) $= ? $.

kore-always-elim $p |- ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-always ph0 ph1 ) ph1 ) ) $= ? $.

$( ${
    kore-implies-compat-in-kore-forall.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ph2 ) ) ) $.
    kore-implies-compat-in-kore-forall   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-forall ph3 ph0 x ph1 ) ( \kore-forall ph3 ph0 x ph2 ) ) ) ) $= ? $.
$} $)

$( Reachability rules $)

${
    kore-reachability-one-path-transitivity.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-circularity ph0 ph1 ) ( \kore-one-path-reaches-plus ph0 ph2 ph3 ) ) ) ) $.
    kore-reachability-one-path-transitivity.1 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-always ph0 ph1 )      ( \kore-one-path-reaches-star ph0 ph3 ph4 ) ) ) ) $.
    kore-reachability-one-path-transitivity   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-circularity ph0 ph1 ) ( \kore-one-path-reaches-plus ph0 ph2 ph4 ) ) ) ) $= ? $.
$}

${
    kore-reachability-one-path-case-star.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-reachability-one-path-case-star.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-reachability-one-path-case-star.2 $e |- ( \imp th0 ( \in-sort ph3 ph0 ) ) $.
    kore-reachability-one-path-case-star.3 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ( \kore-one-path-reaches-star ph0 ph2 ph4 ) ) ) ) $.
    kore-reachability-one-path-case-star.4 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ( \kore-one-path-reaches-star ph0 ph3 ph4 ) ) ) ) $.
    kore-reachability-one-path-case-star   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ( \kore-one-path-reaches-star ph0 ( \kore-or ph0 ph2 ph3 ) ph4 ) ) ) ) $=
        $(
            apply "kore-mp-alt"
            apply "kore-mp-alt"
            apply "kore-weakening-imp3"
            meh
            meh
            meh
            apply "kore-or-elim-alt3"
            meh
            meh
            meh
            apply "kore-reachability-one-path-case-star.3"
            apply "kore-reachability-one-path-case-star.4"
            apply "proof-rule-mp" & apply "proof-rule-mp" & apply "proof-rule-mp" & apply "proof-rule-mp" & apply "weakening-imp4" & apply "rule-curry" & apply "rule-curry" & meh & apply "kore-reachability-one-path-case-star.0" & apply "kore-reachability-one-path-case-star.1" & apply "kore-reachability-one-path-case-star.2"
            apply "proof-rule-mp" & apply "proof-rule-mp" & apply "proof-rule-mp" & apply "proof-rule-mp" & apply "weakening-imp4" & apply "rule-curry" & apply "rule-curry" & meh & apply "kore-reachability-one-path-case-star.0" & apply "kore-reachability-one-path-case-star.1" & apply "kore-reachability-one-path-case-star.2"
            apply "kore-reachability-one-path-case-star.0"
            apply "kore-reachability-one-path-case-star.1"
            apply "kore-reachability-one-path-case-star.2"
            apply "rule-weakening"
            (sorting)+
        $)
        ( in-sort-is-pattern kore-implies-is-pattern kore-weak-evetually-is-pattern imp-is-pattern and-is-pattern kore-one-path-reaches-star-is-pattern kore-or-is-pattern notation-reflexivity kore-valid-is-pattern proof-rule-mp rule-imp-transitivity rule-curry notation-kore-implies kore-weak-eventually-sorting kore-one-path-reaches-star-is-sugar notation-transitivity notation-kore-valid notation-imp notation-proof weakening-imp4 and-elim-right-sugar imp-reflexivity proof-rule-prop-1 rule-and-intro-alt2-sugar kore-implies-sorting notation-symmetry kore-mp-alt and-elim-left-sugar rule-weakening kore-or-elim-alt3 kore-weakening-imp3 ) AABADAENMMABAACDREQMFAABACAENMMAABADAENMMABAACDREQMMFAACAENMADAENMAACDREQBFFDALOFACAENMALOFCALOFDALOFACAENMALOOFBALOFCALOFDALOFACAENMALOOOBALCALDALACAENMALOOOFBALOFCALOFDALOFACAENMALOOOOBALCALDALACAENMALFUKBALCALDALACAENMALOBALCALPDALACAENMALBALCALPDALPCALAENALPACAENMALBALCALPDALPCALAENALBALCALPDALPBALCALPCALBALCALPDALUSBALCALPCALCALBALCALULCALUMUBUBAENALBALCALPDALPAENALOAENALBALCALPDALPUNAEUEUAUOACAENUPUBUCUCUAGUAHUAIUAFDALOFADAENMALOFCALOFDALOFADAENMALOOFBALOFCALOFDALOFADAENMALOOOBALCALDALADAENMALOOOFBALOFCALOFDALOFADAENMALOOOOBALCALDALADAENMALFUKBALCALDALADAENMALOBALCALPDALADAENMALBALCALPDALPDALAENALPADAENMALBALCALPDALPDALAENALBALCALPDALPDALDALBALCALPDALULDALUMUBAENALBALCALPDALPAENALOAENALBALCALPDALPUNAEUEUAUOADAENUPUBUCUCUAGUAHUAIUAGFAAACAENMAADAENMAACDRAENMMMTOFAAACAENMAADAENMAACDREQMMTOACDAENFHIFAENALAEUEUTVAFAAACAENMAADAENMAACDREQMMTFAAACAENMAADAENMAACDRAENMMMTFSAAACAENMAADAENMAACDREQMMAAACAENMAADAENMAACDRAENMMMASAACAENMAADAENMAACDREQMAACAENMAADAENMAACDRAENMMASACAENMSAADAENMAACDREQAADAENMAACDRAENMASADAENMSAACDREQAACDRAENMAACDRAENMAACDREUFAACDRAENMSUGUDUDUHUIUJVBFAABACEQMTOFAABACAENMMTOJFAABACAENMMTFAABACEQMTFSAABACAENMMAABACEQMASABACAENMABACEQASBSACAENMACAENMACEQACAENMSACEQACAENMACEUFUQUGUDUHUIUJURFAABADEQMTOFAABADAENMMTOKFAABADAENMMTFAABADEQMTFSAABADAENMMAABADEQMASABADAENMABADEQASBSADAENMADAENMADEQADAENMSADEQADAENMADEUFUQUGUDUHUIUJUR $.
$}
