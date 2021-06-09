$[ theory/kore.mm $]
$[ theory/kore-substitution.mm $]
$[ theory/kore-propositional.mm $]
$[ theory/kore-semantics.mm $]
$[ theory/kore-sorting.mm $]
$[ theory/kore-notation.mm $]
$[ theory/matching-logic-membership.mm $]
$[ theory/matching-logic-disjointness.mm $]

${
    kore-equals-symmetry.0 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-equals ph1 ph0 ph3 ph2 ) ) ) $.
    kore-equals-symmetry   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-equals ph1 ph0 ph2 ph3 ) ) ) $=
        $(
            apply "weakened-mp"
            meh
            apply "kore-equals-symmetry.0"
            apply "rule-weakening"
            apply "proof-rule-mp"
            apply "eq-transitivity"
            apply "lemma-floor-intro"
            apply "rule-iff-compat-in-not"
            apply "rule-iff-compat-in-or"
            apply "rule-iff-compat-in-not"
            apply "rule-iff-compat-in-not"
            apply "rule-iff-compat-in-and"
            apply "rule-iff-compat-in-ceil"
            apply "rule-iff-compat-in-and"
            apply "rule-iff-compat-in-not"
            apply "and-commutativity"
            apply "iff-reflexivity"
            apply "iff-reflexivity"
            apply "iff-reflexivity"
        $)
        ( kore-iff-is-pattern not-is-pattern kore-equals-is-pattern kore-not-is-pattern kore-top-is-pattern kore-ceil-is-pattern and-is-pattern kore-implies-is-pattern eq-is-pattern notation-transitivity kore-valid-is-pattern or-is-pattern iff-is-pattern notation-reflexivity ceil-is-pattern imp-is-pattern notation-proof floor-is-pattern notation-iff rule-iff-compat-in-not kore-not-is-sugar iff-reflexivity kore-valid-is-sugar notation-imp kore-and-is-pattern kore-iff-is-sugar kore-and-is-sugar rule-iff-compat-in-and kore-ceil-is-sugar kore-floor-is-pattern kore-equals-is-sugar kore-floor-is-sugar and-is-sugar eq-transitivity and-commutativity rule-iff-compat-in-ceil rule-iff-compat-in-or lemma-floor-intro eq-is-sugar proof-rule-mp rule-weakening weakened-mp ) EABADCIQABACDIQEABADCIQABACDIQUBBACDIBADCIOABADCIQABACDIQUBBACDIBADCIOBADCIAKOBACDIAKOUBUBBACDIBADCIOABADCIQABACDIQUBUBBACDIBADCIAKUTBACDIBADCIOABADCIQABACDIQUBBACDIBADCIOBADCIAKOBACDIAKOUBBACDIBADCIOTABADCIQABACDIQBADCIAKOBACDIAKOABADCIQBADCIAKOBADCIAKOABADCIUIBADCIAKOTPABACDIQBACDIAKOBACDIAKOABACDIUIBACDIAKOTPUJUJUCBACDIBADCISUDBACDIBADCIOBACDIBADCISBABBCDGJLHHAKHRHBABBDCGJLHHAKHRHSBACDIBADCISBABBCDGJLHHAKHRBABBDCGJLHHAKHRBABBCDGJLHHBABBDCGJLHHAKHAKHBABBCDGJLHBABBDCGJLHBABBCDGJLBABBDCGJLBBCDGJUAAKMBBDCGJUAAKMSBABBCDGJLBABBDCGJLSBBCDGJUABBDCGJUAAKAKBBCDGJBBDCGJBCDGHBKMBDCGHBKMSBBCDGJBBDCGJSBCDGHBDCGHBKBKBCDGBDCGBCDNBDCNMBDCNBCDNMSBCDGBDCGSBCDNBDCNVABCDGBDCGBCDNBDCNMBDCNBCDNMBCDGBCDNBDCNMBCDNBDCNMBCDGBBCDNBDCNUKBCDNBDCNMBCDULBBCDNBDCNUMPBCDNBDCNMTPBDCGBDCNBCDNMBDCNBCDNMBDCGBBDCNBCDNUKBDCNBCDNMBDCULBBDCNBCDNUMPBDCNBCDNMTPUEUCUFBKUHUNBBCDGJBBDCGJBCDGHBKMBDCGHBKMBBCDGJBCDGHBKMBCDGHBKMBBCDGUGBCDGHBKMTPBBDCGJBDCGHBKMBDCGHBKMBBDCGUGBDCGHBKMTPUEUCVBAKUHUNBABBCDGJLBABBDCGJLBBCDGJUAAKMBBDCGJUAAKMBABBCDGJLBBCDGJUAAKMBBCDGJUAAKMBABBCDGJUOBBCDGJUAAKMTPBABBDCGJLBBDCGJUAAKMBBDCGJUAAKMBABBDCGJUOBBDCGJUAAKMTPUEUCUFUFAKHUHVCUFBACDIBADCIBABBCDGJLHHAKHRHBABBDCGJLHHAKHRHBACDIBABBCDGJLHHAKHRHBABBCDGJLHHAKHRHBACDIBABBCDGJLHAKMBABBCDGJLHHAKHRHBACDIABABBCDGJLJBABBCDGJLHAKMBACDIBABCDGUPABABBCDGJLJBACDUQBABCDGURPABABBCDGJLUGPBABBCDGJLHAKUSPBABBCDGJLHHAKHRHTPBADCIBABBDCGJLHHAKHRHBABBDCGJLHHAKHRHBADCIBABBDCGJLHAKMBABBDCGJLHHAKHRHBADCIABABBDCGJLJBABBDCGJLHAKMBADCIBABDCGUPABABBDCGJLJBADCUQBABDCGURPABABBDCGJLUGPBABBDCGJLHAKUSPBABBDCGJLHHAKHRHTPUEUCVDBACDIBADCIOBACDIBADCISUDBACDIBADCISUDBACDIBADCIVEBACDIBADCISUDTPUCVFVGFVH $.
$}

${
    kore-in-reflexivity.0 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-in-reflexivity   $p |- ( \imp th0 ( \kore-valid ph1 ( \kore-in ph0 ph1 ph2 ph2 ) ) ) $= ? $.
$}

${
    sorted-forall-propagate-floor $p |- ( \imp ( \sorted-forall x ph0 ( \floor ph1 ) ) ( \floor ( \sorted-forall x ph0 ph1 ) ) ) $=
        $(
            apply "rule-imp-transitivity"
            apply "lemma-imp-compat-in-forall"
            apply "predicate-imp-propagate-in-floor"
            apply "lemma-floor-is-predicate"
            apply "floor-propagation-forall-left"
        $)
        ( element-var-is-var var-is-pattern imp-is-pattern floor-is-pattern in-sort-is-pattern forall-is-pattern sorted-forall-is-pattern inh-is-pattern notation-reflexivity notation-transitivity notation-proof is-predicate-is-pattern sorted-forall-is-sugar notation-imp lemma-floor-is-predicate included-is-pattern in-sort-is-sugar included-is-sugar notation-is-predicate predicate-imp-propagate-in-floor lemma-imp-compat-in-forall floor-propagation-forall-left notation-floor rule-imp-transitivity ) ABGCJCDEAHBFGCIABCJGCDEAHBGFCICDEAHBFGCIFABGCJCDEAHBFGCIFCDEAHBGFCDEAHBFGCCDEAHBCDEAKFGOCDEAHOCDEAKFRCDEAHCDEAKFGCDEAHCDEAKFGCDEAKFGCDEAHCDEAKSCDEAKFGCDEATCDEAKUAMCDEAKFGLMUBNUCUDABGCJCDEAHBFGCICDEAHBGFCICDEAHBFGCIABGCJCDEAHBGFCICDEAHBGFCIABGCPCDEAHBGFCILMCDEAHBFGCILQNCDEAHBFGCICDEAHBFCIGFCDEAHBFGCIABCJGFCDEAHBFCUECDEAHBFGCIABCJGCDEAHBFGCICDEAHBFCIGCDEAHBFGCILABCJCDEAHBFCIABCJCDEAHBFCICDEAHBFCIABCPCDEAHBFCILMUFQNUG $.
$}

${
    $d x ph2 $.
    kore-forall-intro-lemma $p |- ( \imp ( \sorted-forall x ph0 ( \eq ph1 ph2 ) ) ( \eq ( \and ( \sorted-forall x ph0 ph1 ) ph2 ) ph2 ) ) $=
        $(
            apply "rule-imp-transitivity"
            apply "sorted-forall-propagate-floor"
            apply "lemma-imp-compat-in-floor"
            apply "rule-imp-transitivity"
            apply "lemma-imp-compat-in-forall"
            apply "predicate-imp-propagate-in-iff"
            apply "lemma-floor-is-predicate"
            apply "rule-imp-transitivity"
            apply "prenex-forall-iff-left"
            apply "fresh-disjoint"
            apply "proof-rule-mp"
            apply "iff-transitivity"
            apply "rule-and-intro"
            apply "prenex-forall-and-left"
            apply "fresh-disjoint"
            apply "rule-and-intro-alt2-sugar"
            apply "lemma-imp-compat-in-forall"
            apply "and-elim-left"
            apply "proof-rule-mp"
            apply "forall-intro-alt"
            apply "and-elim-right"
        $)
        ( imp-is-pattern element-var-is-var var-is-pattern in-sort-is-pattern and-is-pattern bot-is-pattern sorted-forall-is-pattern forall-is-pattern not-is-pattern iff-is-pattern floor-is-pattern notation-reflexivity notation-transitivity or-is-pattern notation-imp not-is-sugar eq-is-pattern notation-proof inh-is-pattern sorted-forall-is-sugar and-is-sugar or-is-sugar rule-imp-transitivity eq-is-sugar is-predicate-is-pattern lemma-imp-compat-in-forall fresh-disjoint proof-rule-mp sorted-forall-propagate-floor notation-sorted-forall lemma-floor-is-predicate included-is-pattern in-sort-is-sugar included-is-sugar notation-is-predicate predicate-imp-propagate-in-iff prenex-forall-iff-left iff-transitivity prenex-forall-and-left notation-and and-elim-left forall-intro-alt and-elim-right rule-and-intro-alt2-sugar rule-and-intro iff-is-sugar lemma-imp-compat-in-floor ) ABCUADKABCNDKOABDKCICUAABCNODKABCNDKOEABCUADKABCNDKOEABCNDUMABCUADKABCNDKOABCNODKABCNDKOABCUAABCNODAPBCUABCNOBCNOBCUHBCNOPQUNABCNDKOPSUBABCNDKOABDKCICNOEABCNDKOABDKCICUAEABCNDKABDKCICNABCNDKDFGAHBECICNDLABDKCICNDFGAHBCNEDLDFGAHBECICNDLEABCNDKDFGAHBECICNDLEDFGAHBCNEDFGAHBECICNDDFGAHBCDFGAUCEOUIDFGAHUIDFGAUCEUODFGAHDFGAUCEODFGAHDFGAUCEODFGAUCEODFGAHDFGAUCUPDFGAUCEODFGAUQDFGAUCURQDFGAUCEOPQUSUBUTUJABCNDKDFGAHBECICNDLDFGAHBCNEDLDFGAHBECICNDLABCNDKDFGAHBCNEDLDFGAHBCNEDLABCNDUDDFGAHBCNEDLPQDFGAHBECICNDLPSUBDFGAHBECICNDLDFGAHBECIDLCNABDKCICNDFGAHBECICDCDFUKVAABDKCIDFGAHBECIDLNDFGAHBECIDLCNABDKCICNEABDKCIDFGAHBECIDLCVBABDKCIDFGAHBECIDLEJEJEDFGAHBECIDLABDKCIEJEEJEABDKCIDFGAHBECIDLNABDKCIDFGAHBECIDLEDFGAHBECIDLABDKCIEDFGAHBEDLCIDFGAHBECIDLEABDKCIDFGAHBECIDLEDFGAHBECDCDFUKVCABDKCIDFGAHBECIDLDFGAHBEDLCIDFGAHBECIDLABDKCDFGAHBEDLCABDKDFGAHBEDLDFGAHBEDLABDUDDFGAHBEDLPQCPVDDFGAHBECIDLPSUBDFGAHBECIDLABDKCDFGAHBECIDLDFGAHBEDLEDFGAHBECIDLABDKEDFGAHBECIDFGAHBEDDFGAHBEJEJECJEEJEDFGAHBEEDFGAHBECIDFGAHBEEDFGAHBECVEDFGAHBECIDFGAHBEDFGAHBEJEJECJEEJEDFGAHBEDFGAHBECIDFGAHBEMCMRJEDFGAHBEJEJECJEEJEDFGAHBECIDFGAHBEMCMRMDFGAHBEMCMRJEDFGAHBECUEDFGAHBEMCMRTQDFGAHBEMCMRJDFGAHBEJEJECJEEJDFGAHBEMCMRDFGAHBEMMCMEDFGAHBEJEJECJEEDFGAHBEMCMUFDFGAHBEMMCMDFGAHBEJEJECJEDFGAHBEMMDFGAHBEMJEDFGAHBEJEJEDFGAHBEMTDFGAHBEMJDFGAHBEJEJDFGAHBEMDFGAHBEJEDFGAHBEJEDFGAHBETDFGAHBEJEPQJPSQCMCJECJECTCJEPQSQJPSQDFGAHBEPSUBUJDFGAHBECIDLABDKDFGAHBECIDLDFGAHBEDLDFGAHBECIDLPABDUDSUBDFGAHBECICEDFGAHBECIDLCEDFGAHBECICDVFDFGAHBEJEJECJEEJECEDFGAHBECICEDFGAHBECVGDFGAHBECICDFGAHBEJEJECJEEJECDFGAHBECIDFGAHBEMCMRJEDFGAHBEJEJECJEEJEDFGAHBECIDFGAHBEMCMRMDFGAHBEMCMRJEDFGAHBECUEDFGAHBEMCMRTQDFGAHBEMCMRJDFGAHBEJEJECJEEJDFGAHBEMCMRDFGAHBEMMCMEDFGAHBEJEJECJEEDFGAHBEMCMUFDFGAHBEMMCMDFGAHBEJEJECJEDFGAHBEMMDFGAHBEMJEDFGAHBEJEJEDFGAHBEMTDFGAHBEMJDFGAHBEJEJDFGAHBEMDFGAHBEJEDFGAHBEJEDFGAHBETDFGAHBEJEPQJPSQCMCJECJECTCJEPQSQJPSQCPSUBULVHVIABDKCIDFGAHBECIDLNABDKCIDFGAHBECIDLEMDFGAHBECIDLABDKCIEMRJEABDKCIDFGAHBECIDLEJEJEDFGAHBECIDLABDKCIEJEEJEABDKCIDFGAHBECIDLNABDKCIDFGAHBECIDLEMDFGAHBECIDLABDKCIEMRMABDKCIDFGAHBECIDLEMDFGAHBECIDLABDKCIEMRJEABDKCIDFGAHBECIDLNABDKCIDFGAHBECIDLEDFGAHBECIDLABDKCIEIABDKCIDFGAHBECIDLEMDFGAHBECIDLABDKCIEMRMABDKCIDFGAHBECIDLVJABDKCIDFGAHBECIDLEDFGAHBECIDLABDKCIEUEQABDKCIDFGAHBECIDLEMDFGAHBECIDLABDKCIEMRTQABDKCIDFGAHBECIDLEMDFGAHBECIDLABDKCIEMRJABDKCIDFGAHBECIDLEJEJEDFGAHBECIDLABDKCIEJEEJABDKCIDFGAHBECIDLEMDFGAHBECIDLABDKCIEMRABDKCIDFGAHBECIDLEMMDFGAHBECIDLABDKCIEMEABDKCIDFGAHBECIDLEJEJEDFGAHBECIDLABDKCIEJEEABDKCIDFGAHBECIDLEMDFGAHBECIDLABDKCIEMUFABDKCIDFGAHBECIDLEMMDFGAHBECIDLABDKCIEMABDKCIDFGAHBECIDLEJEJEDFGAHBECIDLABDKCIEJEABDKCIDFGAHBECIDLEMMABDKCIDFGAHBECIDLEMJEABDKCIDFGAHBECIDLEJEJEABDKCIDFGAHBECIDLEMTABDKCIDFGAHBECIDLEMJABDKCIDFGAHBECIDLEJEJABDKCIDFGAHBECIDLEMABDKCIDFGAHBECIDLEJEABDKCIDFGAHBECIDLEJEABDKCIDFGAHBECIDLETABDKCIDFGAHBECIDLEJEPQJPSQDFGAHBECIDLABDKCIEMDFGAHBECIDLABDKCIEJEDFGAHBECIDLABDKCIEJEDFGAHBECIDLABDKCIETDFGAHBECIDLABDKCIEJEPQSQJPSQUBULUGUGVKABCNDKOABDKCICUAABCNDKOABDKCICNOABCNDKOPABDKCICUAABDKCICNOABDKCICNOABDKCICUHABDKCICNOPQSUBUG $.
$}

