import unittest

import ml.kore.ast as kore
from ml.kore.utils import KoreUtils
from ml.kore.parser import parse_pattern, parse_axiom, parse_module
from ml.rewrite.encoder import KorePatternEncoder


class TestKorePatternEncoder(unittest.TestCase):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def setUp(self):
        self.encoder = KorePatternEncoder()

        self.sort_bool_definition = kore.SortDefinition("Bool", [], [])
        self.sort_list_definition = kore.SortDefinition("List", [kore.SortVariable("S")], [])
        self.sort_config_definition = kore.SortDefinition("Config", [], [])

        self.symbol_config_definition = kore.SymbolDefinition(
            "config",
            [],
            [self.sort_list_definition, self.sort_bool_definition],
            self.sort_config_definition,
            [],
        )

    def assertEncodingEqual(self, kore_ast: kore.BaseAST, encoding: str):
        self.assertEqual(str(self.encoder.visit(kore_ast)), encoding)

    def assertPatternEncodingEqual(self, kore_text: str, encoding: str):
        pattern = parse_pattern(kore_text)
        self.assertEncodingEqual(pattern, encoding)

    def assertAxiomEncodingEqual(self, module: kore.Module, kore_text: str, encoding: str):
        axiom = parse_axiom(kore_text)
        axiom.resolve(module)
        axiom.set_parent(module)
        KoreUtils.quantify_all_free_variables_in_axiom(axiom)
        self.assertEncodingEqual(axiom, encoding)

    def test_element_var_encoding(self):
        self.assertPatternEncodingEqual(r"X:Bool{}", r"kore-element-var-X")
        self.assertPatternEncodingEqual(r"VX:Bool{}", r"kore-element-var-VX")
        self.assertPatternEncodingEqual(r"Y:S", r"kore-element-var-Y")
        self.assertPatternEncodingEqual(r"Y:List{S}", r"kore-element-var-Y")
        self.assertPatternEncodingEqual(r"Y:Map{S1,S2}", r"kore-element-var-Y")
        self.assertPatternEncodingEqual(r"Y:List{Int{}}", r"kore-element-var-Y")

    def test_kore_pattern_encoding(self):
        self.assertPatternEncodingEqual(r"\top{S}()", r"( \kore-top kore-sort-var-S )")
        self.assertPatternEncodingEqual(r"\bottom{S}()", r"( \kore-bottom kore-sort-var-S )")
        self.assertPatternEncodingEqual(
            r"\and{S}(X:S, Y:S)",
            r"( \kore-and kore-sort-var-S kore-element-var-X kore-element-var-Y )",
        )
        self.assertPatternEncodingEqual(
            r"\or{S}(X:S, Y:S)",
            r"( \kore-or kore-sort-var-S kore-element-var-X kore-element-var-Y )",
        )
        self.assertPatternEncodingEqual(
            r"\implies{S}(X:S, Y:S)",
            r"( \kore-implies kore-sort-var-S kore-element-var-X kore-element-var-Y )",
        )
        # self.assertPatternEncodingEqual(r"\iff{S}(X:S, Y:S)", r"( \kore-iff kore-sort-var-S kore-element-var-X kore-element-var-Y )")
        self.assertPatternEncodingEqual(r"\not{S}(X:S)", r"( \kore-not kore-sort-var-S kore-element-var-X )")

        self.assertPatternEncodingEqual(
            r"\exists{S'}(X:S, Y:S')",
            r"( \kore-exists kore-sort-var-S kore-sort-var-S' kore-element-var-X kore-element-var-Y )",
        )
        self.assertPatternEncodingEqual(
            r"\forall{S'}(X:S, Y:S')",
            r"( \kore-forall kore-sort-var-S kore-sort-var-S' kore-element-var-X kore-element-var-Y )",
        )

        # self.assertPatternEncodingEqual(r"\mu{}(@X:S, Y:S)", r"( \kore-mu kore-sort-var-S kore-set-var-X kore-element-var-Y )")
        # self.assertPatternEncodingEqual(r"\nu{}(@X:S, Y:S)", r"( \kore-nu kore-sort-var-S kore-set-var-X kore-element-var-Y )")

        self.assertPatternEncodingEqual(
            r"\ceil{S1, S2}(X:S1)",
            r"( \kore-ceil kore-sort-var-S1 kore-sort-var-S2 kore-element-var-X )",
        )
        self.assertPatternEncodingEqual(
            r"\floor{S1, S2}(X:S1)",
            r"( \kore-floor kore-sort-var-S1 kore-sort-var-S2 kore-element-var-X )",
        )

        self.assertPatternEncodingEqual(
            r"\equals{S1, S2}(X:S1, Y:S1)",
            r"( \kore-equals kore-sort-var-S1 kore-sort-var-S2 kore-element-var-X kore-element-var-Y )",
        )
        self.assertPatternEncodingEqual(
            r"\in{S1, S2}(X:S1, Y:S1)",
            r"( \kore-in kore-sort-var-S1 kore-sort-var-S2 kore-element-var-X kore-element-var-Y )",
        )

        # self.assertPatternEncodingEqual(r"\next{S}(X:S)", r"( \kore-next kore-sort-var-S kore-element-var-X )")
        self.assertPatternEncodingEqual(
            r"\rewrites{S}(X:S, Y:S)",
            r"( \kore-rewrites kore-sort-var-S kore-element-var-X kore-element-var-Y )",
        )
        self.assertPatternEncodingEqual(r'\dv{Int{}}("12345")', r'( \kore-dv \kore-sort-Int "12345" )')

    def test_kore_axiom_encoding(self):
        module = parse_module(r"""
        module TEST
            sort Int{} []
        endmodule []
        """)

        self.assertAxiomEncodingEqual(
            module,
            r"axiom{} \top{Int{}}() []",
            r"( \kore-valid \kore-sort-Int ( \kore-top \kore-sort-Int ) )",
        )
        self.assertAxiomEncodingEqual(
            module,
            r"axiom{S} \top{S}() []",
            r"( \kore-forall-sort kore-sort-var-S ( \kore-valid kore-sort-var-S ( \kore-top kore-sort-var-S ) ) )",
        )

        self.assertAxiomEncodingEqual(
            module,
            r"axiom{} X:Int{} []",
            r"( \kore-valid \kore-sort-Int ( \kore-forall \kore-sort-Int \kore-sort-Int kore-element-var-X kore-element-var-X ) )",
        )
        self.assertAxiomEncodingEqual(
            module,
            r"axiom{S} X:S []",
            r"( \kore-forall-sort kore-sort-var-S ( \kore-valid kore-sort-var-S ( \kore-forall kore-sort-var-S kore-sort-var-S kore-element-var-X kore-element-var-X ) ) )",
        )

    def test_application_encoding(self):
        self.assertPatternEncodingEqual(r"c{}()", r"\kore-symbol-c")
        self.assertPatternEncodingEqual(r"f{}(c{}())", r"( \kore-symbol-f \kore-symbol-c )")
        self.assertPatternEncodingEqual(
            r"f{}(c1{}(), c2{}())",
            r"( \kore-symbol-f \kore-symbol-c1 \kore-symbol-c2 )",
        )
        self.assertPatternEncodingEqual(
            r"f{}(c1{}(), g{}(c2{}()))",
            r"( \kore-symbol-f \kore-symbol-c1 ( \kore-symbol-g \kore-symbol-c2 ) )",
        )

        self.assertPatternEncodingEqual(r"c{Int{}}()", r"( \kore-symbol-c \kore-sort-Int )")
        self.assertPatternEncodingEqual(r"f{Int{}}(c{}())", r"( \kore-symbol-f \kore-sort-Int \kore-symbol-c )")
        self.assertPatternEncodingEqual(
            r"f{Int{}}(c1{}(), c2{}())",
            r"( \kore-symbol-f \kore-sort-Int \kore-symbol-c1 \kore-symbol-c2 )",
        )
        self.assertPatternEncodingEqual(
            r"f{Int{}}(c1{}(), g{}(c2{}()))",
            r"( \kore-symbol-f \kore-sort-Int \kore-symbol-c1 ( \kore-symbol-g \kore-symbol-c2 ) )",
        )

        self.assertPatternEncodingEqual(
            r"c{Int{}, List{Bool{}}}()",
            r"( \kore-symbol-c \kore-sort-Int ( \kore-sort-List \kore-sort-Bool ) )",
        )
        self.assertPatternEncodingEqual(
            r"f{Int{}, List{Bool{}}}(c{}())",
            r"( \kore-symbol-f \kore-sort-Int ( \kore-sort-List \kore-sort-Bool ) \kore-symbol-c )",
        )
        self.assertPatternEncodingEqual(
            r"f{Int{}, List{Bool{}}}(c1{}(), c2{}())",
            r"( \kore-symbol-f \kore-sort-Int ( \kore-sort-List \kore-sort-Bool ) \kore-symbol-c1 \kore-symbol-c2 )",
        )
        self.assertPatternEncodingEqual(
            r"f{Int{}, List{Bool{}}}(c1{}(), g{}(c2{}()))",
            r"( \kore-symbol-f \kore-sort-Int ( \kore-sort-List \kore-sort-Bool ) \kore-symbol-c1 ( \kore-symbol-g \kore-symbol-c2 ) )",
        )

    def test_string_literal_encoding(self):
        self.assertEncodingEqual(kore.StringLiteral("true"), r'"true"')
        self.assertEncodingEqual(kore.StringLiteral("10\n"), r'"10%0A"')
        self.assertEncodingEqual(kore.StringLiteral('"\n'), r'"%22%0A"')

    def test_sort_instance_encoding(self):
        self.assertEncodingEqual(kore.SortInstance("Integer", []), r"\kore-sort-Integer")

        self.assertEncodingEqual(
            kore.SortInstance("List", [kore.SortInstance("Bool", [])]),
            r"( \kore-sort-List \kore-sort-Bool )",
        )

        self.assertEncodingEqual(
            kore.SortInstance("List", [kore.SortInstance("Maybe", [kore.SortVariable("V")])]),
            r"( \kore-sort-List ( \kore-sort-Maybe kore-sort-var-V ) )",
        )

    """
    test if metainfo is collected correctly, e.g. metavariables, constants, domain values
    """

    def test_metainfo_collection(self):
        sort_bool = kore.SortInstance(self.sort_bool_definition, [])
        sort_list = kore.SortInstance(self.sort_list_definition, [kore.SortVariable("S")])
        pattern = kore.Application(
            kore.SymbolInstance(self.symbol_config_definition, []),
            [
                kore.Variable("V1", sort_list),
                kore.MLPattern(kore.MLPattern.DV, [sort_bool], [kore.StringLiteral("true")]),
            ],
        )

        self.assertEncodingEqual(
            pattern,
            r'( \kore-symbol-config kore-element-var-V1 ( \kore-dv \kore-sort-Bool "true" ) )',
        )

        self.assertEqual(
            self.encoder.constant_symbols,
            {
                r"\kore-sort-Bool": 0,
                r'"true"': 0,
                r"\kore-symbol-config": 2
            },
        )
        self.assertEqual(self.encoder.domain_values, {(sort_bool, kore.StringLiteral("true"))})
        self.assertEqual(self.encoder.metavariables, {"kore-element-var-V1": "#ElementVariable"})
