$[ theory/matching-logic-prelude-lemmas.mm $]
$[ theory/matching-logic-membership.mm $]
$[ theory/matching-logic-predicate.mm $]

${
    disjointness-eq.0 $e |- ( \eq ph0 ph2 ) $.
    disjointness-eq.1 $e |- ( \eq ph1 ph3 ) $.
    disjointness-eq.2 $e |- ( \not ( \and ph2 ph3 ) ) $.
    disjointness-eq $p |- ( \not ( \and ph0 ph1 ) ) $=
        $(
            apply "proof-rule-mp"
            apply "rule-contrapositive-sugar"
            meh
            apply "disjointness-eq.2"
            apply "rule-iff-elim-left"
            apply "rule-iff-compat-in-and"
            apply "rule-eq-to-iff"
            apply "disjointness-eq.0"
            apply "rule-eq-to-iff"
            apply "disjointness-eq.1"
        $)
        ( and-is-pattern not-is-pattern rule-eq-to-iff rule-iff-compat-in-and rule-iff-elim-left rule-contrapositive-sugar proof-rule-mp ) CDHIABHIABHCDHABHCDHACBDACEJBDFJKLMGN $.
$}

${
    disjointness-simplify.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
    disjointness-simplify.1 $e |- ( \imp ph2 ph1 ) $.
    disjointness-simplify $p |- ( \not ( \and ph0 ph2 ) ) $=
        $(
            apply "proof-rule-mp"
            apply "rule-contrapositive-sugar"
            apply "rule-imp-compat-in-and"
            apply "imp-reflexivity"
            apply "disjointness-simplify.1"
            apply "disjointness-simplify.0"
        $)
        ( and-is-pattern not-is-pattern imp-reflexivity rule-imp-compat-in-and rule-contrapositive-sugar proof-rule-mp ) ABFGACFGACFABFAACBAHEIJDK $.
$}

${
    disjointness-symmetry.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
    disjointness-symmetry $p |- ( \not ( \and ph1 ph0 ) ) $=
        $(
            apply "proof-rule-mp"
            apply "rule-contrapositive-sugar"
            apply "rule-iff-elim-left"
            apply "and-commutativity"
            apply "disjointness-symmetry.0"
        $)
        ( and-is-pattern not-is-pattern and-commutativity rule-iff-elim-left rule-contrapositive-sugar proof-rule-mp ) ABDEBADEBADABDBADABDBAFGHCI $.
$}

${
    $d x ph0 $.
    disjointness-quantify.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
    disjointness-quantify $p |- ( \not ( \and ph0 ( \sorted-exists x ph2 ph1 ) ) ) $=
        $(
            desugar "\sorted-exists"
            apply "proof-rule-mp"
            apply "rule-contrapositive-sugar"
            apply "rule-imp-transitivity"
            apply "rule-iff-elim-left"
            apply "and-commutativity"
            apply "prenex-exists-and-left"
            apply "fresh-disjoint"
            apply "forall-not-to-not-exists"
            apply "lemma-forall-intro"
            apply "proof-rule-mp"
            apply "rule-contrapositive-sugar"
            meh
            apply "disjointness-quantify.0"
            apply "rule-and-intro-alt2-sugar"
            apply "and-elim-right-sugar"
            apply "rule-imp-transitivity"
            apply "and-elim-left-sugar"
            apply "and-elim-right-sugar"
        $)
        ( and-is-pattern element-var-is-var var-is-pattern in-sort-is-pattern exists-is-pattern not-is-pattern sorted-exists-is-pattern rule-imp-transitivity rule-contrapositive-sugar and-elim-right-sugar proof-rule-mp notation-reflexivity and-commutativity rule-iff-elim-left fresh-disjoint prenex-exists-and-left and-elim-left-sugar rule-and-intro-alt2-sugar lemma-forall-intro forall-not-to-not-exists sorted-exists-is-sugar notation-symmetry notation-transitivity notation-and notation-not notation-proof ) ADGHCIBFDJFKACBDLFKDGHCIBFAFDJKADGHCIBFDJFKADGHCIBFDJFDGHCIBFAFDJADGHCIBFDJFDGHCIBFDJAFDGHCIBFAFDJADGHCIBFDJFDGHCIBFDJAFADGHCIBFDJRSDGHCIBFADADGTUAMNDGHCIBFAFDDGHCIBFAFKDABFKDGHCIBFAFKDGHCIBFAFABFDGHCIBFAFABDGHCIBFAODGHCIBFAFDGHCIBFBDGHCIBFAUBDGHCIBOMUCNEPUDUEPACBDLFADGHCIBFDJFACBDLADGHCIBFDJAQCBDLDGHCIBFDJDGHCIBFDJCBDUFDGHCIBFDJDGHCIBFDJDGHCIBFDJQUGUHUIUJUK $.
$}