${
    $d x th0 $.
    $d x ph0 $.
    kore-forall-intro.0 $e |- ( \sorted-forall x ph2 ( \imp th0 ( \kore-valid ph0 ph1 ) ) ) $.
    kore-forall-intro   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-forall ph2 ph0 x ph1 ) ) ) $=
        $(
            apply "rule-imp-transitivity"
            meh
            apply "proof-rule-mp"
            apply "eq-transitivity"
            apply "kore-semantics-forall"
            apply "fresh-disjoint"
            apply "rule-imp-transitivity"
            meh
            apply "kore-forall-intro-lemma"
            apply "proof-rule-mp"
            apply "rule-iff-elim-left"
            apply "lemma-prenex-forall-imp-right"
            apply "fresh-disjoint"
            apply "proof-rule-mp"
            apply "lemma-imp-compat-in-forall"
            apply "premises-switch-alt"
            apply "kore-forall-intro.0"
        $)
        ( kore-top-is-pattern eq-is-pattern imp-is-pattern sorted-forall-is-pattern element-var-is-var var-is-pattern in-sort-is-pattern inh-is-pattern and-is-pattern kore-forall-is-pattern forall-is-pattern kore-valid-is-pattern notation-reflexivity notation-imp notation-transitivity notation-proof notation-symmetry proof-rule-mp iff-is-pattern fresh-disjoint sorted-forall-is-sugar kore-valid-is-sugar rule-imp-transitivity lemma-prenex-forall-imp-right notation-iff rule-iff-elim-left premises-switch-alt lemma-imp-compat-in-forall notation-forall kore-forall-intro-lemma kore-top-is-sugar notation-and notation-eq eq-transitivity kore-semantics-forall ) DCBEJANOAGHACABEPRDCBAGHEJCBEJANOAGHDEKLCMBAGHIIEQDCBAGHEJIDEKLCMBAGHIIEQDCBAGHEJIDEKLCMBAGHIIEQDEKLCMBAGHIEQIUEDEKLCMBAGHIIEQDCBAGHEJIUEDEKLCMBAGHIEDEKUFUJDEKLCMBAGHIIEQDCBAGHEJIDEKLCMBAGHIIEQDEKLCMBAGHIEQIDEKLCMBAGHIIEQSDCBAGHEJDEKLCMBAGHIEQDSCBAGHEJEKLCMBAGHIEQEKLCMBAGHIEQCBAGHEUGEKLCMBAGHIEQSUATUKUBULEKLCMDBAGHIIEQDEKLCMBAGHIIEQEKLCMDBAGHIIDEKLCMBAGHIIEEKLCMDBAGHUMUNCDABRIEJEKLCMDBAGHIIEQFEKLCMDBAGHIIEQEKLCMDABRIIEQCDABRIEJEKLCMDBAGHIIEKLCMDABRIIEEKLCMDBAGHIEKLCMDABRIEKLCMSDBAGHDABRDSBAGHBAGHABRBAGHSABRBAGHABUHUCUATTUOCDABRIEJEKLCMDABRIIEQCDABRIEUGUCUAUBUDUDCBAGHEJCBEJAGOAGHICBAGHEJCBEJANOAGHICBAGEUPCBAGHEJCBEJANOAGHCBAGHEJCBEJAGOAGHCBAGHEJSCBEJANOAGCBEJAGOAGCBEJANCBEJAGCBEJSANANAGANSAGANAUQUCUAURAGSUSTUBUICABEPCBEJANOHCBEJANOAGHACABEPRICABEPCBEJANOHCBEJANOAGHCABEPAGHIICABEPCBEJANOHCBEJANOAGHACABEPRIICABEPCBEJANOAGUTCABEPCBEJANOHCBEJANOAGHACABEPRICABEPCBEJANOHCBEJANOAGHCABEPAGHICABEPCBEJANOHSCBEJANOAGHACABEPRCBEJANOAGHCABEPAGHCBEJANOAGHSACABEPRCABEPAGHCABEPAGHACABEPUHCABEPAGHSUATTUBCABEAEKUFVAUDUI $.
$}

${
    $d x th0 $.
    $d x ph0 $.
    kore-forall-intro-alt.0 $e |- ( \imp ( \and ( \in-sort x ph2 ) th0 ) ( \kore-valid ph0 ph1 ) ) $.
    kore-forall-intro-alt   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-forall ph2 ph0 x ph1 ) ) ) $=
        $(
            from "kore-forall-intro-alt.0", "rule-curry"
            from "hyp-0", "lemma-forall-intro"
            apply "kore-forall-intro"
            apply "hyp-1"
        $)
        ( imp-is-pattern kore-valid-is-pattern element-var-is-var var-is-pattern in-sort-is-pattern forall-is-pattern sorted-forall-is-pattern rule-curry lemma-forall-intro sorted-forall-is-sugar notation-reflexivity notation-transitivity notation-proof kore-forall-intro ) ABCDEEIJCKDABHGGELCDABHGEMEIJCKDABHGGEEIJCKDABHFNOCDABHGEMEIJCKDABHGGELEIJCKDABHGGELCDABHGEPEIJCKDABHGGELQRST $.
$}

$( ${
    kore-equality-in-constraint.0 $e #Substitution ph6 ph5 ph3 x $.
    kore-equality-in-constraint.1 $e #Substitution ph7 ph5 ph4 x $.
    kore-equality-in-constraint   $p
        |- ( \imp th0 ( \kore-valid ph0 ( \kore-iff ph0
            ( \kore-and ph0 ( \kore-and ph0 ph8 ( \kore-equals ph2 ph0 ph3 ph4 ) ) ph6 )
            ( \kore-and ph0 ( \kore-and ph0 ph8 ( \kore-equals ph2 ph0 ph3 ph4 ) ) ph7 ) ) ) ) $= ? $.
$} $)

${
    kore-equality-in-constraint.0 $e #Substitution ph2 ph4 ph5 x $.
    kore-equality-in-constraint.1 $e #Substitution ph3 ph4 ph6 x $.
    kore-equality-in-constraint.2 $e |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ph1 ( \kore-equals ph7 ph0 ph5 ph6 ) ) ) ) $.
    kore-equality-in-constraint   $p |- ( \imp th0 ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-and ph0 ph1 ph2 ) ( \kore-and ph0 ph1 ph3 ) ) ) ) $= ? $.
$}

unit-sort-is-kore-sort $p |- ( \kore-is-sort \unit-sort ) $=
    $(
        apply "notation-proof"
        apply "unit-sort-is-sort"
        let $2 = "x"
        apply "kore-is-sort-is-sugar"
    $)
    ( x-is-element-var unit-sort-is-symbol symbol-is-pattern element-var-is-var var-is-pattern eq-is-pattern exists-sort-is-pattern kore-is-sort-is-pattern unit-sort-is-sort kore-is-sort-is-sugar notation-proof ) ADEBCFAGBCHAIBCAJK $.

unit-sort-is-functional $p |- ( \exists x ( \eq x \unit-sort ) ) $=
    $(
        apply "proof-rule-mp"
        apply "lemma-imp-compat-in-exists"
        apply "and-elim-right"
        apply "unit-sort-is-sort"
    $)
    ( symbol-is-pattern imp-is-pattern element-var-is-var var-is-pattern bot-is-pattern sort-is-symbol unit-sort-is-symbol eq-is-pattern in-sort-is-pattern not-is-pattern notation-symmetry exists-is-pattern or-is-pattern notation-transitivity and-is-pattern sorted-exists-is-pattern not-is-sugar notation-reflexivity exists-sort-is-pattern notation-imp and-elim-right lemma-imp-compat-in-exists unit-sort-is-sort exists-sort-is-sugar sorted-exists-is-sugar and-is-sugar or-is-sugar notation-exists notation-proof proof-rule-mp ) ADEGBJFCFCADEHBIFCCFCAMADEHBIAMADEGBJFCFCADEHBIFCCFCADEHBIAADEGBJADEHBIUBUCADEHBIATADEGBJFCFCADEHBIFCCFCAMAUDADEHBIATADEGBJFCFCADEHBIFCCFCAMADEHBIATGBADEHBIAQADEGBJFCFCADEHBIFCCFCAMADEHBIAUEADEGBJFCFCADEHBIFCCFCAMGBADEHBIAQGBADEHBIAQADEGBJFCFCADEHBIFCCFCAMGBADEHBIAQADEGBJADEHBIPAMADEGBJFCFCADEHBIFCCFCAMGBADEHBIAUFADEGBJFCFCADEHBIFCCFCAMADEGBJADEHBIPAMADEGBJFCFCADEHBIFCCFCADEGBJADEHBIPAADEGBJADEHBIPADEGBJFCFCADEHBIFCCFCADEGBJADEHBIPADEGBJKADEHBIKNKADEGBJFCFCADEHBIFCCFCADEGBJADEHBIUGADEGBJFCFCADEHBIFCCFCADEGBJKADEHBIKNKADEGBJKADEHBIKNKADEGBJFCFCADEHBIFCCFCADEGBJKADEHBIKNKADEGBJKADEHBIKNFCADEGBJFCFCADEHBIFCCFCADEGBJKADEHBIKNRADEGBJFCFCADEHBIFCCFCADEGBJKADEHBIKNFCADEGBJFCFCADEHBIFCCFADEGBJKADEHBIKNFADEGBJKADEHBIKNADEGBJFCFCADEHBIFCCADEGBJKADEHBIKNADEGBJKKADEHBIKCADEGBJFCFCADEHBIFCCADEGBJKADEHBIKUHADEGBJFCFCADEHBIFCCADEGBJKKADEHBIKCADEGBJFCFCADEHBIFCADEGBJKKADEHBIKADEGBJKKADEGBJFCFCADEGBJKKADEGBJKFCADEGBJFCFCADEGBJKRADEGBJFCFCADEGBJKFCADEGBJFCFADEGBJKFADEGBJKADEGBJFCADEGBJKADEGBJFCADEGBJFCADEGBJRADEGBJFCADEGBJFCADEGBJFCSLOLFSUALOLADEHBIKADEHBIFCADEHBIKADEHBIFCADEHBIFCADEHBIRADEHBIFCADEHBIFCADEHBIFCSLOLUALOLFSUALOLLOLUILOLLOLUJUK $.

${
    $d x ph0 $.
    kore-sort-functional.0 $e |- ( \imp th0 ( \kore-is-sort ph0 ) ) $.
    kore-sort-functional   $p |- ( \imp th0 ( \exists x ( \eq x ph0 ) ) ) $=
        $(
            apply "rule-imp-transitivity"
            apply "kore-sort-functional.0"
            apply "notation-proof"
            apply "lemma-imp-compat-in-exists"
            apply "and-elim-right"
            apply "notation-imp"
            apply "kore-is-sort-is-sugar"
            apply "notation-reflexivity"
        $)
        ( element-var-is-var var-is-pattern imp-is-pattern bot-is-pattern eq-is-pattern sort-is-symbol symbol-is-pattern in-sort-is-pattern not-is-pattern exists-is-pattern or-is-pattern notation-transitivity and-is-pattern kore-is-sort-is-pattern notation-reflexivity notation-symmetry exists-sort-is-pattern not-is-sugar notation-imp and-elim-right lemma-imp-compat-in-exists kore-is-sort-is-sugar or-is-sugar and-is-sugar notation-exists sorted-exists-is-pattern exists-sort-is-sugar sorted-exists-is-sugar notation-notation notation-proof rule-imp-transitivity ) BARCEFAICNDCEFJKLHGHGCEFAIHGGHGCNCEFAICNGARCEFAICNGCEFJKLHGHGCEFAIHGGHGCEFAICCEFJKLCEFAIUDUEARCEFAICNCEFJKLHGHGCEFAIHGGHGCNCEFAICNARCEFAICUAARCEFJKLHGHGCEFAIHGGHGCNACUFARSCEFJKLHGHGCEFAIHGGHGCNCEFJKLCEFAIQCNCEFAICUACEFJKLHGHGCEFAIHGGHGCEFJKLCEFAIQCCEFJKLHGHGCEFAIHGGHGCEFJKLMCEFAIMOHGCEFJKLCEFAIQCEFJKLHGHGCEFAIHGGHCEFJKLMCEFAIMOHCEFJKLHGHGCEFAIHGGCEFJKLMMCEFAIMGCEFJKLMCEFAIMOCEFJKLHGHGCEFAIHGCEFJKLMMCEFAIMCEFJKLHGHGCEFJKLMHGCEFJKLMMCEFJKLHGHCEFJKLMHCEFJKLHGCEFJKLHGCEFJKLMCEFJKLHGSCEFJKLMCEFJKLHGCEFJKLUBTPHSUCCEFJKLMMCEFJKLMHGCEFJKLMUBTPCEFAIHGCEFAIHGCEFAIMCEFAIHGSCEFAIMCEFAIHGCEFAIUBTPUCCEFJKLMCEFAIMOCEFJKLMMCEFAIMGCEFJKLMCEFAIMUGTPHSUCCEFJKLCEFAIQCEFJKLMCEFAIMOHGCEFJKLCEFAIQCEFJKLMCEFAIMOMCEFJKLMCEFAIMOHGCEFJKLCEFAIUHCEFJKLMCEFAIMOUBPTPUICEFAICUACEFJKLCEFAIQCNCEFAICUAJKCEFAICUJCEFJKLCEFAIQCNCEFAICUKJKCEFAICULPTPUMCEFAICNSUCUNUO $.
$}

