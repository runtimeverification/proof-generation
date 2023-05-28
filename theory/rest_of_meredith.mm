$( Step 4 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 14-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem2 $p |- ( ( ( ph \imp ph ) \imp ch ) \imp ( th \imp ch ) ) $=
( imp-is-pattern not-is-pattern merlem1 proof-rule-meredith proof-rule-mp ) BBDZAECEZDDADAADZDKBDCBDDAJIAFBBACKGH
$.

$( Step 7 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 14-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem3 $p |- ( ( ( ps \imp ch ) \imp ph ) \imp ( ch \imp ph ) ) $=
( imp-is-pattern not-is-pattern merlem2 proof-rule-mp proof-rule-meredith ) AADZCEZJDZDZCDBCDZDZMADCADZDOBEZPDDBDZL
DZNKKDLDRJKIFKLQFGCABBLHGAACCMHG $.

$( Step 8 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 14-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem4 $p |- ( ta \imp ( ( ta \imp ph ) \imp ( th \imp ph ) ) ) $=
( imp-is-pattern not-is-pattern proof-rule-meredith merlem3 proof-rule-mp ) AADBEZIDDBDZCDCADBADDZDCKDAABBCFKJCGH
$.

$( Step 11 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 14-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem5 $p |- ( ( ph \imp ps ) \imp ( \not \not ph \imp ps ) ) $=
( imp-is-pattern not-is-pattern proof-rule-meredith merlem1 merlem4 proof-rule-mp ) BBCZBDZJCCBCBCIICCZABCZADZDZBCC
ZBBBBBEIJNDCCBCZACZOCZKOCZBBBNAEOKDZCMTCCZACQCZRSCUAUBMBLTFAPUAGHOTAKQEHHH
$.

$( Step 12 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 14-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem6 $p |- ( ch \imp ( ( ( ps \imp ch ) \imp ph ) \imp ( th \imp ph ) ) ) $=
( imp-is-pattern merlem4 merlem3 proof-rule-mp ) BCEZIAEDAEEZECJEADIFJBCGH $.

$( Between steps 14 and 15 of Meredith's proof of Lukasiewicz axioms from his
    sole axiom.  (Contributed by NM, 22-Dec-2002.)
    (Proof modification is discouraged.)  (New usage is discouraged.) $)
merlem7 $p |- ( ph \imp ( ( ( ps \imp ch ) \imp th ) \imp ( ( ( ch \imp ta ) \imp
                ( \not th \imp \not ps ) ) \imp th ) ) ) $=
( imp-is-pattern not-is-pattern merlem4 merlem6 proof-rule-meredith proof-rule-mp ) BCFZLDFZCEFDGBGFFZDFZFZFZAPFZDN
LHPAGZFCGZSFFZCFLFZQRFOUAFUBSMOTICEDBUAJKPSCALJKK $.

$( Step 15 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem8 $p |- ( ( ( ps \imp ch ) \imp th ) \imp ( ( ( ch \imp ta ) \imp
                ( \not th \imp \not ps ) ) \imp th ) ) $=
( wph imp-is-pattern not-is-pattern proof-rule-meredith merlem7 proof-rule-mp ) EEFZEGZLFFEFEFKKFFZABFCFBDFCGAGFFCF
FEEEEEHMABCDIJ $.

$( Step 18 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem9 $p |- ( ( ( ph \imp ps ) \imp ( ch \imp ( th \imp ( ps \imp ta ) ) ) ) \imp
                ( et \imp ( ch \imp ( th \imp ( ps \imp ta ) ) ) ) ) $=
( imp-is-pattern not-is-pattern merlem6 merlem8 proof-rule-mp proof-rule-meredith ) CDBEGZGZGZFHZGBHZPGGZBGABGZGZSO
GFOGGMRHDHGZHAHGZGUAGRGZTNRGUCPCNQIDMRUBJKBEUAARLKOPBFSLK $.

$( Step 19 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 14-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem10 $p |- ( ( ph \imp ( ph \imp ps ) ) \imp ( th \imp ( ph \imp ps ) ) ) $=
( imp-is-pattern not-is-pattern proof-rule-meredith merlem9 proof-rule-mp ) AADZAEZJDDADADIIDDZAABDZDZCLDDZAAAAAFLA
DJCEDDADZADNDKNDLAACAFOAMCBKGHH $.

$( Step 20 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 14-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem11 $p |- ( ( ph \imp ( ph \imp ps ) ) \imp ( ph \imp ps ) ) $=
( imp-is-pattern not-is-pattern proof-rule-meredith merlem10 proof-rule-mp ) AACZADZICCACACHHCCZAABCZCZKCZAAAAAELMC
JMCABLFLKJFGG $.

$( Step 28 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 14-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem12 $p |- ( ( ( th \imp ( \not \not ch \imp ch ) ) \imp ph ) \imp ph ) $=
( not-is-pattern imp-is-pattern merlem5 merlem2 proof-rule-mp merlem4 merlem11 ) CBDDBEZEZAEZMAEZEZNLOBBEKE
LBBFBKCGHAMLIHMAJH $.

$( Step 35 of Meredith's proof of Lukasiewicz axioms from his sole axiom.
    (Contributed by NM, 14-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
merlem13 $p |- ( ( ph \imp ps ) \imp
            ( ( ( th \imp ( \not \not ch \imp ch ) ) \imp \not \not ph ) \imp ps ) ) $=
( imp-is-pattern not-is-pattern merlem12 merlem5 proof-rule-mp merlem6 proof-rule-meredith merlem11 ) BBEZAFZDCFFCE
EZNFZEZFZEZEAEZAEZABEQBEETUAEZUASUBOREZREZSRCDGRBEZRFPEZEREUCEZUDSEUFUGQPEU
FPCDGQPHIRUEUFOJIRBRNUCKIIAMSTJITALIBBAQAKI $.

$( 1 of 3 axioms for propositional calculus due to Lukasiewicz, derived from
    Meredith's sole axiom.  (Contributed by NM, 14-Dec-2002.)
    (Proof modification is discouraged.)  (New usage is discouraged.) $)
luk-1 $p |- ( ( ph \imp ps ) \imp ( ( ps \imp ch ) \imp ( ph \imp ch ) ) ) $=
( imp-is-pattern not-is-pattern proof-rule-meredith merlem13 proof-rule-mp ) CCDZAEZEZEJDDKDBDZBCDACDDZDZABDZMDZCCK
ABFMADZOEZEZERDDSDLDZNPDOLDTABJIGOLRQGHMASOLFHH $.

$( 2 of 3 axioms for propositional calculus due to Lukasiewicz, derived from
    Meredith's sole axiom.  (Contributed by NM, 14-Dec-2002.)
    (Proof modification is discouraged.)  (New usage is discouraged.) $)
luk-2 $p |- ( ( \not ph \imp ph ) \imp ph ) $=
( not-is-pattern imp-is-pattern merlem5 merlem4 proof-rule-mp merlem11 proof-rule-meredith ) ABZACZJACZCZKAJBZCIBMC
CZICZICZLOPCZPNQAMDIONEFOIGFAMIJIHFJAGF $.

$( 3 of 3 axioms for propositional calculus due to Lukasiewicz, derived from
    Meredith's sole axiom.  (Contributed by NM, 14-Dec-2002.)
    (Proof modification is discouraged.)  (New usage is discouraged.) $)
luk-3 $p |- ( ph \imp ( \not ph \imp ps ) ) $=
( not-is-pattern imp-is-pattern merlem11 merlem1 proof-rule-mp ) ACZHBDZDIDAIDHBEABHIFG $.

$(
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
    Derive the standard axioms from the Lukasiewicz axioms
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
$)

${
luklem1.1 $e |- ( ph \imp ps ) $.
luklem1.2 $e |- ( ps \imp ch ) $.
$( Used to rederive standard propositional axioms from Lukasiewicz'.
    (Contributed by NM, 23-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
luklem1 $p |- ( ph \imp ch ) $=
    ( imp-is-pattern luk-1 proof-rule-mp ) BCFZACFZEABFIJFDABCGHH $.
$}

$( Used to rederive standard propositional axioms from Lukasiewicz'.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
luklem2 $p |- ( ( ph \imp \not ps ) \imp
            ( ( ( ph \imp ch ) \imp th ) \imp ( ps \imp th ) ) ) $=
( not-is-pattern imp-is-pattern luk-1 luk-3 proof-rule-mp luklem1 ) ABEZFZBACFZFZMDFBDFFLKCFZMFZNAKCGBOFPNF
BCHBOMGIJBMDGJ $.

$( Used to rederive standard propositional axioms from Lukasiewicz'.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
luklem3 $p |- ( ph \imp ( ( ( \not ph \imp ps ) \imp ch ) \imp ( th \imp ch ) ) ) $=
( not-is-pattern imp-is-pattern luk-3 luklem2 luklem1 ) AAEZDEZFJBFCFDCFFAKGJDBCHI $.

$( Used to rederive standard propositional axioms from Lukasiewicz'.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
luklem4 $p |- ( ( ( ( \not ph \imp ph ) \imp ph ) \imp ps ) \imp ps ) $=
( not-is-pattern imp-is-pattern luk-2 luklem3 proof-rule-mp luk-1 luklem1 ) ACADADZBDZBCZBDZBLJDZKMDJCJDJDZ
NJEJONDAEJJJLFGGLJBHGBEI $.

$( Used to rederive standard propositional axioms from Lukasiewicz'.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
luklem5 $p |- ( ph \imp ( ps \imp ph ) ) $=
( not-is-pattern imp-is-pattern luklem3 luklem4 luklem1 ) AACADADBADZDHAAABEAHFG $.

$( Used to rederive standard propositional axioms from Lukasiewicz'.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
luklem6 $p |- ( ( ph \imp ( ph \imp ps ) ) \imp ( ph \imp ps ) ) $=
( imp-is-pattern luk-1 not-is-pattern luklem5 luklem2 luklem4 luklem1 proof-rule-mp ) AABCZCKBCZKCZKAKBDKEZ
KCZKCMKCZCZPMOCZQNLCRNBEZNCZLNSFTSBCBCLCLSKBBGBLHIINLKDJMOKDJKPHJI $.

$( Used to rederive standard propositional axioms from Lukasiewicz'.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
luklem7 $p |- ( ( ph \imp ( ps \imp ch ) ) \imp ( ps \imp ( ph \imp ch ) ) ) $=
( imp-is-pattern luk-1 luklem5 luklem1 luklem6 proof-rule-mp ) ABCDZDJCDZACDZDZBLDZAJCEBKDMNDBJ
KDZKBJBDOBJFJBCEGJCHGBKLEIG $.

$( Used to rederive standard propositional axioms from Lukasiewicz'.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
luklem8 $p |- ( ( ph \imp ps ) \imp ( ( ch \imp ph ) \imp ( ch \imp ps ) ) ) $=
( imp-is-pattern luk-1 luklem7 proof-rule-mp ) CADZABDZCBDZDDIHJDDCABEHIJFG $.

$( Standard propositional axiom derived from Lukasiewicz axioms.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
ax1 $p |- ( ph \imp ( ps \imp ph ) ) $=
( luklem5 ) ABC $.

$( Standard propositional axiom derived from Lukasiewicz axioms.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
ax2 $p |- ( ( ph \imp ( ps \imp ch ) ) \imp ( ( ph \imp ps ) \imp ( ph \imp ch ) ) ) $=
( imp-is-pattern luklem7 luklem8 luklem6 proof-rule-mp luklem1 ) ABCDDBACDZDZABDZJDZABCEKLAJDZD
ZMBJAFNJDOMDACGNJLFHII $.

$( Standard propositional axiom derived from Lukasiewicz axioms.
    (Contributed by NM, 22-Dec-2002.)  (Proof modification is discouraged.)
    (New usage is discouraged.) $)
ax3 $p |- ( ( \not ph \imp \not ps ) \imp ( ps \imp ph ) ) $=
( not-is-pattern imp-is-pattern luklem2 luklem4 luklem1 ) ACZBCDHADADBADZDIHBAAEAIFG $.