${
    predicate-commutes-with-context.0 $e |- ( \is-predicate ph0 ) $.
    predicate-commutes-with-context.1 $e #ApplicationContext x ph1 $.
    predicate-commutes-with-context.2 $e #Substitution ph2 ph1 ph5 x $.
    predicate-commutes-with-context.3 $e #Substitution ph3 ph1 ( \and ph0 ph5 ) x $.
    predicate-commutes-with-context.4 $e #Substitution ph4 ph1 ( \and \top ph5 ) x $. $( TODO: remove this $)
    predicate-commutes-with-context $p |- ( \imp ( \and ph0 ph2 ) ph3 ) $=
        $(
            apply "rule-case-alt"
            let $0 = "( \is-top ph0 )", $1 = "( \is-bot ph0 )"
            apply "notation-proof"
            apply "predicate-commutes-with-context.0"
            notation
            meh
            claim "|- ( \imp ( \is-bot ph0 ) ( \imp ph0 \bot ) )"
            desugar "\is-bot"
            apply "lemma-eq-imp"
            apply "rule-imp-transitivity"
            apply "claim-0"
            apply "rule-imp-transitivity"
            apply "proof-rule-mp"
            apply "imp-transitivity"
            apply "and-elim-left-sugar"
            apply "not-elim-alt"
            desugar "\is-top"
            apply "rule-imp-transitivity"
            let $24 = "( \eq ( \and \top ph5 ) ( \and ph0 ph5 ) )"
            desugar "\eq"
            apply "lemma-imp-compat-in-floor"
            desugar "\iff"
            apply "rule-and-intro-alt2-sugar"
            apply "proof-rule-mp"
            apply "lemma-curry-left"
            apply "rule-and-intro-alt2-sugar"
            apply "rule-imp-transitivity"
            apply "and-elim-left-sugar"
            apply "rule-imp-transitivity"
            apply "and-elim-right-sugar"
            apply "proof-rule-mp"
            apply "mp"
            apply "top-intro"
            apply "rule-imp-transitivity"
            apply "and-elim-right-sugar"
            apply "and-elim-right-sugar"
            apply "rule-weakening"
            apply "rule-and-intro-alt2-sugar"
            apply "rule-weakening"
            apply "top-intro"
            apply "and-elim-right-sugar"
            apply "rule-imp-transitivity"
            apply "eq-elim"
            apply "predicate-commutes-with-context.4"
            apply "predicate-commutes-with-context.3"
            apply "proof-rule-mp"
            apply "imp-transitivity"
            apply "rule-imp-transitivity"
            apply "and-elim-right-sugar"
            apply "proof-rule-frame"
            apply "predicate-commutes-with-context.1"
            apply "predicate-commutes-with-context.2"
            apply "predicate-commutes-with-context.4"
            apply "rule-and-intro-alt2-sugar"
            apply "rule-weakening"
            apply "top-intro"
            apply "imp-reflexivity"
        $)
        ( and-is-pattern top-is-pattern imp-is-pattern is-bot-is-pattern eq-is-pattern is-top-is-pattern iff-is-pattern bot-is-pattern floor-is-pattern not-is-pattern notation-symmetry notation-reflexivity notation-transitivity rule-imp-transitivity or-is-pattern notation-proof and-elim-right-sugar is-predicate-is-pattern proof-rule-mp rule-and-intro-alt2-sugar notation-imp top-intro rule-weakening or-is-sugar and-elim-left-sugar iff-is-sugar eq-is-sugar imp-transitivity is-predicate-is-sugar lemma-curry-left mp lemma-imp-compat-in-floor eq-elim element-var-is-var imp-reflexivity proof-rule-frame is-top-is-sugar lemma-eq-imp is-bot-is-sugar not-elim-alt rule-case-alt ) ARAPACMDOAUJARAPUGHARAPUGARUBAPOAUJARAPUPAUJARUBAPOAUJARAPUGARUBAPOAVAARUBAPOARAPUGARAPUGARUBAPOARAPUGARUBAPOARUBAPOARAPUPARUBAPOARUBAPOARUBAPOUDUCUEUCUCUEUCUEUHANQACMDOOARACMDOOANQNFMAFMQACMDOANSUANFMAFMSUAOANQNFMAFMQOANSNFMAFMSANONAOMNFMAFMOAFMNFMOMOANSNFMAFMSOANONAOMNFMAFMOAFMNFMOANONAOMNFMMAFMOANONAOMNFMAFMOOANONAOMNFMAFMVBANONAOMNFMMAFANONAOMNFMMANONAOMAANONAOMNFMUQANONAOMNAOAANONAOUINNAOAONAVCUNUKUFUFANONAOMNFMMNFMFANONAOMNFMUINFUIUFULUKANONAOMAFMNFMOAFMNFAFMNUNUOAFUIULUOULANSNFMAFMSANONAOMNFMAFMOAFMNFMOMANSANONAOMANONAOMANURANONAOMANONAOMANONAOMUDUCUENFMAFMSNFMAFMOAFMNFMOMNFMAFMOAFMNFMOMNFMAFMURNFMAFMOAFMNFMOMNFMAFMOAFMNFMOMNFMAFMOAFMNFMOMUDUCUEUMUHVDANQNFMAFMQANSUANFMAFMSUAANQANSUAANSUAANUSANSUAANSUAANSUAUDUCUENFMAFMQNFMAFMSUANFMAFMSUANFMAFMUSNFMAFMSUANFMAFMSUANFMAFMSUAUDUCUEUMUHNFMAFMQEDOACMDONFMAFMEDBGLKVEACMEOEDOACMDOOACMEDUTACMCEACUIBCEFNFMGVFIJLFNFFNUNUOFVGULVHUFUKUFUFARACMDOANQACMDOARANQANQAVIANQANQANQUDUCUEACMDOUDUMUHAPATOACMDOATQATOOAPATOOATVJAPATOATQATOAPATQATQAVKATQATQATQUDUCUEATOUDUMUHATOACMTOACMDOACMAOATOACMTOOACMATUTACUQUKACMDVLUFUFVM $.
$}