${
    $d z ph0 $.
    $d z ph1 $.
    $d z ph2 $.
    $d z y $.
    $d z x $.
    $d z th1 $.
    $d z th2 $.
    $d x ph0 $.
    functional-substitution-alt2.0 $e #Fresh y th0 $.
    functional-substitution-alt2.1 $e |- ( \imp th0 ( \exists x ( \eq x ph0 ) ) ) $.
    functional-substitution-alt2.2 $e |- ( \imp ( \and th0 th1 ) ph1 ) $.
    functional-substitution-alt2.3 $e #Substitution ( \imp th2 ph2 ) ( \imp th1 ph1 ) ph0 y $.
    functional-substitution-alt2.4 $e #Substitution ( \imp th3 ph3 ) ( \imp th1 ph1 ) z y $.
    functional-substitution-alt2   $p |- ( \imp ( \and th0 th2 ) ph2 ) $=
        $(
            apply "rule-uncurry"
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "weakening-imp3"
            apply "functional-substitution"
            apply "fresh-disjoint"
            apply "functional-substitution-alt2.3"
            apply "functional-substitution-alt2.4"
            apply "functional-substitution-alt2.1"
            apply "proof-rule-mp"
            apply "rule-iff-elim-left"
            apply "lemma-prenex-forall-imp-right"
            apply "functional-substitution-alt2.0"
            apply "lemma-forall-intro"
            apply "rule-curry"
            apply "functional-substitution-alt2.2"
        $)
        ( imp-is-pattern forall-is-pattern element-var-is-var var-is-pattern eq-is-pattern exists-is-pattern proof-rule-mp weakening-imp3 fresh-disjoint functional-substitution lemma-prenex-forall-imp-right rule-iff-elim-left rule-curry lemma-forall-intro rule-uncurry ) EGCEFBQJRQEGCQQEISTAUAIUBQEFBQJRQEGCQQQISTAUAIUBFBQJRGCQQQEISTAUAIUBQEFBQJRQEGCQQQQISTAUAIUBFBQJRGCQEUDAFBQGCQHDQJIKAISUEOPUFUCMUCEFBQQJREFBQJRQEFBQQJREFBQJRQEFBQJLUGUHEFBQQJEFBNUIUJUCUCUK $.
$}

${
    $d z ph0 $.
    $d z ph1 $.
    $d z ph2 $.
    $d z y $.
    $d z x $.
    $d z th1 $.
    $d z th2 $.
    $d x ph0 $.
    $d y th0 $.
    functional-substitution-alt.0 $e |- ( \imp th0 ( \exists x ( \eq x ph0 ) ) ) $.
    functional-substitution-alt.1 $e |- ( \imp ( \and th0 th1 ) ph1 ) $.
    functional-substitution-alt.2 $e #Substitution ( \imp th2 ph2 ) ( \imp th1 ph1 ) ph0 y $.
    functional-substitution-alt.3 $e #Substitution ( \imp th3 ph3 ) ( \imp th1 ph1 ) z y $.
    functional-substitution-alt   $p |- ( \imp ( \and th0 th2 ) ph2 ) $=
        $(
            apply "functional-substitution-alt2"
            apply "fresh-disjoint"
            apply "functional-substitution-alt.0"
            apply "functional-substitution-alt.1"
            apply "functional-substitution-alt.2"
            apply "functional-substitution-alt.3"
        $)
        ( element-var-is-var fresh-disjoint functional-substitution-alt2 ) ABCDEFGHIJKEJPQLMNOR $.
$}

${
    $d z ph0 $.
    $d z ph1 $.
    $d z ph2 $.
    $d z y $.
    $d z x $.
    $d z th1 $.
    $d z th2 $.
    $d x ph0 $.
    $d y th0 $.
    functional-substitution-alt3.0 $e |- ( \imp th0 ( \exists x ( \eq x ph0 ) ) ) $.
    functional-substitution-alt3.2 $e #Substitution ( \imp th2 ph2 ) ( \imp th1 ph1 ) ph0 y $.
    functional-substitution-alt3.3 $e #Substitution ( \imp th3 ph3 ) ( \imp th1 ph1 ) z y $.
    functional-substitution-alt3   $p |- ( \imp th0 ( \imp ( \forall y ( \imp th1 ph1 ) ) ( \imp th2 ph2 ) ) ) $=
        $(
            apply "rule-curry"
            apply "rule-curry"
            apply "functional-substitution-alt2", y = "y"
            fresh
            apply "rule-uncurry"
            apply "premises-switch"
            apply "rule-weakening"
            apply "functional-substitution-alt3.0"
            apply "rule-uncurry"
            apply "rule-uncurry"
            apply "rule-weakening"
            apply "proof-rule-mp"
            apply "forall-intro-alt"
            apply "imp-reflexivity"
            apply "functional-substitution-alt3.2"
            apply "functional-substitution-alt3.3"
        $)
        $( ( imp-is-pattern not-is-pattern forall-is-pattern bot-is-pattern element-var-is-var exists-is-pattern or-is-pattern notation-transitivity and-is-pattern fresh-in-imp notation-reflexivity notation-fresh fresh-in-bot not-is-sugar var-is-pattern eq-is-pattern rule-uncurry rule-weakening rule-curry fresh-disjoint fresh-in-exists-shadowed forall-is-sugar or-is-sugar and-is-sugar premises-switch forall-intro-alt imp-reflexivity proof-rule-mp functional-substitution-alt2 ) EFBOJQGCOEFBOJQUCGCABCDEFBOJQUCFGHIJKEPFBOJQPUAROEFBOJQUCJSEPFBOJQPUARJSEPPFBOJQPOEPFBOJQPUAJSEPPFBOJQPJSEPROEPPJSEPRJSEROEPJSERJSEJSUNJSUGUDEPEROEROEUHEROUEUBUFJSUGUDEPPEPROEPROEPUHEPROUEUBUFFBOJQROFBOJQPJSFBOJQRJSFBOPJTROFBOJQJSFBOPJTRJSFBOPJUOJSUGUDFBOJQFBOPJTROFBOPJTROFBOJQFBOPJTPFBOPJTROFBOJUPFBOPJTUHUBFBOPJTROUEUBUFJSUGUDFBOJQPFBOJQROFBOJQROFBOJQUHFBOJQROUEUBUFUDEPFBOJQPUAEPPFBOJQPOEPPFBOJQPOEPFBOJQPUQEPPFBOJQPOUEUBUFJSUGUDEFBOJQUCEPFBOJQPUAROEPFBOJQPUAROEFBOJQUCEPFBOJQPUAPEPFBOJQPUAROEFBOJQUREPFBOJQPUAUHUBEPFBOJQPUAROUEUBUFEFBOJQISUIAUJITFBOJQEISUIAUJITFBOJQEISUIAUJITOLULUSUKEFBOJQUCFBEFBOJQFBOEFBOJQFBOOFBOFBOOFBOJQFBOOFBOFBOJUTFBOVAVBULUKUKMNVCUMUM $. $)
        ( imp-is-pattern not-is-pattern forall-is-pattern bot-is-pattern element-var-is-var exists-is-pattern or-is-pattern notation-reflexivity notation-transitivity notation-fresh and-is-pattern fresh-disjoint fresh-in-imp not-is-sugar var-is-pattern eq-is-pattern rule-uncurry rule-weakening rule-curry fresh-in-exists-shadowed forall-is-sugar or-is-sugar and-is-sugar premises-switch forall-intro-alt imp-reflexivity proof-rule-mp functional-substitution-alt2 ) EFBOJQGCOEFBOJQUEGCABCDEFBOJQUEFGHIJKEPFBOJQPUAPEFBOJQUEJSEPFBOJQPUAROEPFBOJQPUAPJSEPFBOJQPUARJSEPPFBOJQPOEPFBOJQPUAJSEPPFBOJQPJSEPPJSUFFBOJQROFBOJQPJSFBOJQRJSFBOPJTPFBOJQJSFBOPJTROFBOPJTPJSFBOPJTRJSFBOPJUNRJSUFUGFBOPJTPFBOPJTROFBOPJTROFBOPJTUHFBOPJTROUBUCUDFBOJQFBOPJTPFBOPJTPFBOJUOFBOPJTPUBUCUDRJSUFUGFBOJQPFBOJQROFBOJQROFBOJQUHFBOJQROUBUCUDUGEPFBOJQPUAEPPFBOJQPOEPPFBOJQPOEPFBOJQPUPEPPFBOJQPOUBUCUDRJSUFUGEPFBOJQPUAPEPFBOJQPUAROEPFBOJQPUAROEPFBOJQPUAUHEPFBOJQPUAROUBUCUDEFBOJQUEEPFBOJQPUAPEPFBOJQPUAPEFBOJQUQEPFBOJQPUAPUBUCUDEFBOJQISUIAUJITFBOJQEISUIAUJITFBOJQEISUIAUJITOLULURUKEFBOJQUEFBEFBOJQFBOEFBOJQFBOOFBOFBOOFBOJQFBOOFBOFBOJUSFBOUTVAULUKUKMNVBUMUM $.
$}

${
    $d z ph0 $.
    $d z ph1 $.
    $d z ph2 $.
    $d z y $.
    $d z x $.
    $d z th1 $.
    $d z th2 $.
    $d x ph0 $.
    $d y th0 $.
    kore-functional-substitution.0 $e |- ( \imp th0 ( \in-sort ph4 ph0 ) ) $.
    kore-functional-substitution.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph4 ) ) ) ) $.
    kore-functional-substitution.2 $e #Substitution ph3 ph2 ph4 y $.
    kore-functional-substitution.3 $e #Substitution ph5 ph2 z y $.
    kore-functional-substitution   $p |- ( \imp th0 ( \kore-valid ph1 ( \kore-implies ph1 ( \kore-forall ph0 y ph1 ph2 ) ph3 ) ) ) $= ? $.
$}

eq-compat-in-eq-alt $p |- ( \imp ( \eq ph0 ph1 ) ( \eq ( \eq ph0 ph2 ) ( \eq ph1 ph2 ) ) ) $=
    $(
        apply "rule-imp-transitivity"
        apply "lemma-predicate-floor"
        apply "lemma-floor-is-predicate"
        apply "lemma-imp-compat-in-floor"
        apply "rule-and-intro-alt2-sugar"
        apply "rule-imp-transitivity"
        apply "eq-symmetry"
        apply "eq-transitivity"
        apply "eq-transitivity"
    $)
    ( eq-is-pattern imp-is-pattern floor-is-pattern iff-is-pattern notation-reflexivity and-is-pattern notation-transitivity notation-proof is-predicate-is-pattern eq-is-sugar eq-transitivity rule-imp-transitivity notation-imp lemma-floor-is-predicate notation-is-predicate lemma-predicate-floor eq-symmetry rule-and-intro-alt2-sugar iff-is-sugar lemma-imp-compat-in-floor ) ABDABDFACDBCDDABDABGFLABDLABGQABDABGFABDABGFABGFABMABGFHJRKSABDFACDBCDGFEABDFACDBCDDEABDACDBCDGABDACDBCDEBCDACDEIEABDACDBCDGEABDACDBCDEBCDACDEABDBADACDBCDEBATBACNOABCNUAABDACDBCDGABDACDBCDEBCDACDEIABDHACDBCDGACDBCDEBCDACDEIACDBCDEBCDACDEIACDBCDUBACDBCDEBCDACDEIHJPKUCABDFACDBCDDABDFACDBCDGFABDFHACDBCDDACDBCDGFACDBCDGFACDBCDMACDBCDGFHJPKO $.

