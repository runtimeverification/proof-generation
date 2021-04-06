import ml.kore.ast as kore
from ml.kore.parser import parse_axiom
from ml.kore.utils import KoreUtils

from .templates import KoreTemplates


"""
Sometimes certain transformations need to be
done before translating the kore module. For
instance, all axioms needs to be universally quantified
and certain missing axioms need to be added.

This class implements these somewhat hacky transformations,
to separate from the rest of the code for clarity.
"""


class KorePreprocessor:
    def preprocess(self, definition: kore.Definition):
        # add the functional axiom of kseq and dotk if missing
        if "KSEQ" in definition.module_map:
            kseq_module = definition.module_map["KSEQ"]

            found_kseq_functional_axiom = False
            found_dotk_functional_axiom = False

            for axiom in kseq_module.axioms:
                symbol = KoreTemplates.get_symbol_of_functional_axiom(axiom)

                if symbol is None:
                    continue

                if symbol.definition.symbol == "kseq":
                    found_kseq_functional_axiom = True
                elif symbol.definition.symbol == "dotk":
                    found_dotk_functional_axiom = True

            if not found_kseq_functional_axiom:
                axiom = parse_axiom(
                    r"axiom{R} \exists{R} (Val:SortK{}, \equals{SortK{}, R} (Val:SortK{}, kseq{}(K1:SortKItem{},K2:SortK{}))) [functional{}()]"
                )
                kseq_module.add_sentence(axiom)
                axiom.resolve(kseq_module)

            if not found_dotk_functional_axiom:
                axiom = parse_axiom(
                    r"axiom{R} \exists{R} (Val:SortK{}, \equals{SortK{}, R} (Val:SortK{}, dotk{}())) [functional{}()]"
                )
                kseq_module.add_sentence(axiom)
                axiom.resolve(kseq_module)

        for module in definition.module_map.values():
            KoreUtils.instantiate_all_alias_uses(module)
            KoreUtils.quantify_all_free_variables(module)

    # TODO: add missing no confusion & no junk axioms