${
    $d y ph0 $.
    sorted-exists-propagation-converse.0 $e #ApplicationContext x ph0 $.
    sorted-exists-propagation-converse.1 $e #Substitution ph1 ph0 ph5 x $.
    sorted-exists-propagation-converse.2 $e #Substitution ph2 ph0 ( \sorted-exists y ph6 ph5 ) x $.

    $( 3 and 4 are technically not required, but is here due to meta-incompleteness $)
    sorted-exists-propagation-converse.3 $e #Substitution ph3 ph0 ( \and ( \in-sort y ph6 ) ph5 ) x $.
    sorted-exists-propagation-converse.4 $e #Substitution ph4 ph0 ( \and \top ph5 ) x $.

    sorted-exists-propagation-converse $p |- ( \imp ( \sorted-exists y ph6 ph1 ) ph2 ) $=
        $(
            desugar "\sorted-exists"
            apply "proof-rule-gen"
            meh
            apply "fresh-after-substitution"
            meh
            meh
            apply "sorted-exists-propagation-converse.2"
            meh
            apply "fresh-disjoint"
            desugar "\sorted-exists"
            apply "fresh-in-exists-shadowed"
            apply "rule-imp-transitivity"
            apply "predicate-commutes-with-context"
            desugar "\in-sort"
            desugar "\included"
            apply "lemma-floor-is-predicate"
            apply "sorted-exists-propagation-converse.0"
            apply "sorted-exists-propagation-converse.1"
            apply "sorted-exists-propagation-converse.3"
            apply "sorted-exists-propagation-converse.4"
            apply "proof-rule-frame"
            apply "sorted-exists-propagation-converse.0"
            apply "sorted-exists-propagation-converse.3"
            apply "sorted-exists-propagation-converse.2"
            desugar "\sorted-exists"
            apply "proof-rule-exists"
            apply "substitution-identity"
        $)
        y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern y-is-element-var exists-is-pattern ph2-is-pattern imp-is-pattern ph6-is-pattern ph1-is-pattern y-is-element-var sorted-exists-is-pattern ph2-is-pattern imp-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern ph2-is-pattern y-is-element-var y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern ph3-is-pattern ph2-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern ph3-is-pattern ph4-is-pattern ph5-is-pattern x-is-element-var y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern included-is-pattern is-predicate-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern is-predicate-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern imp-is-pattern floor-is-pattern is-predicate-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern included-is-pattern is-predicate-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern imp-is-pattern lemma-floor-is-predicate y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern included-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern imp-is-pattern floor-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern included-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern imp-is-pattern floor-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern imp-is-pattern floor-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern included-is-sugar y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern imp-is-pattern floor-is-pattern notation-reflexivity notation-transitivity notation-is-predicate notation-proof y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern included-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern included-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern included-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-sugar y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern inh-is-pattern included-is-pattern notation-reflexivity notation-transitivity notation-is-predicate notation-proof sorted-exists-propagation-converse.0 sorted-exists-propagation-converse.1 sorted-exists-propagation-converse.3 sorted-exists-propagation-converse.4 predicate-commutes-with-context ph0-is-pattern ph3-is-pattern ph2-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern ph6-is-pattern ph5-is-pattern y-is-element-var sorted-exists-is-pattern x-is-element-var element-var-is-var sorted-exists-propagation-converse.0 sorted-exists-propagation-converse.3 sorted-exists-propagation-converse.2 y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var exists-is-pattern imp-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern ph6-is-pattern ph5-is-pattern y-is-element-var sorted-exists-is-pattern imp-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var y-is-element-var y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var element-var-is-var substitution-identity proof-rule-exists y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern ph6-is-pattern ph5-is-pattern y-is-element-var sorted-exists-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var exists-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern notation-reflexivity ph6-is-pattern ph5-is-pattern y-is-element-var sorted-exists-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var exists-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var exists-is-pattern ph6-is-pattern ph5-is-pattern y-is-element-var sorted-exists-is-sugar y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var exists-is-pattern notation-reflexivity notation-transitivity notation-imp notation-proof proof-rule-frame rule-imp-transitivity ph0-is-pattern ph6-is-pattern ph5-is-pattern y-is-element-var sorted-exists-is-pattern ph2-is-pattern y-is-element-var element-var-is-var x-is-element-var element-var-is-var ph0-is-pattern y-is-element-var element-var-is-var fresh-disjoint y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var exists-is-pattern ph6-is-pattern ph5-is-pattern y-is-element-var sorted-exists-is-pattern y-is-element-var element-var-is-var y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph5-is-pattern and-is-pattern y-is-element-var fresh-in-exists-shadowed ph6-is-pattern ph5-is-pattern y-is-element-var sorted-exists-is-sugar notation-fresh sorted-exists-propagation-converse.2 fresh-after-substitution proof-rule-gen ph6-is-pattern ph1-is-pattern y-is-element-var sorted-exists-is-pattern ph2-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern y-is-element-var exists-is-pattern ph2-is-pattern ph6-is-pattern ph1-is-pattern y-is-element-var sorted-exists-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern y-is-element-var exists-is-pattern y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern y-is-element-var exists-is-pattern ph6-is-pattern ph1-is-pattern y-is-element-var sorted-exists-is-sugar y-is-element-var element-var-is-var var-is-pattern ph6-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern y-is-element-var exists-is-pattern notation-reflexivity notation-transitivity ph2-is-pattern notation-reflexivity notation-imp notation-proof $.
$}