${
    nonempty-floor-is-top.0 $e |- ( \ceil ph0 ) $.
    nonempty-floor-is-top   $p |- ( \iff ( \eq ph0 ( \and ( \floor ph1 ) ph0 ) ) ( \floor ph1 ) ) $=
        $(
            apply "rule-and-intro"
            apply "rule-imp-transitivity"
            apply "eq-compat-in-ceil"
            apply "lemma-imp-compat-in-floor"
            apply "rule-imp-transitivity"
            apply "and-elim-left"
            apply "rule-imp-transitivity"
            apply "proof-rule-mp"
            apply "mp"
            apply "nonempty-floor-is-top.0"
            apply "rule-imp-transitivity"
            apply "lemma-imp-compat-in-ceil"
            apply "and-elim-left"
            apply "rule-imp-transitivity"
            apply "ceil-floor-imp-floor"
            apply "lemma-floor-elim-alt"
            apply "rule-imp-transitivity"
            apply "lemma-floor-imp-floor2"
            apply "lemma-imp-compat-in-floor"
            apply "rule-and-intro-alt2-sugar"
            apply "rule-curry"
            apply "imp-reflexivity"
            apply "rule-weakening"
            apply "and-elim-right"
        $)
        ( floor-is-pattern imp-is-pattern and-is-pattern ceil-is-pattern bot-is-pattern not-is-pattern eq-is-pattern notation-transitivity or-is-pattern iff-is-pattern notation-reflexivity notation-imp not-is-sugar notation-proof rule-imp-transitivity and-is-sugar or-is-sugar iff-is-sugar and-elim-left lemma-imp-compat-in-floor eq-is-sugar eq-compat-in-ceil mp proof-rule-mp lemma-imp-compat-in-ceil ceil-floor-imp-floor lemma-floor-elim-alt lemma-floor-imp-floor2 imp-reflexivity rule-curry and-elim-right rule-weakening rule-and-intro-alt2-sugar rule-and-intro ) ABDAFJBDEHEHEBDABDAFJEHEEHEABDAFJBDMABDAFJBDEBDABDAFJEABDAFJAGBDAFGJBDABDAFUEAGBDAFGMDBDEAGBDAFGJBDEAGBDAFGMBAGBDAFGMAGBDAFGEBAGBDAFGEHEHEBDAFGAGEHEEHEAGBDAFGEEAGBDAFGMAGBDAFGEEAGBDAFGEBDAFGAGEUBAGBDAFGMAGBDAFGEAGBDAFGEHEHEBDAFGAGEHEEHEAGBDAFGEAGBDAFGMAGBDAFGEIBDAFGAGEILHEAGBDAFGEHEHEBDAFGAGEHEEHEAGBDAFGMAGBDAFGEIBDAFGAGEILIAGBDAFGEIBDAFGAGEILHEAGBDAFGMAGBDAFGEBDAFGAGEFAGBDAFGEIBDAFGAGEILIAGBDAFGUAAGBDAFGEBDAFGAGESKAGBDAFGEIBDAFGAGEILPKAGBDAFGEIBDAFGAGEILHAGBDAFGEHEHEBDAFGAGEHEEHAGBDAFGEIBDAFGAGEILAGBDAFGEIIBDAFGAGEIEAGBDAFGEHEHEBDAFGAGEHEEAGBDAFGEIBDAFGAGEITAGBDAFGEIIBDAFGAGEIAGBDAFGEHEHEBDAFGAGEHEAGBDAFGEIIAGBDAFGEIHEAGBDAFGEHEHEAGBDAFGEIPAGBDAFGEIHAGBDAFGEHEHAGBDAFGEIAGBDAFGEHEAGBDAFGEHEAGBDAFGEPAGBDAFGEHENKHNOKBDAFGAGEIBDAFGAGEHEBDAFGAGEHEBDAFGAGEPBDAFGAGEHENKOKHNOKAGBDAFGENOQAGBDAFGEBDAFGBAGAGBDAFGEBDAFGEAGBDAFGUFCUGBDAFGBDGBBDAFBDBDHEHEAHEEHEBDEBDAFBDEBDAUBBDAFBDBDHEHEAHEEHEBDBDAFBDIAILHEBDHEHEAHEEHEBDAFBDIAILIBDIAILHEBDASBDIAILPKBDIAILHBDHEHEAHEEHBDIAILBDIIAIEBDHEHEAHEEBDIAITBDIIAIBDHEHEAHEBDIIBDIHEBDHEHEBDIPBDIHBDHEHBDIBDHEBDHEBDPBDHENKHNOKAIAHEAHEAPAHENKOKHNOKBDNOQUHBDGBDBBUIBUJRRRRUCAGBDAFGJBDAGBDAFGMDBDAGBDAFGJAGBDAFGMDAGBDAFGMDAGBDAFGUDAGBDAFGMDNKBDNOQRBDBDDABDAFJBUKBDDABDAFMDEBDDABDAFJEBDABDAFMBDABDAFEBDAFAEFEBDABDAFMEBDABDAFEBDAFAEBDABDAFBDAFULUMBDBDAFAEBDHEHEAHEEHEAEBDAFAEBDAUNBDAFABDHEHEAHEEHEABDAFBDIAILHEBDHEHEAHEEHEBDAFBDIAILIBDIAILHEBDASBDIAILPKBDIAILHBDHEHEAHEEHBDIAILBDIIAIEBDHEHEAHEEBDIAITBDIIAIBDHEHEAHEBDIIBDIHEBDHEHEBDIPBDIHBDHEHBDIBDHEBDHEBDPBDHENKHNOKAIAHEAHEAPAHENKOKHNOKANOQUOUPBDABDAFMBDABDAFEBDAFAEFBDNABDAFMABDAFEBDAFAEFABDAFEBDAFAEFABDAFUAABDAFEBDAFAEFNKOQUCBDDABDAFJBDDABDAFMDBDDNABDAFJABDAFMDABDAFMDABDAFUDABDAFMDNKOQRUQABDAFJBDMABDAFJBDEIBDABDAFJEILHEABDAFJBDEHEHEBDABDAFJEHEEHEABDAFJBDMABDAFJBDEIBDABDAFJEILIABDAFJBDEIBDABDAFJEILHEABDAFJBDMABDAFJBDEBDABDAFJEFABDAFJBDEIBDABDAFJEILIABDAFJBDUAABDAFJBDEBDABDAFJESKABDAFJBDEIBDABDAFJEILPKABDAFJBDEIBDABDAFJEILHABDAFJBDEHEHEBDABDAFJEHEEHABDAFJBDEIBDABDAFJEILABDAFJBDEIIBDABDAFJEIEABDAFJBDEHEHEBDABDAFJEHEEABDAFJBDEIBDABDAFJEITABDAFJBDEIIBDABDAFJEIABDAFJBDEHEHEBDABDAFJEHEABDAFJBDEIIABDAFJBDEIHEABDAFJBDEHEHEABDAFJBDEIPABDAFJBDEIHABDAFJBDEHEHABDAFJBDEIABDAFJBDEHEABDAFJBDEHEABDAFJBDEPABDAFJBDEHENKHNOKBDABDAFJEIBDABDAFJEHEBDABDAFJEHEBDABDAFJEPBDABDAFJEHENKOKHNOKQ $.
$}

${
    $d x y $.
    unit-sort-nonempty-alt $p |- ( \ceil ( \inh \unit-sort ) ) $=
        $(
            apply "proof-rule-mp"
            apply "rule-imp-transitivity"
            apply "membership-symbol-ceil-right"
            let $6 = "x"
            apply "x-in-ceil-imp-ceil"
            let $7 = "y"
            apply "proof-rule-mp"
            apply "lemma-imp-compat-in-exists"
            apply "include-imp-in"
            apply "notation-proof"
            apply "unit-sort-nonempty"
            let $19 = "y"
            notation
        $)
        ( y-is-element-var unit-sort-is-symbol symbol-is-pattern inh-is-pattern element-var-is-var var-is-pattern imp-is-pattern not-is-pattern ceil-is-pattern included-is-pattern floor-is-pattern bot-is-pattern notation-symmetry notation-transitivity exists-is-pattern in-is-pattern in-sort-is-pattern x-is-element-var included-is-sugar floor-is-sugar not-is-sugar proof-rule-mp membership-symbol-ceil-right x-in-ceil-imp-ceil rule-imp-transitivity include-imp-in lemma-imp-compat-in-exists unit-sort-nonempty in-sort-is-sugar notation-reflexivity notation-exists notation-proof ) BCDAPAOBCDIBCDAPAOBCDIRPBCDIBCDRAUCBCDRUDUEAEFBCDJAOBCDAPAOAEFBCDJBCDAPABCDAUFUGAEFBCQAOAEFBCDJAOAUHAEFBCDJAEFBCQAAEFBCDJAEFBCDGKAEFBCQAEFBCDSAEFBCQAEFBCDGKAEFBCQAEFBCDJAEFBCDGKAEFBCUIAEFBCDGKAEFBCDJAEFBCDGKAEFBCDGHIHAEFBCDJAEFBCDGTAEFBCDJAEFBCDGHIHAEFBCDJAEFBCDGKAEFBCDGHIHAEFBCDSAEFBCDGHIHAEFBCDGKAEFBCDGHIHAEFBCDGHILGAEFBCDGKAEFBCDGHIUAAEFBCDGKAEFBCDGHILGAEFBCDGKAEFBCDGHIHAEFBCDGHILGAEFBCDGTAEFBCDGHILGAEFBCDGHIHAEFBCDGHIHAEFBCDGHILGAEFBCDGHIHAEFBCDGHILGAEFBCDGHILGAEFBCDGHIUAAEFBCDGHILGAEFBCDGHILGAEFBCDGHILGUJMNMMNMNMNMNMNMNUKULUBUB $.
$}

${
    kore-equals-to-eq.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-equals-to-eq.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-equals-to-eq.2 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-equals ph0 \unit-sort ph1 ph2 ) ) ) $.
    kore-equals-to-eq   $p |- ( \imp th0 ( \eq ph1 ph2 ) ) $=
        $(
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            meh
            apply "kore-equals-to-eq.0"
            apply "kore-equals-to-eq.1"
            apply "kore-equals-to-eq.2"
            apply "proof-rule-mp"
            apply "weakening-imp4"
            apply "rule-curry"
            apply "rule-imp-transitivity"
            apply "kore-semantics-equals"
            apply "rule-imp-transitivity"
            apply "eq-compat-in-eq-alt"
            apply "proof-rule-mp"
            apply "premises-switch"
            apply "rule-curry"
            apply "rule-imp-transitivity"
            meh
            apply "rule-imp-transitivity"
            apply "lemma-floor-elim-alt"
            apply "iff-elim-left"
            meh
            apply "rule-uncurry"
            apply "eq-transitivity"
            apply "lemma-floor-intro"
            apply "rule-iff-transitivity"
            apply "rule-iff-intro"
            apply "eq-symmetry"
            apply "eq-symmetry"
            apply "nonempty-floor-is-top"
            apply "unit-sort-nonempty-alt"
        $)
        ( unit-sort-is-symbol symbol-is-pattern eq-is-pattern inh-is-pattern kore-top-is-pattern kore-equals-is-pattern and-is-pattern kore-valid-is-pattern imp-is-pattern iff-is-pattern floor-is-pattern in-sort-is-pattern notation-reflexivity notation-transitivity proof-rule-mp eq-is-sugar rule-imp-transitivity notation-proof notation-symmetry notation-eq notation-imp rule-curry eq-symmetry weakening-imp4 kore-semantics-equals eq-compat-in-eq-alt eq-transitivity kore-valid-is-sugar rule-uncurry lemma-floor-elim-alt iff-elim-left premises-switch rule-iff-intro unit-sort-nonempty-alt nonempty-floor-is-top kore-top-is-sugar notation-and notation-iff rule-iff-transitivity lemma-floor-intro ) DHIAHIBCMOPDBCJPDCASPDHIAHIBCMOPDBCJPPDBASPDCASPDHIAHIBCMOPDBCJPPPBASCASHIAHIBCMOBCJPPPDBASPDCASPDHIAHIBCMOPDBCJPPPPBASCASHIAHIBCMOBCJDUKBASCASHIAHIBCMOBCJPBASCASNAHIBCMBCJHIKNJHIAHIBCMOBCJPAHIBCULAHIBCMBCJHIKNJAHIBCMHILJBCJHIKNHILJJHIAHIBCMOBCJPAHIBCMBCJHIKNHILUMBCJHIKNHILJBCJJAHIBCMHILJBCJHIKNHILJJHIAHIBCMOBCJPPAHIBCMHILJBCJHIKNHILJJBCJHIKNHILJBCJJHIAHIBCMOBCJPAHIBCMHILJBCJHIKNHILJJBCJHIKNHILJBCJJHIAHIBCMOBCJPAHIBCMHILJBCJHIKNHILJJBCJHIKNHILJBCJJNHIAHIBCMOBCJQRHIAHIBCMOBCJPAHIBCMHILJBCJHIKNHILJJBCJHIKNHILJBCJJHIAHIBCMOBCJQRHIAHIBCMOBCJHIKNHILJJBCJHIKNHILJBCJJHIAHIBCMOBCJJPPAHIBCMHILJBCJHIKNHILJJBCJHIKNHILJBCJJHIAHIBCMOBCJQRPPHIAHIBCMOBCJHIKNHILJBCJUNAHIBCMHILJBCJHIKNHILJJBCJHIKNHILJBCJJHIAHIBCMOBCJQRPHIAHIBCMOBCJHIKNHILJJBCJHIKNHILJBCJJHIAHIBCMOBCJJPAHIBCMHILJBCJHIKNHILJHIAHIBCMOBCJHIKNHILJAHIBCMHILJAHIBCMHILJHIAHIBCMOAHIBCMHILJTHIAHIBCMOAHIBCMHILJHIAHIBCMUOUFUABCJHIKNHILJTUGBCJHIKNHILJBCJJHIAHIBCMOBCJQRBCJHIKNHILJBCJJHIAHIBCMOBCJJBCJHIKNHILJBCJJTHIAHIBCMOBCJQRHIAHIBCMOBCJQRHIAHIBCMOBCJJHIAHIBCMOBCJQRTHIAHIBCMOBCJJHIAHIBCMOBCJQRHIAHIBCMOBCJUCUFUAUHUHUEUPHIAHIBCMOBCJQRHIAHIBCMOBCJQHIAHIBCMOBCJPHIAHIBCMOBCJQUQHIAHIBCMOBCJURUDUDUIUSBCJHIKNHILJBCJQRBCJHIKNHILJBCJJBCJHIKNHILJBCJQBCJHIKNHILJHILBCJHIKNJBCJBCJHIKNHILJHILBCJHIKNJHILBCJHIKNUJBCJHIKNHILUJUTHIKBCQRHIKNJBCQRQHILBCJHIKNJBCJQHIKBCQVAVBHILBCJHIKNJBCJHIKBCQRHIKNJBCQRHILBCJHIKNHIKBCQRHIKNHILHIKHIKHIVCHIKTUABCJHIKBCQRHIKBCJBCQRBCQRBCUCBCQRTUAHIKTVDUGBCUCVEUEVFVGBCJHIKNHILJBCJJBCJHIKNHILJBCJQRBCJHIKNHILJBCJQRBCJHIKNHILJBCJUCBCJHIKNHILJBCJQRTUAUEUBUDUDUIUBEUBFUBGUB $.
$}

${
    kore-equals-elim.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-equals-elim.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-equals-elim.2 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-equals ph0 \unit-sort ph1 ph2 ) ) ) $.
    kore-equals-elim.3 $e |- ( \imp th0 ph3 ) $.
    kore-equals-elim.4 $e #Substitution ph3 ph4 ph1 x $.
    kore-equals-elim.5 $e #Substitution ph5 ph4 ph2 x $.
    kore-equals-elim   $p |- ( \imp th0 ph5 ) $=
        $(
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "weakening-imp3"
            meh
            apply "kore-equals-to-eq"
            apply "kore-equals-elim.0"
            apply "kore-equals-elim.1"
            apply "kore-equals-elim.2"
            apply "kore-equals-elim.3"
            apply "eq-elim"
            apply "kore-equals-elim.4"
            apply "kore-equals-elim.5"
        $)
        ( imp-is-pattern eq-is-pattern proof-rule-mp weakening-imp3 eq-elim kore-equals-to-eq ) GDOGFOGBCPOGDOGFOOBCPDFOOGBCPOGDOGFOOOBCPDFGRBCDFEHMNSQABCGIJKTQLQ $.
$}

${
    $( the essentials and conclusion are put in a specific form to be recognized by KoreComposer $)
    kore-equals-elim-alt.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-equals-elim-alt.1 $e |- ( \imp th0 ( \in-sort ph2 ph0 ) ) $.
    kore-equals-elim-alt.2 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-equals ph0 \unit-sort ph1 ph2 ) ) ) $.
    kore-equals-elim-alt.3 $e |- ( \imp th0 ( \kore-valid ph6 ph3 ) ) $.
    kore-equals-elim-alt.4 $e #Substitution ( \kore-valid ph6 ph3 ) ph4 ph1 x $.
    kore-equals-elim-alt.5 $e #Substitution ( \kore-valid ph7 ph5 ) ph4 ph2 x $.
    kore-equals-elim-alt   $p |- ( \imp th0 ( \kore-valid ph7 ph5 ) ) $=
        $(
            apply "kore-equals-elim"
            apply "kore-equals-elim-alt.0"
            apply "kore-equals-elim-alt.1"
            apply "kore-equals-elim-alt.2"
            apply "kore-equals-elim-alt.3"
            apply "kore-equals-elim-alt.4"
            apply "kore-equals-elim-alt.5"
        $)
        ( kore-valid-is-pattern kore-equals-elim ) ABCGDQEHFQIJKLMNOPR $.
$}

