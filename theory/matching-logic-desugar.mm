$( Desugaring lemmas $)

$[ theory/matching-logic-prelude-lemmas.mm $]

${
    desugar-not-to-imp.0 $e |- ( \not ph0 ) $.
    desugar-not-to-imp $p |- ( \imp ph0 \bot ) $=
        $(
            apply "notation-proof"
            apply "desugar-not-to-imp.0"
            notation
        $)
        ( bot-is-pattern imp-is-pattern not-is-pattern notation-symmetry not-is-sugar notation-reflexivity notation-transitivity notation-proof ) AEACDBAEACDAEACDACDAGACDACDACDHFIFJ $.
$}

${
    sugar-imp-to-not.0 $e |- ( \imp ph0 \bot ) $.
    sugar-imp-to-not $p |- ( \not ph0 ) $=
        $(
            desugar "\not"
            apply "sugar-imp-to-not.0"
        $)
        ( bot-is-pattern imp-is-pattern not-is-pattern not-is-sugar notation-reflexivity notation-symmetry notation-transitivity notation-proof ) ACDAEBAEACDACDAFACDACDACDGHIJ $.
$}