${
    disjointness-case.0 $e |- ( \not ( \and ph0 ph1 ) ) $.
    disjointness-case.1 $e |- ( \not ( \and ph0 ph2 ) ) $.
    disjointness-case $p |- ( \not ( \and ph0 ( \or ph1 ph2 ) ) ) $=
        $(
            apply "proof-rule-mp"
            apply "rule-contrapositive-sugar"
            apply "rule-imp-transitivity"
            apply "rule-iff-elim-left"
            apply "and-commutativity"
            apply "rule-iff-elim-left"
            apply "and-left-distributivity"
            apply "proof-rule-mp"
            apply "rule-iff-elim-right"
            apply "de-morgan-or"
            apply "rule-and-intro-sugar"
            apply "disjointness-symmetry"
            apply "disjointness-case.0"
            apply "disjointness-symmetry"
            apply "disjointness-case.1"
        $)
        ( and-is-pattern or-is-pattern not-is-pattern rule-iff-elim-left disjointness-symmetry proof-rule-mp and-commutativity and-left-distributivity rule-imp-transitivity rule-contrapositive-sugar de-morgan-or rule-iff-elim-right rule-and-intro-sugar ) BAFCAFGHABCGFHABCGFBAFCAFGABCGFBCGAFBAFCAFGABCGFBCGAFABCGLIBCGAFBAFCAFGBCAMINOBAFHCAFHFBAFCAFGHBAFCAFGHBAFHCAFHFBAFCAFPQBAFHCAFHABDJACEJRKK $.
$}