kore-equals-reflexivity-aux $p |- ( \not ( \and ( \not ( \and ( \or ( \and ( \not ph2 ) ph1 ) ph2 ) ( \or ( \and ( \not ph2 ) ph1 ) ph2 ) ) ) ph1 ) ) $= 
    $( tautology $)
    ( not-is-pattern or-is-pattern and-is-pattern rule-iff-transitivity iff-reflexivity rule-iff-compat-in-or rule-iff-compat-in-and rule-iff-symmetry or-associativity and-associativity top-is-pattern or-commutativity and-commutativity rule-imp-transitivity bot-is-pattern rule-iff-elim-left rule-iff-compat-in-not double-negation de-morgan-and or-idempotency de-morgan-or or-right-distributivity or-complement or-top and-top and-idempotency and-elim-left-sugar rule-imp-compat-in-and imp-is-pattern contradiction or-left-distributivity resolution-2 resolution-1 and-bot proof-rule-mp ) BCAEBDBCAEBDECAECCQUKBCAEBDBCAEBDECAECBCAEBDBCAEBDECAECULBCAEBDBCAEBDECAECCAACBDBCEEQBCAEBDBCAEBDECAECCAACBDBCEEBCAEBDBCAEBDECAECCBCBCDBCBACDDACBBACDDDACBBCDDAEEEEAACBDBCEEBCAEBDBCAEBDECAECCBCAEBDBCAEBDECAECCBCBCDBCBACDDACBBACDDDACBBCDDAEEEEBCAEBDBCAEBDECAECBCAEBDBCAEBDECAECBCAEBDBCAEBDECAEBCAEBDBCAEBDECAEBCAEBDBCAEBDECBCAEBDBCAEBDECAABCAEBDBCAEBDEBCAEBDBCAEBDEBCAEBDBCAEBDBCAEBDBCAEBDBCAEBCAEBBBCBCAABBBGSAGIBGHBCAEBCAEBBBCBCAABBBGSAGIBGHISAGISSBCAEBDBCAEBDECAECCBCAEBDBCAEBDECAEBCBCDBCBACDDACBBACDDDACBBCDDAEEEEBCAEBDBCAEBDECAETBCAEBDBCAEBDECAEACBBCDDACBBACDDDBCBACDDBCBCDEEEAEBCBCDBCBACDDACBBACDDDACBBCDDAEEEEBCAEBDBCAEBDECACBBCDDACBBACDDDBCBACDDBCBCDEEEAABCAEBDBCAEBDECBCAEBDCBCAEBDCDACBBCDDACBBACDDDBCBACDDBCBCDEEEBCAEBDBCAEBDUABCAEBDCBCAEBDCDBACDBACDBCEDBCBACDBCEDEACBBCDDACBBACDDDBCBACDDBCBCDEEEBCAEBDCBCAEBDCDBACDBCEBACDBCEDBACDBACDBCEDBCBACDBCEDEBCAEBDCBACDBCEBCAEBDCBACDBCEBCAEBDCBCAECBCEBACDBCEBCAEBUCBCAECBCEBACDBCEBACDBCEBCAECBACDBCBCBCAECBCCACDBACDBCAUABCCACDBACDBACDBCCBACACBCCBBBTBGFACGHBACDGFFBCGIBACDBCEGFFBCAEBDCBCAECBCEBACDBCEBCAEBUCBCAECBCEBACDBCEBACDBCEBCAECBACDBCBCBCAECBCCACDBACDBCAUABCCACDBACDBACDBCCBACACBCCBBBTBGFACGHBACDGFFBCGIBACDBCEGFFHBACDBCBACDBCEUMFBACDBACDBCEDBCBACDBCEDEACBBACDDDACBBCDDEBCBACDDBCBCDEEACBBCDDACBBACDDDBCBACDDBCBCDEEEBACDBACDBCEDACBBACDDDACBBCDDEBCBACDBCEDBCBACDDBCBCDEBACDBACDBCEDBACDBACDDBACDBCDEACBBACDDDACBBCDDEBACDBACDBCEDBACDBACDBCEDBACDBACDDBACDBCDEBACDBACDBACDBCEBACDBCEBACDBACDBACDBBACACBGACGHBACDGFBACDBCEBACDBCEBACDBCEBACDBACDBCBCBACDBACDBACDBBACACBGACGHBACDGFBCGIBACDBCEGFHBACDBACDBCUDFBACDBACDDBACDBCDEACBBACDDDACBBCDDEACBBACDDDACBBCDDEBACDBACDDACBBACDDDBACDBCDACBBCDDBACDBACDDBACDBACDDACBBACDDDBACDBACDBACDBACDBACDBACDBACDBBACACBGACGHBACDGFBACDBACDBACDBBACACBGACGHBACDGFHBACDBACDDACBDBACDDACBBACDDDBACDACBDBACDBACDBACDBACDACBDBBACACBGACGHBACNFBACDGHACBBACDKFFBACDBCDBACDBCDACBBCDDBACDBACDBCBCBACDBACDBACDBBACACBGACGHBACDGFBCGHBACDBCDACBDBCDACBBCDDBACDACBDBCBCBACDBACDACBDBBACACBGACGHBACNFBCGHACBBCKFFIACBBACDDDACBBCDDEGFFBCBACDBCEDBCBACDDBCBCDEBCBACDDBCBCDEBCBACDBCEDBCBACDBCEDBCBACDDBCBCDEBCBCBACDBCEBACDBCEBCGBACDBCEBACDBCEBACDBCEBACDBACDBCBCBACDBACDBACDBBACACBGACGHBACDGFBCGIBACDBCEGFHBCBACDBCUDFBCBACDDBCBCDEBCBACDDBCBCDEBCBACDDBCBCDEBCBACDDBCBACDDBCBCDBCBCDBCBACDDBCBACDDBCBACDDBCBCBACDBACDBCGBACDBACDBACDBBACACBGACGHBACDGFHBCBACDDGFBCBCDBCBCDBCBCDBCBCBCBCBCGBCGHBCBCDGFIBCBACDDBCBCDEGFFIACBBACDDDACBBCDDEBCBACDDBCBCDEEACBBCDDACBBACDDDEBCBACDDBCBCDEEACBBCDDACBBACDDDBCBACDDBCBCDEEEACBBACDDDACBBCDDEACBBCDDACBBACDDDEBCBACDDBCBCDEBCBACDDBCBCDEACBBACDDDACBBCDDEACBBACDDDACBBCDDEACBBCDDACBBACDDDEACBBACDDDACBBACDDDACBBCDDACBBCDDACBBACDDDGACBBCDDGIACBBACDDDACBBCDDOFBCBACDDBCBCDEGIACBBCDDACBBACDDDBCBACDDBCBCDELFFFFAGIACBBCDDACBBACDDDBCBACDDBCBCDEEEAEBCBCDBCBACDDEACBBACDDDACBBCDDAEEEBCBCDBCBACDDACBBACDDDACBBCDDAEEEEACBBCDDACBBACDDDBCBACDDBCBCDEEEAEBCBCDBCBACDDEACBBACDDDEACBBCDDAEEBCBCDBCBACDDEACBBACDDDACBBCDDAEEEACBBCDDACBBACDDDBCBACDDBCBCDEEEAEBCBCDBCBACDDEACBBACDDDEACBBCDDEAEBCBCDBCBACDDEACBBACDDDEACBBCDDAEEACBBCDDACBBACDDDBCBACDDBCBCDEEEBCBCDBCBACDDEACBBACDDDEACBBCDDEAAACBBCDDACBBACDDDBCBACDDBCBCDEEEACBBCDDBCBCDBCBACDDEACBBACDDDEEBCBCDBCBACDDEACBBACDDDEACBBCDDEACBBCDDACBBCDDACBBACDDDBCBACDDBCBCDEEBCBCDBCBACDDEACBBACDDDEACBBCDDGACBBACDDDBCBACDDBCBCDEEACBBACDDDBCBCDBCBACDDEEBCBCDBCBACDDEACBBACDDDEACBBACDDDACBBACDDDBCBACDDBCBCDEBCBCDBCBACDDEACBBACDDDGBCBACDDBCBCDEBCBACDDBCBCDEBCBCDBCBACDDEBCBACDDBCBACDDBCBCDBCBCDBCBACDDGBCBCDGIBCBACDDBCBCDOFIACBBACDDDBCBCDBCBACDDEOFIACBBCDDBCBCDBCBACDDEACBBACDDDEOFAGIBCBCDBCBACDDEACBBACDDDEACBBCDDALFBCBCDBCBACDDEACBBACDDDACBBCDDAELFBCBCDBCBACDDACBBACDDDACBBCDDAEELFFFFBCBCDBCBACDDACBBACDDDACBBCDDAEEEEBCBCBACDDACBBACDDDACBBCDDAEEEEAACBDBCEEBCBCDBCBACDDACBBACDDDACBBCDDAEEEEBCBCDBCBACDDACBBACDDDACBBCDDAEEEEBCBCBACDDACBBACDDDACBBCDDAEEEEBCBCDBCBACDDACBBACDDDACBBCDDAEEEEGBCBCDBCBCBACDDACBBACDDDACBBCDDAEEEBCBACDDACBBACDDDACBBCDDAEEEBCBCDBCBCBCBCDBCBCDBCBCBCDBCBCDBCBCDBCBCDGBCBCNFBCUBFBCGFBCBACDDACBBACDDDACBBCDDAEEEGIFBCBCBACDDACBBACDDDACBBCDDAEEEEBCACBBACDDDACBBCDDAEEEAACBDBCEEBCBCBACDDACBBACDDDACBBCDDAEEEEMBCACBBACDDDACBBCDDAEEEEBCACBBACDDDACBBCDDAEEEBCBCBACDDACBBACDDDACBBCDDAEEEEBCBACDDBCACBBACDDDACBBCDDAEEEEMBCACBBACDDDACBBCDDAEEEEBCBCBACDDACBBACDDDACBBCDDAEEEEBCBACDDBCEACBBACDDDACBBCDDAEEEBCBACDDBCACBBACDDDACBBCDDAEEEEBCBCBACDDACBBACDDDACBBCDDAEEEEBCBCBACDDEACBBACDDDACBBCDDAEEEBCBACDDBCEACBBACDDDACBBCDDAEEEBCBCBACDDACBBACDDDACBBCDDAEEEEBCBCBACDDACBBACDDDACBBCDDAEEEEBCBCBACDDEACBBACDDDACBBCDDAEEEBCBCBCBACDDACBBACDDDACBBCDDAEEEBCBACDDACBBACDDDACBBCDDAEEEBCGBCBACDDACBBACDDDACBBCDDAEEEGIBCBCBACDDEACBBACDDDACBBCDDAEEEBCBCBACDDACBBACDDDACBBCDDAEEEEBCBCBACDDACBBACDDDACBBCDDAEELJFBCBCBACDDEBCBACDDBCEACBBACDDDACBBCDDAEEACBBACDDDACBBCDDAEEBCBCBACDDOACBBACDDDACBBCDDAEEGIFBCBACDDBCACBBACDDDACBBCDDAEELFBCBACDDMBCACBBACDDDACBBCDDAEEEBCACBBACDDDACBBCDDAEEEBCBACDDBCBACDDMBCBACDDBBCACDDBCBACDDBCBACDDBBCDACDBBCACDDBCBACDDBCBDACDBBCDACDBCBACDDBCBACDDBCBDACDBCBCBACDBACDBCGBACDGHBCBDACDBCBACDDBCBACKJFBCBDBBCDACACBCBNACGHFBBCACKFBBCACDDBCBDACDBCBACDDBBCACDDBBCDACDBCBDACDBBCACDDBBCACDDBBCDACDBBBCACDBCACDBGBCACDGHBBCDACDBBCACDDBBCACKJFBBCDBCBDACACBBCNACGHFBCBACKFFBCBACDDMACDMBCBACDDBCBDACDMACDBCBDACDBCBACDDBCBACKJBCBDMACACBUEACGHFACUFFFBCACBBACDDDACBBCDDAEEEGIFBCACBBACDDDACBBCDDAEEEUGFBCACBBACDDDACBBCDDAEEEACBDBCACBBCDDAEEEAACBDBCEEBCACBBACDDDACBBCDDAEEEACBBACDDDBCACBBCDDAEEEACBDBCACBBCDDAEEEBCACBBACDDDACBBCDDAEEEACBBACDDDBCEACBBCDDAEEACBBACDDDBCACBBCDDAEEEBCACBBACDDDACBBCDDAEEEBCACBBACDDDEACBBCDDAEEACBBACDDDBCEACBBCDDAEEBCACBBACDDDACBBCDDAEEEBCACBBACDDDACBBCDDAEEEBCACBBACDDDEACBBCDDAEEBCBCACBBACDDDACBBCDDAEEACBBACDDDACBBCDDAEEBCGACBBACDDDACBBCDDAEEGIBCACBBACDDDEACBBCDDAEEBCACBBACDDDACBBCDDAEEEBCACBBACDDDACBBCDDAELJFBCACBBACDDDEACBBACDDDBCEACBBCDDAEACBBCDDAEBCACBBACDDDOACBBCDDAEGIFACBBACDDDBCACBBCDDAELFACBBACDDDACBDBCACBBCDDAEEBCACBBCDDAEEACBBACDDDBACACDDACBDACBBACDDDBBACACDDDBACACDDACBBACDDDBACBACDDDBBACACDDDACBBACDDDBACDBACDDBACBACDDDACBBACDDDACBDBACDDBACDBACDDACBBACDDDACBBACDDDACBDBACDDACACBBACDDBBACDDACGBBACDDGHACBDBACDDACBBACDDDACBBACDKJFACBDBACDBACDBACDACBNBACDGHFBACBACDKFBACBACDDDBBDACACDDBBACACDDDBACBACDDDBBDACACDDBBDACACDDBACBACDDDBBACACDDDBBDACACDDBBACBACDDBACACDDBGACBACDDBACDACDBACACDDACBACDDACBDACDBACDACDACBACDDACBACDDACBDACDACACBACDBACDACGBACDGHACBDACDACBACDDACBACKJFACBDBACDACACACBNACGHFBACACKFHBBDACACDDBBACACDDDBBACACDKJFBBDBBDACACDACACDBBNACACDGHFBBACACDKFFBBACACDDDBBDACACDDBACACDDBBDACACDDBBACACDDDBBACACDKJBBDBACACDACACDBUBACACDGHFFBACACDDACBDACBDBACACDDACACBDDACBDBACACDDACBACDDACACBDDBACACDDACBDACDACBACDDBACACDDBACDACDACBDACDBACACDDBACACDDBACDACDBBACACDACACDBGACACDGHBACDACDBACACDDBACACKJFBACDACBDACACBACNACGHFACBACKFACBACDDACACDBDACACBDDACBACDDACACDBDACACDBDACBACDDACACBDDACACDBDACACBACDACBDACGBACNHACACDBDACACBDDACACBKJFACACDACACDBBACACNBGHFACACBKFFACACBDDACACDBDACBDACACDBDACACBDDACACBKJACACDACBBACUBBGHFFACBDGFFBCACBBCDDAEEGIFACBDBCACBBCDDAEEEACBDBCAEEAACBDBCEEACBDBCACBBCDDAEEEMACBDBCAEEEACBDBCAEEACBDBCACBBCDDAEEEACBBCDDACBDBCAEEEMACBDBCAEEEACBDBCACBBCDDAEEEACBBCDDACBDEBCAEEACBBCDDACBDBCAEEEACBDBCACBBCDDAEEEACBDACBBCDDEBCAEEACBBCDDACBDEBCAEEACBDBCACBBCDDAEEEACBDACBBCDDBCAEEEACBDACBBCDDEBCAEEACBDACBDBCACBBCDDAEEACBBCDDBCAEEACBDGBCACBBCDDAEEACBBCDDBCEAEACBBCDDBCAEEBCACBBCDDAEEBCACBBCDDEAEACBBCDDBCEAEBCACBBCDDAEEBCACBBCDDAEEBCACBBCDDEAEBCBCACBBCDDAEACBBCDDAEBCGACBBCDDAEGIBCACBBCDDEAEBCACBBCDDAEEBCACBBCDDALJFBCACBBCDDEACBBCDDBCEAABCACBBCDDOAGIFACBBCDDBCALFIACBDACBBCDDEBCAEEACBDACBBCDDBCAEEEACBDACBBCDDBCAELJFACBDACBBCDDEACBBCDDACBDEBCAEBCAEACBDACBBCDDOBCAEGIFACBBCDDACBDBCAELFACBBCDDMACBDBCAEEACBDBCAEEACBBCDDBCBACDDMACBBCDDBACBCDDBCBACDDACBBCDDBACDBCDBACBCDDACBBCDDACBDBCDBACDBCDACBBCDDACBBCDDACBDBCDACACBBCDBBCDACGBBCDGHACBDBCDACBBCDDACBBCKJFACBDBACDBCBCACBNBCGHFBACBCKFBACBCDDBCBDACDBCBACDDBACBCDDBBCDACDBCBDACDBACBCDDBBCACDDBBCDACDBBACBCDBCACDBGACBCNHBBCDACDBBCACDDBBCACKJFBBCDBCBDACACBBCNACGHFBCBACKFFBCBACDDMACDMBCBACDDBCBDACDMACDBCBDACDBCBACDDBCBACKJBCBDMACACBUEACGHFACUFFFACBDBCAEEGIFACBDBCAEEUGFACBDBCAEEAACBDBCEEAACBDBCEEACBDBCAEEAACBDBCEEAACBDBCEEACBDBCAEEAACBDEBCEAACBDBCEEACBDBCAEEACBDAEBCEAACBDEBCEACBDBCAEEACBDABCEEACBDAEBCEACBDACBDBCAEABCEACBDGBCAOIACBDAEBCEACBDABCEEACBDABCLJFACBDAEAACBDEBCBCACBDAOBCGIFAACBDBCLFAAACBDBCEACBDBCEAGACBDBCEGIFAACBDBCEEGFFFFFFRAACBDBCEEBAACBDBCEEEQAACBDBCEEAACBDBCEEAACBDBCEEEBAACBDBCEEEAACBDBCEEAACBDBCEEAACBDBCEEEAACBDBCEEAACBDBCEEEAACBDBCEEAACBDBCEEUHJRAACBDBCEEBAACBDBCEEAACBDBCEEAACBDBCEEACBDAEBCEBAACBDBCEEACBDAEBCEAACBDBCEEACBDABCEEACBDAEBCEAACBDBCEEACBDABCEEACBDABCEEAACBDBCEEAACBDBCEEACBDABCEEAACBDBCEEAACBDBCEEAACBDBCEEAACBDBCEEGAAACBDBCEACBDBCEAGACBDBCEGIFAACBDBCEEACBDAEBCEACBDABCEEAACBDBCEEAACBDEBCEACBDAEBCEAACBDBCEEAACBDBCEEAACBDEBCEAAACBDBCEACBDBCEAGACBDBCEGIAACBDEBCEAACBDBCEEAACBDBCLJFAACBDEACBDAEBCBCAACBDOBCGIFACBDABCLFFACBDACBDABCEABCEACBDGABCEGIFACBDAEBCEACBDABCEEACBDABCLJFRACBDAEBCEACBDAEBACBDAEBCUIACBDAEBBABUNBBBGRPPPAACBDBCEEAACBDBCEEAACBDBCEEGRUJPBAACBDBCEEEQBAACBDBCEEEEQBAACBDBCEEEBAACBDBCEEEBAACBDBCEEEEQBAACBDBCEEEEBAACBDBCEEEBAACBDBCEEEBAACBDBCEEEEBAACBDBCEEEBAACBDBCEEEEBAACBDBCEEEBAACBDBCEEEUHJRBAACBDBCEEEQBAACBDBCEEEBAACBDBCEEEBAACBDBCEEEBCBEAACBDEEQBAACBDBCEEEBCBEAACBDEEBAACBDBCEEEBCBAACBDEEEBCBEAACBDEEBAACBDBCEEEBCBAACBDEEEBCBAACBDEEEBAACBDBCEEEBAACBDBCEEEBCBAACBDEEEBAACBDBCEEEBAACBDBCEEEBAACBDBCEEEBAACBDBCEEEGBBAACBDBCEEAACBDBCEEBGAACBDBCEEGIFBAACBDBCEEEBCBEAACBDEEBCBAACBDEEEBAACBDBCEEEBBCEAACBDEEBCBEAACBDEEBAACBDBCEEEBBCAACBDEEEBBCEAACBDEEBBAACBDBCEEBCAACBDEEBGAACBDBCEEBCAEACBDEBCAACBDEEAACBDBCEEABCEACBDEBCAEACBDEAACBDBCEEABCACBDEEABCEACBDEAAACBDBCEBCACBDEAGACBDBCOIABCEACBDEABCACBDEEABCACBDLJFABCEBCAEACBDACBDABCOACBDGIFBCAACBDLFIBBCEAACBDEEBBCAACBDEEEBBCAACBDELJFBBCEBCBEAACBDEAACBDEBBCOAACBDEGIFBCBAACBDELFFBCBCBAACBDEEBAACBDEEBCGBAACBDEEGIFBCBEAACBDEEBCBAACBDEEEBCBAACBDELJFRBCBEAACBDEEBCBEQBCBEAACBDEUIBUOPPBAACBDBCEEEBAACBDBCEEEBAACBDBCEEEGRUJPBAACBDBCEEEUPPPPUQ $.

