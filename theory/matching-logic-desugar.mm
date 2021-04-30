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
        ph0-is-pattern not-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern desugar-not-to-imp.0 ph0-is-pattern not-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern not-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern not-is-sugar ph0-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern notation-reflexivity notation-symmetry notation-transitivity notation-symmetry notation-proof $.
$}

${
    sugar-imp-to-not.0 $e |- ( \imp ph0 \bot ) $.
    sugar-imp-to-not $p |- ( \not ph0 ) $=
        $(
            desugar "\not"
            apply "sugar-imp-to-not.0"
        $)
        ph0-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern not-is-pattern sugar-imp-to-not.0 ph0-is-pattern not-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern not-is-sugar ph0-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern ph0-is-pattern bot-is-pattern imp-is-pattern notation-reflexivity notation-symmetry notation-transitivity notation-proof $.
$}