${
    $d x ph0 $.
    sorted-exists-to-inh $p |- ( \imp ( \sorted-exists x ph0 x ) ( \inh ph0 ) ) $=
        $(
            desugar "\sorted-exists"
            apply "rule-imp-transitivity"
            meh
            apply "membership-symbol-ceil-right-aux-0"
            apply "lemma-imp-compat-in-exists"
            apply "rule-and-intro-alt2-sugar"
            apply "rule-imp-transitivity"
            apply "and-elim-left-sugar"
            apply "notation-proof"
            apply "include-imp-in"
            let $18 = "( \inh ph0 )", $19 = "x"
            notation
            apply "and-elim-right-sugar"
        $)
        ( element-var-is-var var-is-pattern inh-is-pattern and-is-pattern in-sort-is-pattern ceil-is-pattern definedness-is-symbol symbol-is-pattern app-is-pattern exists-is-pattern included-is-pattern notation-symmetry in-is-pattern notation-transitivity imp-is-pattern notation-reflexivity sorted-exists-is-pattern ceil-is-sugar notation-imp notation-proof rule-imp-transitivity and-elim-left-sugar include-imp-in in-sort-is-sugar in-is-sugar and-elim-right-sugar rule-and-intro-alt2-sugar lemma-imp-compat-in-exists membership-symbol-ceil-right-aux-0 sorted-exists-is-sugar ) BCDAGBCDFBLAEQABCDBSAEQBCDAGBCDFBLBCDAEFHBCDFBLAEBCDAGBCDFBCDAEFHBCDFBBCDAGBCDFBCDAEFHBCDBCDAGBCDFBCDAGBCDAEFHBCDAGBCDUDBCDAEMAEBOQBCDAGBCDAEFHQAEBUEBCDAGBCDAEFHBCDAEMAEBOBCDAGBCDAEMBCDAEMBCDAUFBCDAEMBCDAEMBCDAEMRNPBCDAEFHIJBCDAEFKAEBOBCDAEFTAEBOIJBCDAEFKAEBOBCDAEFHIJBCDAEFKAEBUGIJBCDAEFKBCDAEFHBCDAEFHIJBCDAEFKBCDAEFHIJBCDAEFKIJBCDAEFKBCDAEFTIJBCDAEFKIJBCDAEFKIJBCDAEFKRNPNNPNPUAUBUCBCDAGBCDUHUIUJAEBUKUCABCDBSAEBCDAGBCDFBLAEABCDBSBCDAGBCDFBLBCDAGBCDFBLABCDBULBCDAGBCDFBLBCDAGBCDFBLBCDAGBCDFBLRNPAERUAUB $.
$}

${
    $d x ph1 $.
    disjointness-sort.0 $e |- ( \not ( \and ph0 ( \inh ph1 ) ) ) $.
    disjointness-sort $p |- ( \not ( \and ph0 ( \sorted-exists x ph1 x ) ) ) $=
        $(
            apply "disjointness-simplify"
            apply "disjointness-sort.0"
            apply "sorted-exists-to-inh"
        $)
        ( inh-is-pattern element-var-is-var var-is-pattern sorted-exists-is-pattern sorted-exists-to-inh disjointness-simplify ) ABEBCFGCHDBCIJ $.
$}