kore-equals-reflexivity $p |- ( \kore-valid ph0 ( \kore-equals ph1 ph0 ph2 ph2 ) ) $= 
    $(
        desugar "\kore-valid"
        desugar "\kore-equals"
        desugar "\kore-floor"
        desugar "\kore-not"
        apply "lemma-eq-1"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        desugar "\kore-ceil"
        apply "lemma-not-and-rewrite"
        apply "proof-rule-mp"
        apply "proof-rule-prop-1"
        apply "lemma-not-ceil-elim"
        desugar "\kore-iff"
        desugar "\kore-implies"
        desugar "\kore-not"
        desugar "\kore-or"
        desugar "\kore-and"
        apply "kore-equals-reflexivity-aux"
    $)
    ( not-is-pattern kore-top-is-pattern and-is-pattern kore-or-is-pattern kore-iff-is-pattern kore-not-is-pattern or-is-pattern kore-and-is-pattern kore-implies-is-pattern kore-ceil-is-pattern notation-symmetry notation-transitivity notation-reflexivity ceil-is-pattern kore-equals-is-pattern eq-is-pattern imp-is-pattern notation-not kore-floor-is-pattern notation-and notation-proof bot-is-pattern kore-and-is-sugar kore-or-is-sugar kore-not-is-sugar kore-ceil-is-sugar notation-eq kore-valid-is-pattern proof-rule-prop-1 notation-or kore-implies-is-sugar proof-rule-mp and-is-sugar not-is-sugar kore-equals-reflexivity-aux kore-iff-is-sugar lemma-not-ceil-elim lemma-not-and-rewrite lemma-eq-1 notation-ceil kore-floor-is-sugar kore-equals-is-sugar kore-valid-is-sugar ) BACCRAESABACCRUKBABCCHUBAESBACCRAESABABBCCHIMIAESBABCCHUBAESBABCCHDBEFMDAEFAESABABBCCHIMIAESBABCCHDBEFMDAEBABCCHDBEFMDAEBABCCHDBEFMDTBABCCHDBEFMDAEULBCCHDBEFQAEFDBABCCHDBEFMDBCCHDBEFQAEBCCHDBEFQDAEBCCHDBEFQDTBCCHDBEFQDAEULBCCHDBEFBBCCLBCCLKDBEFDBCCHDBEFDBBBCICGBBCICGKDBEFDBBCCLBCCLKDBEFDBBCDBEFCGBCDBEFCGKDBEFDBBBCICGBBCICGKDBEFDBCDBEFCJCDBEFCJKDBEFDBBCDBEFCGBCDBEFCGKDBEFDCDBEFCJCDBEFCJFDBEFDBCDBEFCJCDBEFCJKDBEFDBECURBCDBEFCJCDBEFCJKDBEFCDBEFCJCDBEFCJFDBEFBCDBEFCJCDBEFCJKDBECDBEFCJCDBEFCJFDBEBCDBEFCJCDBEFCJKCDBEFCJCDBEFCJFBCDBEFCJCDBEFCJKCDBEFCJCDBEFCJFCDBEFCJCDBEFCJFBCDBEFCJCDBEFCJUFCDBEFCJCDBEFCJFCDBEFCJCDBEFCJFCDBEFCJCDBEFCJFPNOUABEPUCUAUDBBCDBEFCGBCDBEFCGKDBEFBCDBEFCJCDBEFCJKDBEFBBCDBEFCGBCDBEFCGKDBEBCDBEFCJCDBEFCJKDBEBBCDBEFCGBCDBEFCGKBCDBEFCJCDBEFCJKBBCDBEFCGBCDBEFCGKBCDBEFCGBCDBEFCGFBCDBEFCJCDBEFCJKBBCDBEFCGBCDBEFCGUFBCDBEFCJCDBEFCJKBCDBEFCGBCDBEFCGFBCDBEFCJCDBEFCJKCDBEFCJCDBEFCJFBCDBEFCGBCDBEFCGFBCDBEFCJCDBEFCJUFBCDBEFCGBCDBEFCGFCDBEFCJCDBEFCJFBCDBEFCGBCDBEFCGCDBEFCJCDBEFCJBCDBEFCGCDBEFCJCDBEFCJBCDBEFCUGCDBEFCJCDBEFCJCDBEFCJPNOBCDBEFCGCDBEFCJCDBEFCJBCDBEFCUGCDBEFCJCDBEFCJCDBEFCJPNOUCNONOUABEPUCUAUDBBBCICGBBCICGKDBEFBBCDBEFCGBCDBEFCGKDBEFBBBCICGBBCICGKDBEBBCDBEFCGBCDBEFCGKDBEBBBCICGBBCICGKBBCDBEFCGBCDBEFCGKBBBCICGBBCICGKBBCICGBBCICGFBBCDBEFCGBCDBEFCGKBBBCICGBBCICGUFBBCDBEFCGBCDBEFCGKBBCICGBBCICGFBBCDBEFCGBCDBEFCGKBCDBEFCGBCDBEFCGFBBCICGBBCICGFBBCDBEFCGBCDBEFCGUFBBCICGBBCICGFBCDBEFCGBCDBEFCGFBBCICGBBCICGBCDBEFCGBCDBEFCGBBCICGBCICJBCDBEFCGBBCICUGBCDBEFCGBCICJBCDBEFCGCDBEFCJBCICJBCDBEFCUGBCICJCDBEFCJBCICCDBEFCBCICDBEFCDBEFBCUHCDBEFCDBEFCDBEFPNOCPUMNONOBBCICGBCICJBCDBEFCGBBCICUGBCDBEFCGBCICJBCDBEFCGCDBEFCJBCICJBCDBEFCUGBCICJCDBEFCJBCICCDBEFCBCICDBEFCDBEFBCUHCDBEFCDBEFCDBEFPNOCPUMNONOUCNONOUABEPUCUAUDBBCCLBCCLKDBEFBBBCICGBBCICGKDBEFBBCCLBCCLKDBEBBBCICGBBCICGKDBEBBCCLBCCLKBBBCICGBBCICGKBBCCLBCCLKBCCLBCCLFBBBCICGBBCICGKBBCCLBCCLUFBBBCICGBBCICGKBCCLBCCLFBBBCICGBBCICGKBBCICGBBCICGFBCCLBCCLFBBBCICGBBCICGUFBCCLBCCLFBBCICGBBCICGFBCCLBCCLBBCICGBBCICGBCCLBBCICGBBCICGBCCUNBBCICGBBCICGBBCICGPNOBCCLBBCICGBBCICGBCCUNBBCICGBBCICGBBCICGPNOUCNONOUABEPUCUAUDBCCHDBEFBBCCLBCCLKDBEFBCCHDBEBBCCLBCCLKDBEBCCHBBCCLBCCLKBCCHBBCCLBCCLKBBCCLBCCLKBCCUSBBCCLBCCLKBBCCLBCCLKBBCCLBCCLKPNOUABEPUCUAUDUTUOVABABCCHDBEFMBCCHDBEFQAEFBABCCHDBEFMBCCHDBEFQAEFBCCHDBEFQAEFBABCCHDBEFUIBCCHDBEFQAEFBCCHDBEFQAEFBCCHDBEFQAEFPNOUAUDUOVBABABBCCHIMIAEBABCCHDBEFMDAEFAEABABBCCHIMIBABBCCHIMDAEFBABCCHDBEFMDAEFABABBCCHIMUHBABCCHDBEFMDAEFBABBCCHIMDAEFBABCCHDBEFMDAEBABBCCHIMDAEBABCCHDBEFMBABBCCHIMBABCCHDBEFMBCCHDBEFQAEFBABBCCHIMBABCCHDBEFUIBABBCCHIMBCCHDBEFQAEFBABBCCHIMBBCCHIQAEFBCCHDBEFQAEFBABBCCHIUIBCCHDBEFQAEFBBCCHIQAEFBCCHDBEFQAEBBCCHIQAEBCCHDBEFBBCCHIBCCHDBEFBCCHDDBEDJDBBCCHIBCCHDBEUPBBCCHIBCCHDDBEDJDBBCCHIBCCHDBEFBCCHDDBEDJDBBCCHUHBCCHDDBEDJDBCCHDBEFBCCHDDBEDJDBCCHDDBEDJUETBCCHDBEFBCCHDDBEDJUQBCCHDBEFBCCHDDBEDJUETBCCHDBEFBCCHDDBEDJDBCCHDDBEDJUETBCCHDBEUPBCCHDDBEDJUETBCCHDDBEDJDBCCHDDBEDJDBCCHDDBEDJUETBCCHDDBEDJDBCCHDDBEDJUETBCCHDDBEDJUETBCCHDDBEDJUQBCCHDDBEDJUETBCCHDDBEDJUETBCCHDDBEDJUETPNONNONONONOVCAEPUCNONOUAAEPUCNOAEPUJUDBABCCHUBAEABABBCCHIMIAEBABCCHUBABABBCCHIMIABABBCCHIMIBABCCHVDABABBCCHIMIABABBCCHIMIABABBCCHIMIPNOAEPUJUDBACCRAEBABCCHUBAEBACCRBABCCHUBBABCCHUBBACCVEBABCCHUBBABCCHUBBABCCHUBPNOAEPUJUDABACCRUKBACCRAESBACCRAESABACCRVFBACCRAESBACCRAESBACCRAESPNOUD $.

