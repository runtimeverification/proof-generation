from typing import Dict, Tuple, List, Set, Optional

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

    MISSING_FUNCTIONAL_AXIOMS = [
        "kseq",
        "dotk",
        "Lbl'Unds'Map'Unds'",
        "Lbl'UndsSlsh'Int'Unds'",  # TODO: this probably doesn't make sense since /Int is not defined on 0
        "Lbl'UndsPerc'Int'Unds'",
        "Lbl'Stop'ThreadCellMap",  # TODO: hacky
        "LblThreadCellMapItem",
        "Lbl'Unds'ThreadCellMap'Unds'",
    ]
    MISSING_SUBSORT_AXIOMS = [
        ("SortKConfigVar", "SortKItem"),
    ]

    HOOKED_CONSTRUCTOR_SYMBOLS = [
        "MAP.element",
        "MAP.unit",
        "MAP.concat",
        "LIST.element",
        "LIST.unit",
        "LIST.concat",
        "SET.unit",
    ]

    # HOOKED_CONSTRUCTOR_SYMBOLS = [
    #     "Lbl'UndsPipe'-'-GT-Unds'",
    #     "Lbl'Unds'Map'Unds'",
    #     "Lbl'Stop'Map",
    # ]

    def preprocess(self, definition: kore.Definition) -> None:
        self.remove_function_attributes(definition)
        self.add_missing_functional_axioms(definition)
        self.add_missing_subsort_axioms(definition)
        for module in definition.module_map.values():
            KoreUtils.instantiate_all_alias_uses(module)
            # KoreUtils.quantify_all_free_variables(module)

    def remove_function_attributes(self, definition: kore.Definition) -> None:
        for module in definition.module_map.values():
            for symbol_def in module.symbol_map.values():
                hook = KoreTemplates.get_hook_function(symbol_def)

                if hook is not None and hook in KorePreprocessor.HOOKED_CONSTRUCTOR_SYMBOLS:
                    symbol_def.remove_attribute_by_symbol("function")

    def add_missing_functional_axioms(self, definition: kore.Definition) -> None:
        # modules in which MISSING_FUNCTIONAL_AXIOMS
        # symbols are defined in
        # symbol name -> (module, definition)
        defined_modules: Dict[str, Tuple[kore.Module, kore.SymbolDefinition]] = {}

        for symbol_name in KorePreprocessor.MISSING_FUNCTIONAL_AXIOMS:
            for module in definition.module_map.values():
                if symbol_name in module.symbol_map:
                    defined_modules[symbol_name] = module, module.symbol_map[symbol_name]
                    break
            else:
                print(f"symbol {symbol_name} is not defined, skipping functional axiom")

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
                (kore.Application(kore.SymbolInstance("functional", []), []), ),
            )

            module.add_sentence(axiom)
            axiom.resolve(module)

    def add_missing_subsort_axioms(self, definition: kore.Definition) -> None:
        # which module is the sort defined
        sort_definition_modules: Dict[str, Tuple[kore.Module, kore.SortDefinition]] = {}
        missing_subsort_axioms: Set[Tuple[str, str]] = set()
        inj_definition: Optional[kore.SymbolDefinition] = None

        for module in definition.module_map.values():
            if "inj" in module.symbol_map:
                inj_definition = module.symbol_map["inj"]
                break
        else:
            print("injection symbol not found, skipping all subsort axioms")
            return

        for sort_id1, sort_id2 in KorePreprocessor.MISSING_SUBSORT_AXIOMS:
            for module in definition.module_map.values():
                if sort_id1 in module.sort_map:
                    sort_definition_modules[sort_id1] = module, module.sort_map[sort_id1]

                if sort_id2 in module.sort_map:
                    sort_definition_modules[sort_id2] = module, module.sort_map[sort_id2]

            if sort_id1 not in sort_definition_modules or sort_id2 not in sort_definition_modules:
                print(
                    f"sort {sort_id1} or {sort_id2} is not defined, skipping subsorting axiom ({sort_id1}, {sort_id2})"
                )
            else:
                missing_subsort_axioms.add((sort_id1, sort_id2))

        # skip axioms that have already been added
        for module in definition.module_map.values():
            for axiom in module.axioms:
                subsorts = KoreTemplates.get_sorts_of_subsort_axiom(axiom)
                if subsorts is None:
                    continue

                sort1, sort2 = subsorts
                sort_id1 = sort1.get_sort_id()
                sort_id2 = sort2.get_sort_id()

                if (sort_id1, sort_id2) in missing_subsort_axioms:
                    missing_subsort_axioms.remove((sort_id1, sort_id2))

        # add axioms
        for sort_id1, sort_id2 in missing_subsort_axioms:
            module, sort_definition1 = sort_definition_modules[sort_id1]
            _, sort_definition2 = sort_definition_modules[sort_id2]

            assert len(sort_definition1.sort_variables) == 0 and \
                   len(sort_definition2.sort_variables) == 0

            sort_var = kore.SortVariable("R")

            input_sort = kore.SortInstance(sort_definition1, [])
            output_sort = kore.SortInstance(sort_definition2, [])

            input_var = kore.Variable(f"From", input_sort)
            output_var = kore.Variable(f"Val", output_sort)

            inj_symbol = kore.SymbolInstance(inj_definition, [input_sort, output_sort])

            axiom = kore.Axiom(
                [sort_var],
                kore.MLPattern(
                    kore.MLPattern.EXISTS, [sort_var], [
                        output_var,
                        kore.MLPattern(
                            kore.MLPattern.EQUALS, [output_sort, sort_var],
                            [output_var, kore.Application(
                                inj_symbol,
                                [input_var],
                            )]
                        )
                    ]
                ),
                (kore.Application(kore.SymbolInstance("subsort", [input_sort, output_sort]), []), ),
            )

            module.add_sentence(axiom)
            axiom.resolve(module)