${
    $d x y $.
    $d x ph0 $.
    disjointness-alt-lemma $p |- ( \imp ( \sorted-exists x ph2 ( \ceil ( \and ph0 ph1 ) ) ) ( \ceil ( \and ph0 ( \sorted-exists x ph2 ph1 ) ) ) ) $=
        $(
            apply "rule-imp-transitivity"
            let $1 = "( \ceil ( \sorted-exists x ph2 ( \and ph0 ph1 ) ) )"
            apply "sorted-exists-propagation-converse"
            let $3 = "( \ceil y )", $10 = "y", $8 = "( \and ph0 ph1 )", $6 = "( \ceil ( \and ( \in-sort x ph2 ) ( \and ph0 ph1 ) ) )", $7 = "( \ceil ( \and \top ( \and ph0 ph1 ) ) )"
            desugar "\ceil"
            apply "application-context-app-right"
            apply "application-context-var"
            substitution
            substitution
            substitution
            substitution
            apply "lemma-imp-compat-in-ceil"
            desugar "\sorted-exists"
            apply "rule-and-intro-alt2-sugar"
            apply "rule-imp-transitivity"
            apply "lemma-imp-compat-in-exists"
            apply "rule-imp-transitivity"
            apply "and-elim-right-sugar"
            apply "and-elim-left-sugar"
            apply "proof-rule-gen"
            apply "imp-reflexivity"
            apply "fresh-disjoint"
            apply "lemma-imp-compat-in-exists"
            apply "rule-and-intro-alt2-sugar"
            apply "and-elim-left-sugar"
            apply "rule-imp-transitivity"
            apply "and-elim-right-sugar"
            apply "and-elim-right-sugar"
        $)
        ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern ceil-is-pattern x-is-element-var sorted-exists-is-pattern ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern x-is-element-var sorted-exists-is-pattern ceil-is-pattern ph0-is-pattern ph2-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-pattern and-is-pattern ceil-is-pattern y-is-element-var element-var-is-var var-is-pattern ceil-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern ceil-is-pattern ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern x-is-element-var sorted-exists-is-pattern ceil-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern ceil-is-pattern top-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern ceil-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern y-is-element-var x-is-element-var ph2-is-pattern definedness-is-symbol symbol-is-pattern y-is-element-var element-var-is-var var-is-pattern app-is-pattern y-is-element-var element-var-is-var var-is-pattern ceil-is-pattern y-is-element-var element-var-is-var definedness-is-symbol symbol-is-pattern y-is-element-var element-var-is-var var-is-pattern y-is-element-var element-var-is-var y-is-element-var element-var-is-var application-context-var application-context-app-right y-is-element-var element-var-is-var var-is-pattern ceil-is-pattern definedness-is-symbol symbol-is-pattern y-is-element-var element-var-is-var var-is-pattern app-is-pattern definedness-is-symbol symbol-is-pattern y-is-element-var element-var-is-var var-is-pattern app-is-pattern y-is-element-var element-var-is-var var-is-pattern ceil-is-sugar definedness-is-symbol symbol-is-pattern y-is-element-var element-var-is-var var-is-pattern app-is-pattern notation-reflexivity notation-transitivity notation-application-context ph0-is-pattern ph1-is-pattern and-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern y-is-element-var element-var-is-var var-is-pattern y-is-element-var element-var-is-var ph0-is-pattern ph1-is-pattern and-is-pattern y-is-element-var element-var-is-var substitution-var-same substitution-ceil ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern x-is-element-var sorted-exists-is-pattern ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern x-is-element-var sorted-exists-is-pattern y-is-element-var element-var-is-var var-is-pattern y-is-element-var element-var-is-var ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern x-is-element-var sorted-exists-is-pattern y-is-element-var element-var-is-var substitution-var-same substitution-ceil x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern y-is-element-var element-var-is-var var-is-pattern y-is-element-var element-var-is-var x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern y-is-element-var element-var-is-var substitution-var-same substitution-ceil top-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern top-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern y-is-element-var element-var-is-var var-is-pattern y-is-element-var element-var-is-var top-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern y-is-element-var element-var-is-var substitution-var-same substitution-ceil sorted-exists-propagation-converse ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern x-is-element-var sorted-exists-is-pattern ph0-is-pattern ph2-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var exists-is-pattern and-is-pattern imp-is-pattern ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern x-is-element-var sorted-exists-is-pattern ph0-is-pattern ph2-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-pattern and-is-pattern imp-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph0-is-pattern x-is-element-var exists-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern ph0-is-pattern x-is-element-var x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-elim-right-sugar ph0-is-pattern ph1-is-pattern and-elim-left-sugar rule-imp-transitivity lemma-imp-compat-in-exists ph0-is-pattern ph0-is-pattern x-is-element-var ph0-is-pattern imp-reflexivity ph0-is-pattern x-is-element-var element-var-is-var fresh-disjoint proof-rule-gen rule-imp-transitivity x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph1-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-elim-left-sugar x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern ph1-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-elim-right-sugar ph0-is-pattern ph1-is-pattern and-elim-right-sugar rule-imp-transitivity rule-and-intro-alt2-sugar lemma-imp-compat-in-exists rule-and-intro-alt2-sugar ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern x-is-element-var sorted-exists-is-pattern ph0-is-pattern ph2-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-pattern and-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var exists-is-pattern and-is-pattern ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern x-is-element-var sorted-exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern x-is-element-var exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph2-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern x-is-element-var sorted-exists-is-sugar x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph0-is-pattern ph1-is-pattern and-is-pattern and-is-pattern x-is-element-var exists-is-pattern notation-reflexivity notation-transitivity ph0-is-pattern ph2-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-pattern ph0-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph0-is-pattern notation-reflexivity ph2-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var exists-is-pattern x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var exists-is-pattern ph2-is-pattern ph1-is-pattern x-is-element-var sorted-exists-is-sugar x-is-element-var element-var-is-var var-is-pattern ph2-is-pattern in-sort-is-pattern ph1-is-pattern and-is-pattern x-is-element-var exists-is-pattern notation-reflexivity notation-transitivity notation-and notation-imp notation-proof lemma-imp-compat-in-ceil rule-imp-transitivity $.
$}