${
    $d x y s0 $.
    $d y ph0 $.
    $d y ph1 $.
    $( variable x of sort ph0 is functional $)
    kore-variable-functional $p
        |- ( \imp ( \in-sort x ph0 ) ( \kore-valid ph1 ( \kore-exists ph0 ph1 y ( \kore-equals ph0 ph1 y x ) ) ) )
    $=
        $(
            apply "rule-imp-transitivity"
            meh
            apply "kore-exists-intro"
            apply "rule-imp-transitivity"
            meh
            apply "lemma-imp-compat-in-exists"
            apply "predicate-and-propagate-in-eq"
            apply "lemma-floor-is-predicate"
            apply "proof-rule-mp"
            apply "lemma-prenex-exists-imp-right"
            apply "fresh-disjoint"
            apply "proof-rule-mp"
            apply "proof-rule-exists"
            let $23 = "( \imp ( \in-sort x ph0 ) ( \and ( \in-sort x ph0 ) ( \eq ( \kore-equals ph0 ph1 x x ) ( \kore-top ph1 ) ) ) )", $28 = "x"
            substitution
            apply "rule-and-intro-alt2-sugar"
            apply "imp-reflexivity"
            apply "rule-weakening"
            apply "kore-equals-reflexivity"
        $)
        ( element-var-is-var var-is-pattern kore-equals-is-pattern in-sort-is-pattern kore-top-is-pattern and-is-pattern eq-is-pattern exists-is-pattern imp-is-pattern inh-is-pattern kore-exists-is-pattern kore-valid-is-pattern substitution-disjoint notation-transitivity notation-reflexivity floor-is-pattern notation-proof sorted-exists-is-pattern substitution-in-sort substitution-var-same kore-valid-is-sugar notation-symmetry proof-rule-mp is-predicate-is-pattern rule-imp-transitivity fresh-disjoint lemma-prenex-exists-imp-right substitution-kore-equals substitution-kore-top substitution-eq substitution-and substitution-imp proof-rule-exists imp-reflexivity kore-equals-reflexivity rule-weakening rule-and-intro-alt2-sugar lemma-floor-is-predicate included-is-pattern in-sort-is-sugar included-is-sugar notation-is-predicate predicate-and-propagate-in-eq lemma-imp-compat-in-exists kore-exists-intro kore-exists-is-sugar sorted-exists-is-sugar kore-top-is-sugar notation-and notation-eq notation-imp ) CEFAHDEFAHABDEFCEFGJBIKDLBABABDEFCEFGDOPCEFAHDEFAHABDEFCEFGBIKJDLDEFAHABDEFCEFGJBIKDLCEFAHDEFAHABDEFCEFGBIKJMDLCEFAHDEFAHABDEFCEFGBIKJDLMCEFAHDEFAHABDEFCEFGBIKJDCEFAHDEUJUKCEFAHCEFAHABCEFCEFGBIKJMCEFAHDEFAHABDEFCEFGBIKJMDLCEFAHCEFAHABCEFCEFGBIKJMCEFAHDEFAHABDEFCEFGBIKJMDCCEFCEFAHCEFAHABCEFCEFGBIKJCEFAHDEFAHABDEFCEFGBIKJDECEFCEFACEFADECEFCEFDEQACEFDEQUCCEFCEFAHABCEFCEFGBIKDEFAHABDEFCEFGBIKDECEFCEFADEFADECEFDEUDACEFDEQUCCEFABCEFCEFGBIABDEFCEFGBIDEABCEFCEFABDEFCEFCEFDEACEFDEQBCEFDEQCEFDEUDCEFCEFDEQULBBCEFDEBCEFDEQUMUNUOUPUQCEFAHCEFAHABCEFCEFGBIKCEFAHURCEFAHABCEFCEFGBIKBABCEFCEFGPABCEFCEFGBIKBACEFUSABCEFCEFGBIKABCEFCEFGBIKBABCEFCEFGPABCEFCEFGBIKSBABCEFCEFGPABCEFCEFGBIKBABCEFCEFGUEUFRUAUTVAUGUGDEFAHABDEFCEFGBIKJDEFAHABDEFCEFGJBIKDDEFAHABDEFCEFGBIDEFANMTUHDEFAHUHDEFANMVBDEFAHDEFANMTDEFAHDEFANMTDEFANMTDEFAHDEFANVCDEFANMTDEFAVDDEFANVERDEFANMTSRVFUAVGVHUIDEFAHABDEFCEFGJBIKDLDEFAHABDEFCEFGJDLBIJBIKMDEFAHABDEFCEFGJBIKDLBABABDEFCEFGDOPMDEFAHABDEFCEFGJBIDVIDEFAHABDEFCEFGJBIKDLBABABDEFCEFGDOPDEFAHABDEFCEFGJBIKDLDEFAHABDEFCEFGJDLBIJBIKDEFAHABDEFCEFGJBIKDLSBABABDEFCEFGDOPABABDEFCEFGDOBIKDEFAHABDEFCEFGJDLBIJBIKBABABDEFCEFGDOUEABABDEFCEFGDOBIDEFAHABDEFCEFGJDLBIJBIABABDEFCEFGDOAABDEFCEFGDUBBNJDEFAHABDEFCEFGJDLBIJABABDEFCEFGDVJAABDEFCEFGDUBBNDEFAHABDEFCEFGJDLBIAABDEFCEFGDUBDEFAHABDEFCEFGJDLDEFAHABDEFCEFGJDLAABDEFCEFGDVKDEFAHABDEFCEFGJDLSRBNBNBIBNSBIBNBVLUFRVMRBISVNRVOUAUI $.
$}

${
    $d y x $.
    $d y ph0 $.
    $d y ph1 $.
    $d x ph2 $.
    kore-functional-lemma $p
        |- ( \imp ( \floor ph2 )
           ( \imp ( \eq ( \and ( \exists x ph1 ) ph0 ) ph0 )
                  ( \eq ( \and ( \exists x ( \and ( \floor ph2 ) ph1 ) ) ph0 ) ph0 ) ) )
    $=
        $(
            apply "proof-rule-mp"
            meh
            apply "lemma-floor-is-predicate", ph0 = "ph2"
            apply "rule-or-elim"
            meh
            apply "weakened-mp"
            apply "rule-imp-transitivity"
            apply "eq-symmetry"
            apply "eq-elim", ph4 = "( \imp y ( \imp ( \eq ( \and ( \exists x ph1 ) ph0 ) ph0 ) ( \eq ( \and ( \exists x ( \and y ph1 ) ) ph0 ) ph0 ) ) )", ph2 = "( \imp \bot ( \imp ( \eq ( \and ( \exists x ph1 ) ph0 ) ph0 ) ( \eq ( \and ( \exists x ( \and \bot ph1 ) ) ph0 ) ph0 ) ) )", x = "y"
            substitution
            substitution
            apply "rule-weakening"
            apply "bot-elim"
            apply "rule-imp-transitivity"
            apply "eq-symmetry"
            apply "weakened-mp"
            apply "eq-elim", ph4 = "( \imp y ( \imp ( \eq ( \and ( \exists x ph1 ) ph0 ) ph0 ) ( \eq ( \and ( \exists x ( \and y ph1 ) ) ph0 ) ph0 ) ) )", ph2 = "( \imp \top ( \imp ( \eq ( \and ( \exists x ph1 ) ph0 ) ph0 ) ( \eq ( \and ( \exists x ( \and \top ph1 ) ) ph0 ) ph0 ) ) )", x = "y"
            substitution
            substitution
            apply "rule-weakening"
            apply "rule-weakening"
            apply "rule-iff-elim-left"
            apply "rule-iff-compat-in-eq"
            apply "rule-iff-compat-in-and"
            apply "rule-iff-compat-in-exists"
            apply "rule-iff-intro"
            apply "rule-and-intro-alt2-sugar"
            apply "rule-weakening"
            apply "top-intro"
            apply "imp-reflexivity"
            apply "and-elim-right"
            apply "iff-reflexivity"
            apply "iff-reflexivity"
        $)
        ( and-is-pattern floor-is-pattern exists-is-pattern imp-is-pattern eq-is-pattern y-is-element-var element-var-is-var bot-is-pattern top-is-pattern var-is-pattern not-is-pattern substitution-disjoint is-top-is-pattern is-bot-is-pattern notation-reflexivity substitution-and notation-transitivity notation-imp substitution-var-same substitution-exists-alt substitution-eq substitution-imp or-is-pattern is-predicate-is-pattern not-is-sugar notation-proof rule-weakening eq-symmetry eq-elim or-is-sugar iff-reflexivity weakened-mp rule-imp-transitivity is-top-is-sugar top-intro imp-reflexivity rule-and-intro-alt2-sugar and-elim-right and-is-sugar rule-iff-intro rule-iff-compat-in-exists rule-iff-compat-in-and rule-iff-compat-in-eq rule-iff-elim-left is-bot-is-sugar bot-elim rule-or-elim is-predicate-is-sugar lemma-floor-is-predicate proof-rule-mp ) CFUHCFBDGAEAICFBEDGAEAIHHCFQLHCFRHCFBDGAEAICFBEDGAEAIHHHCFUHCFBDGAEAICFBEDGAEAIHHHCFQCFRCFBDGAEAICFBEDGAEAIHHCFQMCFICFBDGAEAICFBEDGAEAIHHCFMIMCFIHCFQMCFIHMCFULCFQMCFICFMIMCFICFQCFMICFMICFURCFMISUAMCFISUBUJMCFIMBDGAEAIMBEDGAEAIHHCFBDGAEAICFBEDGAEAIHHMCFMBDGAEAIMBEDGAEAIHHCFBDGAEAICFBEDGAEAIHHJKNBDGAEAIJKNBEDGAEAIHHJMMBDGAEAIMBEDGAEAIHJKNBDGAEAIJKNBEDGAEAIHJKMJKUCMBDGAEAIMBEDGAEAIBDGAEAIJKNBEDGAEAIJKMBDGAEABDGAEAJKMBDGABDGAJKBBMDJKBMJKPUDAMJKPTAMJKPUEMMBEDGAEAJKNBEDGAEAJKMMBEDGAJKNBEDGAJKMBEJKNBEMDJKMMBJKNBJKMJKUCBMJKPTUDAMJKPTAMJKPUEUFUFCFCFBDGAEAICFBEDGAEAIHJKNBDGAEAIJKNBEDGAEAIHJKCFJKUCCFBDGAEAICFBEDGAEAIBDGAEAIJKNBEDGAEAIJKCFBDGAEABDGAEAJKCFBDGABDGAJKBBCFDJKBCFJKPUDACFJKPTACFJKPUECFCFBEDGAEAJKNBEDGAEAJKCFCFBEDGAJKNBEDGAJKCFBEJKNBECFDJKCFCFBJKNBJKCFJKUCBCFJKPTUDACFJKPTACFJKPUEUFUFUMMCFIMBDGAEAIMBEDGAEAIHHMBDGAEAIMBEDGAEAIHBDGAEAIMBEDGAEAIBDGAEAMBEDGAEABDGMBEDGAABMBEDBMBEBMBBMUSUKBUTVAMLHLHBLHHLHBHMBEBHMBVBMBEBMLHLHBLHHLHBMBEMOBOUGLHMLHLHBLHHLHMBEMOBOUGOMOBOUGLHMBVCMOBOUGUIUAMOBOUGLMLHLHBLHHLMOBOUGMOOBOHMLHLHBLHHMOBOUNMOOBOMLHLHBLHMOOMOLHMLHLHMOUIMOLMLHLMOMLHMLHMUIMLHSUALSUBUABOBLHBLHBUIBLHSUAUBUALSUBUABSUBUJVDVEAUOVFAUOVGVHUKUKUPUQCFRLBDGAEAILBEDGAEAIHHCFBDGAEAICFBEDGAEAIHHCFRLCFILBDGAEAILBEDGAEAIHHCFBDGAEAICFBEDGAEAIHHHCFLILCFIHCFRLCFIHLCFULCFRLCFICFLILCFICFRCFLICFLICFVICFLISUALCFISUBUJLCFLBDGAEAILBEDGAEAIHHCFBDGAEAICFBEDGAEAIHHJKNBDGAEAIJKNBEDGAEAIHHJLLBDGAEAILBEDGAEAIHJKNBDGAEAIJKNBEDGAEAIHJKLJKUCLBDGAEAILBEDGAEAIBDGAEAIJKNBEDGAEAIJKLBDGAEABDGAEAJKLBDGABDGAJKBBLDJKBLJKPUDALJKPTALJKPUELLBEDGAEAJKNBEDGAEAJKLLBEDGAJKNBEDGAJKLBEJKNBELDJKLLBJKNBJKLJKUCBLJKPTUDALJKPTALJKPUEUFUFCFCFBDGAEAICFBEDGAEAIHJKNBDGAEAIJKNBEDGAEAIHJKCFJKUCCFBDGAEAICFBEDGAEAIBDGAEAIJKNBEDGAEAIJKCFBDGAEABDGAEAJKCFBDGABDGAJKBBCFDJKBCFJKPUDACFJKPTACFJKPUECFCFBEDGAEAJKNBEDGAEAJKCFCFBEDGAJKNBEDGAJKCFBEJKNBECFDJKCFCFBJKNBJKCFJKUCBCFJKPTUDACFJKPTACFJKPUEUFUFUMUQCFRLBDGAEAILBEDGAEAIHHBDGAEAILBEDGAEAIHVJUKUPVKCFUHCFBDGAEAICFBEDGAEAIHHCFQLHCFRHCFBDGAEAICFBEDGAEAIHHCFUHCFQOCFRHCFQLHCFRHCFUHCFQCFRUGCFQOCFRHCFVLCFQCFRUNUACFQOCFRCFQLHCFRCFQOCFQLHCFQLHCFQUICFQLHSUACFRSUBUACFBDGAEAICFBEDGAEAIHHSUBUJCVMVN $.
$}

