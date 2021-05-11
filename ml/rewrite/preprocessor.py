from typing import Dict, Tuple, List

import ml.kore.ast as kore
from ml.kore.parser import parse_axiom
from ml.kore.utils import KoreUtils

from .templates import KoreTemplates


class KorePreprocessor:
    """
    Sometimes certain transformations need to be
    done before translating the kore module. For
    instance, all axioms needs to be universally quantified
    and certain missing axioms need to be added.

    This class implements these somewhat hacky transformations,
    to separate from the rest of the code for clarity.
    """

    MISSING_FUNCTIONAL_AXIOM = [
        "kseq",
        "dotk",
        "Lbl'Unds'Map'Unds'",
    ]

    def preprocess(self, definition: kore.Definition) -> None:
        # modules in which MISSING_FUNCTIONAL_AXIOM
        # symbols are defined in
        # symbol name -> (module, definition)
        defined_modules: Dict[str, Tuple[kore.Module, kore.SymbolDefinition]] = {}

        for symbol_name in KorePreprocessor.MISSING_FUNCTIONAL_AXIOM:
            for module in definition.module_map.values():
                if symbol_name in module.symbol_map:
                    defined_modules[symbol_name] = module, module.symbol_map[symbol_name]
                    break
            else:
                print(f"symbol {symbol_name} is not defined, skipping functional axiom")
                continue

        # ignore if the functional axiom exists
        for module in definition.module_map.values():
            for axiom in module.axioms:
                symbol = KoreTemplates.get_symbol_of_functional_axiom(axiom)
                if symbol is None:
                    continue

                symbol_name = symbol.get_symbol_name()
                if symbol_name in defined_modules:
                    del defined_modules[symbol_name]

        # add functional axioms
        for module, symbol_definition in defined_modules.values():
            assert len(symbol_definition.sort_variables) == 0, \
                   f"sort-parametric symbol {symbol_definition.symbol} not supported"

            input_vars: List[kore.Pattern] = [
                kore.Variable(f"V{i + 1}", sort) for i, sort in enumerate(symbol_definition.input_sorts)
            ]
            output_var = kore.Variable(f"V0", symbol_definition.output_sort)
            sort_var = kore.SortVariable("R")

            symbol_instance = kore.SymbolInstance(symbol_definition, [])

            axiom = kore.Axiom(
                [sort_var],
                kore.MLPattern(
                    kore.MLPattern.EXISTS, [sort_var], [
                        output_var,
                        kore.MLPattern(
                            kore.MLPattern.EQUALS, [symbol_definition.output_sort, sort_var],
                            [output_var, kore.Application(
                                symbol_instance,
                                input_vars,
                            )]
                        )
                    ]
                ),
                [kore.Application(kore.SymbolInstance("functional", []), [])],
            )

            module.add_sentence(axiom)
            axiom.resolve(module)

        for module in definition.module_map.values():
            KoreUtils.instantiate_all_alias_uses(module)
            KoreUtils.quantify_all_free_variables(module)

    # TODO: add missing no confusion & no junk axioms