${
    $d x ph0 $.
    disjointness-alt.0 $e |- ( \not ( \and ph0 ( \sorted-exists x ph2 ph1 ) ) ) $.
    disjointness-alt $p |- ( \not ( \sorted-exists x ph2 ( \ceil ( \and ph0 ph1 ) ) ) ) $=
        $(
            apply "proof-rule-mp"
            apply "rule-contrapositive-sugar"
            apply "disjointness-alt-lemma"
            apply "lemma-not-ceil-elim"
            apply "disjointness-alt.0"
        $)
        ( sorted-exists-is-pattern and-is-pattern ceil-is-pattern not-is-pattern disjointness-alt-lemma rule-contrapositive-sugar lemma-not-ceil-elim proof-rule-mp ) ACBDFGHICABGHDFICABGHDFACBDFGHABCDJKACBDFGELM $.
$}

${
    disjointness-in-sort.0 $e |- ( \in-sort ph0 ph2 ) $.
    disjointness-in-sort.1 $e |- ( \not ( \and ( \inh ph2 ) ph1 ) ) $.
    disjointness-in-sort $p |- ( \not ( \and ph0 ph1 ) ) $=
        $(
            apply "proof-rule-mp"
            apply "rule-contrapositive-sugar"
            apply "rule-and-intro-alt2-sugar"
            apply "rule-imp-transitivity"
            apply "and-elim-left-sugar"
            apply "lemma-floor-elim"
            let $5 = "( \inh ph2 )"
            apply "notation-proof"
            apply "disjointness-in-sort.0"
            notation
            apply "and-elim-right-sugar"
            apply "disjointness-in-sort.1"
        $)
        ( imp-is-pattern inh-is-pattern not-is-pattern ceil-is-pattern bot-is-pattern notation-symmetry and-is-pattern floor-is-pattern notation-transitivity included-is-pattern in-sort-is-pattern floor-is-sugar not-is-sugar and-elim-left-sugar in-sort-is-sugar included-is-sugar notation-reflexivity notation-proof lemma-floor-elim rule-imp-transitivity and-elim-right-sugar rule-and-intro-alt2-sugar rule-contrapositive-sugar proof-rule-mp ) CGBLHABLHABLCGBLABLCGBABLACGABSACGFACPACGFMDACGFMACGFHIHACPACGFQACPACGFHIHACPACGOACGFHIHACTACGFHIHACGOACGFHIHACGFHIJFACGOACGFHIRACGOACGFHIJFACGOACGFMACGFHIJFACGUAACGFHIJFACGFMACGFMACGFHIJFACGFMACGFHIHACGFHIJFACGFQACGFHIJFACGFHIHACGFHIHACGFHIJFACGFHIHACGFHIJFACGFHIJFACGFHIRACGFHIJFACGFHIJFACGFHIJFUBKNKKNKKNKNKNKNUCUDUEABUFUGUHEUI $.
$}