${
    $d x ph0 $.
    $d x ph1 $.
    kore-functional.0 $e |- ( \imp th0 ( \in-sort ph1 ph0 ) ) $.
    kore-functional.1 $e |- ( \imp th0 ( \kore-valid \unit-sort ( \kore-exists ph0 \unit-sort x ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ) $.
    kore-functional   $p |- ( \imp th0 ( \exists x ( \eq x ph1 ) ) ) $=
        $(
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "weakening-imp2"
            apply "nonempty-predicate-is-top"
            apply "unit-sort-nonempty-alt"
            apply "rule-predicate-intro-exists"
            apply "lemma-floor-is-predicate"
            apply "rule-imp-transitivity"
            meh
            apply "eq-symmetry"
            apply "rule-imp-transitivity"
            meh
            let $18 = "( \eq ( \and ( \exists x ( \and ( \eq x ph1 ) ( \inh \unit-sort ) ) ) ( \inh \unit-sort ) ) ( \inh \unit-sort ) )"
            apply "rule-iff-elim-left"
            apply "rule-iff-compat-in-eq"
            apply "rule-iff-transitivity"
            apply "rule-iff-compat-in-and"
            apply "rule-iff-symmetry"
            apply "prenex-exists-and"
            apply "fresh-in-app"
            apply "fresh-in-symbol"
            apply "fresh-in-symbol"
            apply "iff-reflexivity"
            apply "rule-iff-transitivity"
            apply "and-associativity"
            apply "rule-iff-compat-in-and"
            apply "iff-reflexivity"
            apply "and-idempotency"
            apply "iff-reflexivity"
            apply "rule-imp-transitivity"
            meh
            apply "imp-compat-in-eq-and"
            apply "lemma-imp-compat-in-exists"
            claim "|- ( \imp ( \and ( \in-sort ph1 ph0 ) ( \and ( \in-sort x ph0 ) ( \kore-equals ph0 \unit-sort x ph1 ) ) ) ( \and ( \eq x ph1 ) ( \inh \unit-sort ) ) )"
            meh
            apply "claim-0"
            apply "rule-imp-transitivity"
            meh
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "proof-rule-mp"
            apply "weakening-imp3"
            apply "kore-functional-lemma"
            apply "kore-functional.0"
            apply "kore-functional.1"
            meh
            apply "imp-reflexivity"
            apply "rule-imp-transitivity"
            apply "rule-iff-elim-right"
            apply "and-associativity"
            apply "rule-uncurry"
            apply "rule-uncurry"
            apply "premises-switch"
            apply "rule-curry"
            apply "weakened-mp"
            meh
            apply "rule-imp-transitivity"
            meh
            apply "lemma-floor-elim-alt"
            meh
            apply "kore-semantics-equals"
            apply "rule-weakening"
            apply "and-elim-left"
        $)
        ( symbol-is-pattern unit-sort-is-symbol element-var-is-var var-is-pattern inh-is-pattern and-is-pattern eq-is-pattern imp-is-pattern kore-equals-is-pattern in-sort-is-pattern exists-is-pattern floor-is-pattern bot-is-pattern not-is-pattern iff-is-pattern notation-reflexivity notation-transitivity kore-exists-is-pattern notation-imp or-is-pattern notation-proof notation-symmetry rule-imp-transitivity inhabitant-is-symbol proof-rule-mp kore-top-is-pattern sorted-exists-is-pattern kore-valid-is-pattern not-is-sugar app-is-pattern notation-and iff-reflexivity is-predicate-is-pattern eq-is-sugar included-is-pattern in-sort-is-sugar included-is-sugar notation-eq and-associativity rule-uncurry fresh-in-symbol rule-iff-compat-in-and rule-iff-transitivity weakening-imp2 unit-sort-nonempty-alt lemma-floor-is-predicate notation-is-predicate rule-predicate-intro-exists nonempty-predicate-is-top imp-reflexivity weakening-imp3 kore-functional-lemma notation-exists sorted-exists-is-sugar kore-exists-is-sugar kore-top-is-sugar kore-valid-is-sugar rule-iff-elim-right and-elim-left iff-is-sugar and-is-sugar or-is-sugar rule-weakening kore-semantics-equals lemma-floor-elim-alt weakened-mp rule-curry premises-switch lemma-imp-compat-in-exists imp-compat-in-eq-and fresh-in-app inh-is-sugar notation-fresh prenex-exists-and rule-iff-symmetry and-idempotency rule-iff-compat-in-eq rule-iff-elim-left eq-symmetry ) CHGKDIJBMDQHGKLMNCDIJBMDQNHGKDIJBMDQHGKLMDIJBMDQNCHGKDIJBMDQHGKLMNCDIJBMDQNNHGKDIJBMDQHGKLMDIJBMDQCVJHGKDIJBMDQVKDIJBMDDIJBUARUSDIJBMUSDIJBUAVLDIJBMDIJBUARDIJBMDIJBUARDIJBUARDIJBUTDIJBUARUBUCVMUGVNVOUKCDIJBMDQHGKLHGKMHGKDIJBMDQHGKLMCDIJBMHGKLDQHGKLHGKMDIJBMDQHGKLHGKMCBAPDIJAPAHGDIJBOLLDQHGKLHGKMDIJBMHGKLDQHGKLHGKMCCBAPDIJAPAHGDIJBOLLDQHGKLHGKMCVPCDIJAPAHGDIJBOLDQHGKLHGKMNCBAPDIJAPAHGDIJBOLLDQHGKLHGKMNCBAKNRNCDIJAPAHGDIJBOLDQHGKLHGKMNCBAPDIJAPAHGDIJBOLLDQHGKLHGKMNNBAKNRDIJAPAHGDIJBOLDQHGKLHGKMBAPDIJAPAHGDIJBOLLDQHGKLHGKMNNCBAKNRNCDIJAPAHGDIJBOLDQHGKLHGKMNCBAPDIJAPAHGDIJBOLLDQHGKLHGKMNNNBAKNRDIJAPAHGDIJBOLDQHGKLHGKMBAPDIJAPAHGDIJBOLLDQHGKLHGKMCVQBAKNRDIJAPAHGDIJBOLDQHGKLHGKMBAKNRDIJAPAHGDIJBOLLDQHGKLHGKMNNBAKNRDIJAPAHGDIJBOLDQHGKLHGKMBAPDIJAPAHGDIJBOLLDQHGKLHGKMNNHGKDIJAPAHGDIJBOLBAKNDVRBAKNRDIJAPAHGDIJBOLDQHGKLHGKMBAPDIJAPAHGDIJBOLLDQHGKLHGKMNBAKNRDIJAPAHGDIJBOLDQHGKLHGKMBAKNRDIJAPAHGDIJBOLLDQHGKLHGKMNBAKNRUBDIJAPAHGDIJBOLDQHGKLHGKMBAPDIJAPAHGDIJBOLLDQHGKLHGKMDIJAPAHGDIJBOLDQHGKLHGKMBAKNRDIJAPAHGDIJBOLLDQHGKLHGKMDIJAPAHGDIJBOLDQHGKLHGKMUBBAPDIJAPAHGDIJBOLLDQHGKLHGKBAKNRDIJAPAHGDIJBOLLDQHGKLHGKBAPDIJAPAHGDIJBOLLDQHGKBAKNRDIJAPAHGDIJBOLLDQHGKBAPDIJAPAHGDIJBOLLBAKNRDIJAPAHGDIJBOLLDBAPDIJAPAHGDIJBOLBAKNRDIJAPAHGDIJBOLBAPBAKNRBAKNRBAPBAKVABAKNRBAVBBAKVCUCBAKNRUBUCDIJAPAHGDIJBOLUBUQVSHGKUBUQHGKUBVDUEUEUGUKCBAPNCBAKNRNECBAKNRCBAPCUBBAKNRBAKNRBAPBAKNRUBBAPBAKNRBAPBAKVABAKNRBAVBBAKVCUCUHUCUEUGUKCHGAHGAHGDIJBODUDUNNCDIJAPAHGDIJBOLDQHGKLHGKMNFCDIJAPAHGDIJBOLDQHGKLHGKMCHGAHGAHGDIJBODUDUNCUBDIJAPAHGDIJBOLDQHGKLHGKMAHGAHGDIJBODUDHGULMHGAHGAHGDIJBODUDUNDIJAPAHGDIJBOLDQHGKLHGKAHGAHGDIJBODUDHGULDIJAPAHGDIJBOLDQHGKLAAHGDIJBODUMHGKLAHGAHGDIJBODUDDIJAPAHGDIJBOLDQHGKAAHGDIJBODUMHGKDIJAPAHGDIJBOLDQDIJAPAHGDIJBOLDQAAHGDIJBODUMDIJAPAHGDIJBOLDQUBAAHGDIJBODUMDIJAPAHGDIJBOLDQAAHGDIJBODVTUHUCHGKUBUQAHGAHGDIJBODUDAAHGDIJBODUMHGKLAHGAHGDIJBODWAUHUCHGKHGKHGULHGKUBHGULHGKHGWBUHUCVDHGAHGAHGDIJBODUDUNAHGAHGDIJBODUDHGULMHGAHGAHGDIJBODUDWCUHUCUEUGUKUIBAPDIJAPAHGDIJBOLLDQDIJBMHGKLDQHGKBAPDIJAPAHGDIJBOLLDIJBMHGKLDBAPDIJAPAHGDIJBOLLBAPDIJAPLAHGDIJBOLDIJBMHGKLBAPDIJAPLAHGDIJBOLBAPDIJAPAHGDIJBOLLBAPDIJAPAHGDIJBOVEWDBAPDIJAPLAHGDIJBODIJBMHGKLBAPDIJAPAHGDIJBODIJBMHGKLNDIJAPBAPAHGDIJBODIJBMHGKLNDIJAPBAPAHGDIJBODIJBMHGKLNDIJAPBAPLAHGDIJBODIJBMHGKLUAAHGDIJBODIJBMHGKLNDIJAPBAPLAHGDIJBODIJBMHGKLUAAHGDIJBODIJBMHGKLNNAHGDIJBODIJBMHGKLNSNSNDIJBMHGKLAHGDIJBONSNNSNAHGDIJBODIJBMHGKLNNAHGDIJBODIJBMHGKLUAAHGDIJBODIJBMHGKLNNAHGDIJBODIJBMHGKLNDIJBMHGKLAHGDIJBONWEAHGDIJBODIJBMHGKLUAAHGDIJBODIJBMHGKLNAHGDIJBODIJBMHGKLNSNSNDIJBMHGKLAHGDIJBONSNNSNAHGDIJBODIJBMHGKLNAHGDIJBODIJBMHGKLUAAHGDIJBODIJBMHGKLNTDIJBMHGKLAHGDIJBONTUFSNAHGDIJBODIJBMHGKLNSNSNDIJBMHGKLAHGDIJBONSNNSNAHGDIJBODIJBMHGKLUAAHGDIJBODIJBMHGKLNTDIJBMHGKLAHGDIJBONTUFTAHGDIJBODIJBMHGKLNTDIJBMHGKLAHGDIJBONTUFSNAHGDIJBODIJBMHGKLUAAHGDIJBODIJBMHGKLNDIJBMHGKLAHGDIJBONLAHGDIJBODIJBMHGKLNTDIJBMHGKLAHGDIJBONTUFTAHGDIJBODIJBMHGKLWFAHGDIJBODIJBMHGKLNDIJBMHGKLAHGDIJBONWGUCAHGDIJBODIJBMHGKLNTDIJBMHGKLAHGDIJBONTUFUOUCAHGDIJBODIJBMHGKLNTDIJBMHGKLAHGDIJBONTUFSAHGDIJBODIJBMHGKLNSNSNDIJBMHGKLAHGDIJBONSNNSAHGDIJBODIJBMHGKLNTDIJBMHGKLAHGDIJBONTUFAHGDIJBODIJBMHGKLNTTDIJBMHGKLAHGDIJBONTNAHGDIJBODIJBMHGKLNSNSNDIJBMHGKLAHGDIJBONSNNAHGDIJBODIJBMHGKLNTDIJBMHGKLAHGDIJBONTWHAHGDIJBODIJBMHGKLNTTDIJBMHGKLAHGDIJBONTAHGDIJBODIJBMHGKLNSNSNDIJBMHGKLAHGDIJBONSNAHGDIJBODIJBMHGKLNTTAHGDIJBODIJBMHGKLNTSNAHGDIJBODIJBMHGKLNSNSNAHGDIJBODIJBMHGKLNTUOAHGDIJBODIJBMHGKLNTSAHGDIJBODIJBMHGKLNSNSAHGDIJBODIJBMHGKLNTAHGDIJBODIJBMHGKLNSNAHGDIJBODIJBMHGKLNSNAHGDIJBODIJBMHGKLNUOAHGDIJBODIJBMHGKLNSNUBUCSUBUEUCDIJBMHGKLAHGDIJBONTDIJBMHGKLAHGDIJBONSNDIJBMHGKLAHGDIJBONSNDIJBMHGKLAHGDIJBONUODIJBMHGKLAHGDIJBONSNUBUCUEUCSUBUEUCAHGDIJBODIJBMHGKLNUBUEUGWIDIJAPBAPLAHGDIJBODIJBMHGKLUARAHGDIJBODIJBMHGKLUADIJAPBAPLAHGDIJBODIJBMHGKLMNDIJAPBAPLAHGDIJBODIJBMHGKLUARNAHGDIJBWJDIJAPBAPLAHGDIJBODIJBMHGKLUARDIJAPBAPLAHGDIJBODIJBMHGKLMDIJAPBAPLUBAHGDIJBODIJBMHGKLUARAHGDIJBODIJBMHGKLUARAHGDIJBODIJBMHGKLMAHGDIJBODIJBMHGKLUARUBAHGDIJBODIJBMHGKLMAHGDIJBODIJBMHGKLUARAHGDIJBODIJBMHGKLUTUHUCUEUGAHGDIJBODIJBMHGKLUAWKUIWLWMWNVFVFUIWOWPUIDIJBMHGKLDQHGKLHGKMDIJBMDQHGKLHGKMDIJBMHGKLDQHGKLHGKDIJBMDQHGKLHGKDIJBMHGKLDQHGKLDIJBMDQHGKLHGKLDIJBMDQHGKLDIJBMHGKLDQDIJBMDQHGKLHGKHGKDIJBMDQHGKLDIJBMHGKLDQDIJBMHGKDUJGHGUPHGKDIUJGHGDIDIUJVGDIHVGWQHGKUJGHGUPUJGHGUPHGWRUJGHGUPUBUCWSWTXAHGKURVHDIJBMDQHGKLHGKLDIJBMDQHGKHGKLLDIJBMDQHGKLDIJBMDQHGKHGKVEDIJBMDQDIJBMDQHGKHGKLHGKDIJBMDQURHGKXBVHVIVIHGKURXCXDUIHGKDIJBMDQHGKLXEUIUK $.
$}

${
    kore-forall-prenex-implies-left.0 $e #Fresh x ph1 $.
    kore-forall-prenex-implies-left   $p |- ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-implies ph0 ph1 ( \kore-forall ph3 ph0 x ph2 ) ) ( \kore-forall ph3 ph0 x ( \kore-implies ph0 ph1 ph2 ) ) ) ) $= ? $.
$}

${
    kore-forall-prenex-implies-right.0 $e #Fresh x ph1 $.
    kore-forall-prenex-implies-right   $p |- ( \kore-valid ph0 ( \kore-implies ph0 ( \kore-forall ph3 ph0 x ( \kore-implies ph0 ph1 ph2 ) ) ( \kore-implies ph0 ph1 ( \kore-forall ph3 ph0 x ph2 ) ) ) ) $= ? $.
$}
