from __future__ import annotations

from typing import Optional, Union, List, Tuple, Mapping, Set, TextIO, Dict, Type, Any, Iterable, Generator

import re

from contextlib import contextmanager

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils
from ml.kore.visitors import FreePatternVariableVisitor, ApplicationSubpatternTester

from ml.metamath import ast as mm
from ml.metamath.composer import Composer, Theorem, Context, Proof, AutoProof
from ml.metamath.utils import MetamathUtils
from ml.metamath.auto.substitution import SubstitutionProver
from ml.metamath.auto.context import ApplicationContextProver
from ml.metamath.auto.sorting import SortingProver
from ml.metamath.auto.fresh import FreshProver
from ml.metamath.auto.predicate import PredicateProver

from .encoder import KoreEncoder, KoreDecoder
from .templates import KoreTemplates


class ProofGenerator:
    def __init__(self, composer: KoreComposer):
        self.composer = composer


class ProvableClaim:
    """
    A claim in kore and a metamath proof of its encoding
    This pair comes up often because we need to
    reuse some operations and information on the Kore ast
    """
    def __init__(self, claim: kore.Claim, proof: Proof):
        encoded_claim = KoreEncoder().visit(claim)
        assert isinstance(proof, Proof)
        assert (
            encoded_claim == proof.conclusion[1]
        ), f"provable claim invariant failed: {encoded_claim} != {proof.conclusion[1]}"
        self.claim = claim
        self.proof = proof

    """
    Three basic things we need to prove:
    - substitution (use the metamath one)
    - equality elimination
    - functional substitution (on any free variable)
    """


class SubsortRelation:
    """
    A data structure that stores the subsort
    relation (a strict partial order)
    """
    def __init__(self) -> None:
        self.adj_list: Dict[kore.SortInstance, List[kore.SortInstance]] = {}
        # SortInstance -> [ ( supersort, subsorting lemma ) ... ]

    def get_immediate_subsort_of(self, sort: kore.SortInstance) -> List[kore.SortInstance]:
        subsorts = []
        for other, supersorts in self.adj_list.items():
            for supersort in supersorts:
                if supersort == sort:
                    subsorts.append(other)
                    break
        return subsorts

    def get_subsort_chain(self, sort1: kore.SortInstance,
                          sort2: kore.SortInstance) -> Optional[List[kore.SortInstance]]:
        """
        Return a chain of immediate subsorting: sort1 < A < B < ... < sort2,
        if sort1 < sort2; otherwise return None
        """
        if sort1 == sort2:
            return None
        if sort1 not in self.adj_list:
            return None

        for intermediate in self.adj_list[sort1]:
            if intermediate == sort2:
                return [sort1, sort2]

            chain = self.get_subsort_chain(intermediate, sort2)
            if chain is not None:
                return [sort1] + chain

                # raise NotImplementedError("non-immediate subsorting not supported")
                # TODO: use injection lemma to chain subsorts

        return None

    def add_subsort(self, sort1: kore.SortInstance, sort2: kore.SortInstance) -> None:
        """
        Add sort1 < sort2
        """
        assert (sort1 != sort2), f"subsort relation should be irreflexive: {sort1} </ {sort2}"
        assert (self.get_subsort_chain(sort2, sort1) is None), f"cyclic subsorting: {sort1} ? {sort2}"

        if sort1 not in self.adj_list:
            self.adj_list[sort1] = []
        self.adj_list[sort1].append(sort2)

    def __str__(self) -> str:
        return "\n".join(
            [
                "{} < {}".format(sort, ", ".join([str(supersort) for supersort in supersorts]))
                for sort, supersorts in self.adj_list.items()
            ]
        )


class KoreComposer(Composer):
    """
    KoreComposer extends regular composer with information specialized to Kore and K
    """
    def __init__(self, *, dv_as_provable: bool = False, **kwargs: Any):
        super().__init__(**kwargs)

        ###########
        # options #
        ###########
        self.dv_as_provable = dv_as_provable

        #######################################
        # some axioms that will be used later #
        #######################################

        self.all_sorts: List[kore.SortDefinition] = []  # sort definitions
        # symbol definitions
        self.constructors: List[kore.SymbolDefinition] = []

        # metamath label prefixes of sorts and symbols
        self.sort_labels: Dict[kore.SortDefinition, str] = {}
        self.symbol_labels: Dict[kore.SymbolDefinition, str] = {}

        self.functional_axioms: Dict[kore.SymbolInstance, ProvableClaim] = {}  # symbol instance -> provable claim
        self.domain_value_functional_axioms: Dict[Tuple[kore.SortInstance, kore.StringLiteral],
                                                  ProvableClaim] = {}  # (sort, string literal) -> provable claim
        self.rewrite_axioms: Dict[str, ProvableClaim] = {}  # unique id -> provable claim
        self.anywhere_axioms: List[ProvableClaim] = []  # provable claims
        self.substitution_axioms: Dict[str, Theorem] = {}  # constant symbol (in metamath) -> theorem
        self.sort_axioms: Dict[str, Theorem] = {}  # constant symbol (in metamath) -> theorem
        self.sorting_lemmas: Dict[str, Theorem] = {}  # constant symbol (in metamath) -> theorem
        self.equational_axioms: Dict[kore.SymbolInstance, List[ProvableClaim]] = {}  # symbol instance -> provable claim
        # provable claim
        self.map_commutativity_axiom: Dict[kore.SortInstance, ProvableClaim] = {}
        self.map_associativity_axiom: Dict[kore.SortInstance, ProvableClaim] = {}
        self.map_right_unit_axiom: Dict[kore.SortInstance, ProvableClaim] = {}
        self.app_ctx_lemmas: Dict[str, List[Theorem]] = {}  # constant_symbol -> list of theorems, one for each argument

        # constructor axioms
        self.sort_to_constructors: Dict[kore.SortInstance,
                                        List[kore.SymbolDefinition]] = {}  # sort instance -> [ symbol definitions ]
        self.hooked_sorts: List[kore.SortDefinition] = []
        self.no_confusion_same_constructor: Dict[kore.SymbolDefinition, Theorem] = {}  # constant symbol -> theorem
        self.no_confusion_diff_constructor: Dict[Tuple[kore.SymbolDefinition, kore.SymbolDefinition],
                                                 Theorem] = {}  # (symbol, symbol) -> theorem
        self.no_confusion_with_dv: Dict[kore.SymbolDefinition, Theorem] = {}  # symbol -> theorem
        self.no_confusion_hooked_sort: Dict[Tuple[kore.SortInstance, kore.SymbolDefinition],
                                            Theorem] = {}  # (kore symbol string, kore sort) -> theorem
        # (sort symbol, sort symbol) -> theorem, different hooked sorts are disjoint
        self.hooked_sort_disjoint_axioms: Dict[Tuple[str, str], Theorem] = {}
        self.no_junk_axioms: Dict[kore.SortInstance, Theorem] = {}  # sort instance -> theorem
        self.sort_components: Dict[kore.SortInstance, List[Union[kore.Variable, kore.Application]]] = {
        }  # sort instance -> [ patterns (without existential quantifier) ]

        self.sort_injection_symbol: Optional[kore.SymbolDefinition] = None
        self.sort_injection_axiom: Optional[ProvableClaim] = None
        self.subsort_relation = SubsortRelation()

        self.string_literals: Set[kore.StringLiteral] = set()
        self.domain_values: Set[Tuple[kore.SortInstance, kore.StringLiteral]] = set()

        # we rename variables to reduce the total number of variables
        # but this will affect the hints, so we need to provide this
        # renaming information
        self.axiom_variable_renaming: Dict[str, Mapping[kore.Variable, kore.Variable]] = {}

        self.fresh_label_counter = 0

    def get_fresh_label(self, prefix: str) -> str:
        counter = self.fresh_label_counter
        self.fresh_label_counter += 1
        return f"{prefix}-{counter}"

    def load_module(self, module: kore.Module) -> None:
        self.module = module
        self.loaded_modules: Dict[str, kore.Module] = {}

        self.load_module_sentences(module)
        self.load_axioms_for_injection()
        self.load_sort_constructor_axioms()
        self.load_unit_sort()

    def load_unit_sort(self) -> None:
        """
        Add a distinguished sort called "Unit" for later convenience
        (when instantiating sort parametric axioms)
        """
        sort_definition = kore.SortDefinition("Unit", [])
        self.module.add_sentence(sort_definition)
        self.unit_sort = kore.SortInstance(sort_definition, [])

    def load_axioms_for_injection(self) -> None:
        if "INJ" not in self.loaded_modules:
            return

        inj_module = self.loaded_modules["INJ"]
        assert ("inj" in inj_module.symbol_map), "cannot find sort injection function symbol"
        self.sort_injection_symbol = inj_module.symbol_map["inj"]

        assert len(inj_module.axioms) == 1, "unexpected INJ module content"
        self.sort_injection_axiom = self.load_axiom(inj_module.axioms[0], "kore-inj-axiom")

    def sanitize_label_name(self, label: str) -> str:
        # metamath does not allow some characters in the label
        return re.sub(r"[^a-zA-Z0-9_\-.]", "", label)

    def load_metavariables(self, metavar_map: Mapping[str, str]) -> None:
        """
        Load metavariables into the composer
        metavar_map: map from metavariable name to typecode
        """

        with self.in_segment("variable"):
            # filter out existing metavariables and
            # check duplication (different typecode for the same variable)
            new_metavars: Dict[str, str] = {}
            for var, typecode in metavar_map.items():
                found_typecode = self.find_metavariable(var)

                if found_typecode is None:
                    new_metavars[var] = typecode
                else:
                    assert found_typecode == typecode, \
                        "inconsistent metavariable typecode: both {} and {} for variable {}".format(
                            found_typecode, typecode, var
                        )

            if not new_metavars:
                return

            self.load_comment(f"adding {len(new_metavars)} new metavariable(s)", top_level=True)

            var_stmt = mm.VariableStatement(tuple(map(mm.Metavariable, new_metavars.keys())))
            self.load(var_stmt)

            for var, typecode in new_metavars.items():
                floating_stmt = mm.FloatingStatement(
                    f"{self.sanitize_label_name(var)}-{typecode.replace('#', '').lower()}",
                    (
                        mm.Application(typecode),
                        mm.Metavariable(var),
                    ),
                )

                self.load(floating_stmt, top_level=True)

            # if we have added any #ElementVariable
            # and the total number of element variables
            # is > 1, then generate a new disjoint statement
            if "#ElementVariable" in set(new_metavars.values()):
                element_vars = self.find_metavariables_of_typecode("#ElementVariable")
                if len(element_vars) > 1:
                    disjoint_stmt = mm.DisjointStatement(tuple(map(mm.Metavariable, element_vars)))
                    self.load(disjoint_stmt, top_level=True)

    def encode_pattern(self, pattern: Union[kore.Axiom, kore.Pattern, kore.Sort]) -> mm.Term:
        encoder = KoreEncoder()
        term = encoder.visit(pattern)
        self.load_metavariables(encoder.metavariables)
        self.load_domain_values(encoder.domain_values)
        return term

    def encode_axiom_premise(self, axiom: kore.Axiom) -> mm.Term:
        premise, _ = MetamathUtils.destruct_imp(self.encode_pattern(axiom))
        return premise

    def encode_metamath_statement(
        self, axiom: kore.Axiom, cons: Type[mm.StructuredStatement] = mm.StructuredStatement
    ) -> mm.StructuredStatement:
        return cons(
            "",
            (mm.Application("|-"), self.encode_pattern(axiom)),
        )

    def construct_claim(
        self, pattern: kore.Pattern, sort_variables: Optional[List[kore.SortVariable]] = None
    ) -> kore.Claim:
        claim = kore.Claim(sort_variables or [], pattern)
        claim.resolve(self.module)
        return claim

    def construct_provable_claim(
        self,
        claim: Union[kore.Pattern, kore.Claim],
        proof: Proof,
        sort_variables: Optional[List[kore.SortVariable]] = None,
        cache_key: Optional[str] = None,
    ) -> ProvableClaim:
        if isinstance(claim, kore.Pattern):
            claim = self.construct_claim(claim, sort_variables)

        sorting_premise, _ = MetamathUtils.destruct_imp(self.encode_pattern(claim))
        proof = SortingProver.rearrange_premise(self, sorting_premise, proof)

        if cache_key is not None:
            proof = self.cache_proof(cache_key, proof)

        return ProvableClaim(claim, proof)

    def load_comment(self, comment: str, **kwargs: Any) -> None:
        self.load(mm.Comment(comment), **kwargs)

    def load_provable_claim_as_theorem(self, label: str, provable: ProvableClaim) -> ProvableClaim:
        """
        Returns a new provable claim with the proof using the loaded theorem
        """
        new_proof = self.load_proof_as_statement(label, provable.proof).as_proof()
        return ProvableClaim(provable.claim, new_proof)

    def load_fresh_claim_placeholder(self, label_prefix: str, claim: Union[kore.Claim, kore.Pattern]) -> ProvableClaim:
        """
        Load a claim without proof in the current context, using a fresh label
        """
        label = self.get_fresh_label(label_prefix)

        if isinstance(claim, kore.Pattern):
            claim = self.construct_claim(claim)

        mm_pattern = self.encode_pattern(claim)
        proof = Proof.from_script(mm.StructuredStatement("", MetamathUtils.construct_provable(mm_pattern)), "?")
        theorem = self.load_proof_as_statement(label, proof)

        return ProvableClaim(claim, theorem.as_proof())

    def load_axiom(
        self,
        axiom: kore.Axiom,
        label: str,
        comment: bool = True,
        provable: bool = False,
        rename: bool = False,
        **kwargs: Any
    ) -> ProvableClaim:
        """
        Encode and load a Kore axiom into the generator
        and return the corresponding theorem object
        """

        if rename:
            axiom, renaming = KoreUtils.rename_variable_with_prefix(axiom, "V")
            uid = KoreTemplates.get_axiom_unique_id(axiom)
            if uid is not None:
                # assert uid not in self.axiom_variable_renaming, \
                #        f"loading duplicate axioms {uid}"
                self.axiom_variable_renaming[uid] = renaming

        term = self.encode_pattern(axiom)

        if comment:
            self.load_comment(str(axiom), **kwargs)

        # <label> $a |- <axiom> $.
        if provable:
            stmt: mm.StructuredStatement = mm.ProvableStatement(label, (mm.Application("|-"), term))
        else:
            stmt = mm.AxiomaticStatement(label, (mm.Application("|-"), term))

        return ProvableClaim(axiom, self.load(stmt, **kwargs).as_proof())

    def load_symbol_sorting_lemma(self, symbol_definition: kore.SymbolDefinition) -> None:
        encoded_symbol = KoreEncoder.encode_symbol(symbol_definition.symbol)
        arity = len(symbol_definition.sort_variables) + len(symbol_definition.input_sorts)

        pattern_vars = [mm.Metavariable(v) for v in self.gen_metavariables("#Pattern", arity)]

        sort_pattern_vars = pattern_vars[:len(symbol_definition.sort_variables)]
        argument_pattern_vars = pattern_vars[len(symbol_definition.sort_variables):]

        # for simplicity, we replace all sort variables (which are #ElementVariable's)
        # by pattern variables since \\kore-is-sort implies they are singletons
        sort_var_subst = {
            KoreEncoder.encode_sort_variable(element_var): pattern_var
            for element_var, pattern_var in zip(symbol_definition.sort_variables, sort_pattern_vars)
        }

        encoded_output_sort = self.encode_pattern(symbol_definition.output_sort)
        encoded_output_sort = encoded_output_sort.substitute(sort_var_subst)

        sorting_axiom_rhs = mm.Application(
            "\\in-sort",
            (
                mm.Application(encoded_symbol, tuple(pattern_vars)),
                encoded_output_sort,
            ),
        )

        sorting_axiom_hypotheses = []

        # add hypotheses for sort arguments
        for v in sort_pattern_vars:
            sorting_axiom_hypotheses.append(mm.Application("\\kore-is-sort", (v, )))

        # add hypotheses for pattern arguments
        for v, sort in zip(argument_pattern_vars, symbol_definition.input_sorts):
            encoded_sort = self.encode_pattern(sort)
            encoded_sort = encoded_sort.substitute(sort_var_subst)
            sorting_axiom_hypotheses.append(mm.Application("\\in-sort", (v, encoded_sort)))

        # construct the hypothesis and the entire statement
        # hypothesis: \and ( \in-sort ph0 <sort0> ) ( \in-sort ph1 <sort1> ) ...
        if len(sorting_axiom_hypotheses) == 0:
            sorting_axiom_term = sorting_axiom_rhs
        elif len(sorting_axiom_hypotheses) == 1:
            sorting_axiom_term = mm.Application("\\imp", (sorting_axiom_hypotheses[0], sorting_axiom_rhs))
        else:
            lhs = mm.Application("\\and", tuple(sorting_axiom_hypotheses[:2]))
            for hyp in sorting_axiom_hypotheses[2:]:
                lhs = mm.Application("\\and", (lhs, hyp))
            sorting_axiom_term = mm.Application("\\imp", (lhs, sorting_axiom_rhs))

        self.sorting_lemmas[encoded_symbol] = self.load(
            mm.AxiomaticStatement(
                f"{self.get_symbol_label(symbol_definition)}-sorting",
                (
                    mm.Application("|-"),
                    sorting_axiom_term,
                ),
            )
        )

    def load_no_confusion_same_constructor(self, symbol_definition: kore.SymbolDefinition) -> Theorem:
        """
        Generate an axiom saying that a constructor should be injective
        """

        encoded_symbol = KoreEncoder.encode_symbol(symbol_definition.symbol)
        num_sort_vars = len(symbol_definition.sort_variables)
        num_arguments = len(symbol_definition.input_sorts)

        assert num_arguments != 0

        pattern_var_names = self.gen_metavariables("#Pattern", num_sort_vars + num_arguments * 2)
        pattern_vars = tuple(mm.Metavariable(v) for v in pattern_var_names)

        sort_pattern_vars = pattern_vars[:num_sort_vars]
        arg_pattern_vars_left = pattern_vars[num_sort_vars:num_sort_vars + num_arguments]
        arg_pattern_vars_right = pattern_vars[num_sort_vars + num_arguments:]

        left_pattern = mm.Application(encoded_symbol, sort_pattern_vars + arg_pattern_vars_left)
        right_pattern = mm.Application(encoded_symbol, sort_pattern_vars + arg_pattern_vars_right)

        left_conj_pattern = mm.Application("\\and", (left_pattern, right_pattern))

        conjunctions = tuple(
            mm.Application("\\and", (left_arg, right_arg))
            for left_arg, right_arg in zip(arg_pattern_vars_left, arg_pattern_vars_right)
        )

        right_conj_pattern = mm.Application(encoded_symbol, sort_pattern_vars + conjunctions)

        statement = mm.AxiomaticStatement(
            f"{self.get_symbol_label(symbol_definition)}-no-confusion",
            (
                mm.Application("|-"),
                mm.Application("\\imp", (left_conj_pattern, right_conj_pattern)),
            ),
        )

        theorem = self.load(statement)
        self.no_confusion_same_constructor[symbol_definition] = theorem

        return theorem

    def load_no_confusion_with_dv(self, symbol_definition: kore.SymbolDefinition) -> Theorem:
        """
        Generate an axiom saying that the constructor term is not overlapping with any domain value
        """
        encoded_symbol = KoreEncoder.encode_symbol(symbol_definition.symbol)
        num_sort_vars = len(symbol_definition.sort_variables)
        num_arguments = len(symbol_definition.input_sorts)

        pattern_var_names = self.gen_metavariables("#Pattern", num_sort_vars + num_arguments + 2)
        pattern_vars = tuple(mm.Metavariable(v) for v in pattern_var_names)
        dv_sort_var, dv_body_var = pattern_vars[:2]

        left_pattern = mm.Application("\\kore-dv", (dv_sort_var, dv_body_var))
        right_pattern = mm.Application(encoded_symbol, pattern_vars[2:])
        conj_pattern = mm.Application("\\and", (left_pattern, right_pattern))
        not_conj_pattern = mm.Application("\\not", (conj_pattern, ))
        statement = mm.AxiomaticStatement(
            f"{self.get_symbol_label(symbol_definition)}-no-confusion-with-dv",
            (
                mm.Application("|-"),
                not_conj_pattern,
            ),
        )

        theorem = self.load(statement)
        self.no_confusion_with_dv[symbol_definition] = theorem

        return theorem

    def load_no_confusion_diff_constructor(
        self, constructor1: kore.SymbolDefinition, constructor2: kore.SymbolDefinition
    ) -> Theorem:
        constructor_symbol1 = KoreEncoder.encode_symbol(constructor1.symbol)
        num_sort_vars1 = len(constructor1.sort_variables)
        num_arguments1 = len(constructor1.input_sorts)

        constructor_symbol2 = KoreEncoder.encode_symbol(constructor2.symbol)
        num_sort_vars2 = len(constructor2.sort_variables)
        num_arguments2 = len(constructor2.input_sorts)

        pattern_var_names = self.gen_metavariables(
            "#Pattern",
            num_sort_vars1 + num_arguments1 + num_sort_vars2 + num_arguments2,
        )
        pattern_vars = tuple(mm.Metavariable(v) for v in pattern_var_names)

        left_pattern = mm.Application(constructor_symbol1, pattern_vars[:num_sort_vars1 + num_arguments1])
        right_pattern = mm.Application(constructor_symbol2, pattern_vars[num_sort_vars1 + num_arguments1:])

        statement = mm.AxiomaticStatement(
            f"{self.get_symbol_label(constructor1)}-no-confusion-with-{self.sanitize_label_name(constructor_symbol2)}",
            (
                mm.Application("|-"),
                mm.Application(
                    "\\not",
                    (mm.Application("\\and", (left_pattern, right_pattern)), ),
                ),
            ),
        )

        theorem = self.load(statement)
        self.no_confusion_diff_constructor[constructor1, constructor2] = theorem

        return theorem

    def get_no_confusion_same_constructor(self, symbol_definition: kore.SymbolDefinition) -> Optional[Theorem]:
        if symbol_definition not in self.constructors:
            return None

        if symbol_definition in self.no_confusion_same_constructor:
            return self.no_confusion_same_constructor[symbol_definition]

        return self.load_no_confusion_same_constructor(symbol_definition)

    def get_no_confusion_with_dv(self, symbol_definition: kore.SymbolDefinition) -> Optional[Theorem]:
        if symbol_definition not in self.constructors:
            return None

        if symbol_definition in self.no_confusion_with_dv:
            return self.no_confusion_with_dv[symbol_definition]

        return self.load_no_confusion_with_dv(symbol_definition)

    def get_no_confusion_diff_constructor(
        self, constructor1: kore.SymbolDefinition, constructor2: kore.SymbolDefinition
    ) -> Optional[Theorem]:
        if constructor2 not in self.constructors:
            return None

        if (constructor1, constructor2) in self.no_confusion_diff_constructor:
            return self.no_confusion_diff_constructor[constructor1, constructor2]

        return self.load_no_confusion_diff_constructor(constructor1, constructor2)

    def load_symbol_constructor_axioms(self, symbol_definition: kore.SymbolDefinition) -> None:
        """
        Generate constructor axioms for symbols marked with `constructor{}()` attribute
        """

        # skip if not a constructor
        if symbol_definition.get_attribute_by_symbol("constructor") is None:
            return

        # generate no confusion axiom for the same symbol
        # self.load_no_confusion_same_constructor(symbol_definition)

        # generate no confusion axiom for \kore-dv
        # self.load_no_confusion_with_dv(symbol_definition)

        # generate no confusion axioms for different symbols
        # for other_constructor in self.constructors:
        #     self.load_no_confusion_diff_constructor(symbol_definition, other_constructor)

        self.constructors.append(symbol_definition)

        # add the constructor if it's not sort-parametric
        # TODO: what do we do if it's sort-parametric
        if len(symbol_definition.sort_variables) == 0:
            assert isinstance(symbol_definition.output_sort, kore.SortInstance)

            if symbol_definition.output_sort not in self.sort_to_constructors:
                self.sort_to_constructors[symbol_definition.output_sort] = []
            self.sort_to_constructors[symbol_definition.output_sort].append(symbol_definition)

    def load_symbol_definition(self, symbol_definition: kore.SymbolDefinition) -> None:
        encoded_symbol = KoreEncoder.encode_symbol(symbol_definition.symbol)
        arity = len(symbol_definition.sort_variables) + len(symbol_definition.input_sorts)

        label = self.get_symbol_label(symbol_definition)

        self.load_comment(str(symbol_definition))
        self.load_constant(encoded_symbol, arity, label)

        self.load_symbol_sorting_lemma(symbol_definition)
        self.load_symbol_constructor_axioms(symbol_definition)

    def load_sort_definition(self, sort_definition: kore.SortDefinition) -> None:
        encoded_sort = KoreEncoder.encode_sort(sort_definition.sort_id)
        arity = len(sort_definition.sort_variables)

        assert arity == 0, "parametric sort not supported"

        label = self.get_sort_label(sort_definition)

        self.load_comment(str(sort_definition))
        self.load_constant(encoded_sort, arity, label)

        self.sort_axioms[encoded_sort] = self.load(
            mm.AxiomaticStatement(
                f"{label}-sort",
                (
                    mm.Application("|-"),
                    mm.Application(KoreEncoder.IS_SORT, (mm.Application(encoded_sort), )),
                ),
            )
        )

        self.all_sorts.append(sort_definition)

        # add axioms saying that hooked sorts are disjoint
        if (sort_definition.hooked or sort_definition.get_attribute_by_symbol("token") is not None) \
           and len(sort_definition.sort_variables) == 0:
            # TODO: could there be hooked sorts with sort variables?
            for other_hooked_sort in self.hooked_sorts:
                encoded_other_sort = KoreEncoder.encode_sort(other_hooked_sort.sort_id)
                self.hooked_sort_disjoint_axioms[encoded_sort, encoded_other_sort] = \
                    self.load(
                        mm.AxiomaticStatement(
                            f"{label}-hooked-sort-disjoint-with-{self.sanitize_label_name(other_hooked_sort.sort_id)}",
                            (
                                mm.Application("|-"),
                                mm.Application("\\not", (
                                    mm.Application("\\and", (
                                        mm.Application("\\inh", (mm.Application(encoded_sort),)),
                                        mm.Application("\\inh", (mm.Application(encoded_other_sort),)),
                                    )),
                                )),
                            ),
                        ),
                    )

            self.hooked_sorts.append(sort_definition)

    def load_domain_values(self, domain_values: Set[Tuple[kore.SortInstance, kore.StringLiteral]]) -> None:
        """
        Load a domain value and generate the corresponding functional axiom
        """

        with self.in_segment("dv"):
            for sort, literal in domain_values:
                # add the corresponding string literal
                if literal not in self.string_literals:
                    index = len(self.string_literals)
                    self.string_literals.add(literal)

                    self.load_comment(f"string literal {literal}", top_level=True)

                    self.load_constant(
                        KoreEncoder.encode_string_literal(literal),
                        0,
                        f"string-literal-{index}",
                    )

                # add functional axiom for the domain value
                if (sort, literal) not in self.domain_values:
                    index = len(self.domain_values)
                    self.domain_values.add((sort, literal))

                    functional_rule_name = f"domain-value-{index}-functional"

                    # TODO: check the literal is actually correct

                    # generate the functinoal axiom for the domain value
                    sort_var, functional_var = self.gen_metavariables("#ElementVariable", 2)

                    functional_axiom = kore.Axiom(
                        [kore.SortVariable(sort_var)],
                        kore.MLPattern(
                            kore.MLPattern.EXISTS,
                            [kore.SortVariable(sort_var)],
                            [
                                kore.Variable(functional_var, sort),
                                kore.MLPattern(
                                    kore.MLPattern.EQUALS,
                                    [sort, kore.SortVariable(sort_var)],
                                    [
                                        kore.Variable(functional_var, sort),
                                        kore.MLPattern(
                                            kore.MLPattern.DV,
                                            [sort],
                                            [literal],
                                        ),
                                    ],
                                ),
                            ],
                        ),
                    )

                    functional_axiom.resolve(self.module)

                    self.domain_value_functional_axioms[sort, literal] = \
                        self.load_axiom(functional_axiom, functional_rule_name, top_level=True)

    def load_constant_substitution_lemma(self, symbol: str, arity: int, label: str) -> None:
        """
        Generate and prove the substitution rule for the given symbol
        """

        with self.in_segment("substitution"):
            (subst_var, ) = self.gen_metavariables("#Variable", 1)
            pattern_var, *subpattern_vars = self.gen_metavariables("#Pattern", arity * 2 + 1)

            with self.new_context(top_level=True):
                substitution_rule_name = label + "-substitution"
                essentials = []
                essential_theorems = []

                for i in range(arity):
                    after = subpattern_vars[i]
                    before = subpattern_vars[i + arity]

                    essential = mm.EssentialStatement(
                        f"{substitution_rule_name}.{i}",
                        (
                            mm.Application("#Substitution"),
                            mm.Metavariable(after),
                            mm.Metavariable(before),
                            mm.Metavariable(pattern_var),
                            mm.Metavariable(subst_var),
                        ),
                    )

                    essentials.append(essential)
                    essential_theorems.append(self.load(essential))

                # prove the substitution rule
                subst_proof = SubstitutionProver.prove_substitution(
                    self,
                    mm.Application(symbol, tuple(map(mm.Metavariable, subpattern_vars[:arity]))),
                    mm.Application(symbol, tuple(map(mm.Metavariable, subpattern_vars[arity:]))),
                    mm.Metavariable(pattern_var),
                    mm.Metavariable(subst_var),
                    essential_theorems,
                )

                self.substitution_axioms[symbol] = \
                    self.load_proof_as_statement(substitution_rule_name, subst_proof)

    def load_application_context_lemma(self, symbol: str, arity: int, label: str) -> None:
        with self.in_segment("substitution"):
            (hole_var, ) = self.gen_metavariables("#Variable", 1)
            pattern_var_names = self.gen_metavariables("#Pattern", arity)
            pattern_vars = tuple(mm.Metavariable(v) for v in pattern_var_names)

            # generate one lemma for each argument
            lemmas = []

            for i in range(arity):
                app_ctx_rule_name = f"{label}-application-context-{i}"

                with self.new_context(top_level=True):
                    for j in range(arity):
                        if i != j:
                            self.load(
                                mm.DisjointStatement(
                                    (mm.Metavariable(hole_var), mm.Metavariable(pattern_vars[j].name))
                                )
                            )

                    assumption = mm.EssentialStatement(
                        f"{app_ctx_rule_name}.0",
                        (
                            mm.Application("#ApplicationContext"),
                            mm.Metavariable(hole_var),
                            pattern_vars[i],
                        ),
                    )
                    self.load(assumption)

                    conclusion = mm.ProvableStatement(
                        app_ctx_rule_name,
                        (
                            mm.Application("#ApplicationContext"),
                            mm.Metavariable(hole_var),
                            mm.Application(symbol, pattern_vars),
                        ),
                    )

                    proof = ApplicationContextProver.prove_application_context_statement(
                        self,
                        conclusion,
                        [Theorem(self, assumption)],
                    )
                    theorem = self.load_proof_as_statement(app_ctx_rule_name, proof)
                    lemmas.append(theorem)

            self.app_ctx_lemmas[symbol] = lemmas

    def load_constant(self, symbol: str, arity: int, label: str) -> None:
        """
        Load a constant symbol into the composer
        and generate appropriate axioms (e.g. substitution rule)
        """
        # skip axioms for kore-inj
        if symbol == "\\kore-inj":
            self.substitution_axioms["\\kore-inj"] = self.get_theorem("substitution-kore-inj")
            # TODO: prove this separately
            self.load_application_context_lemma("\\kore-inj", 3, "kore-inj")
            return

        # allocate all required metavariable at once
        pattern_vars = self.gen_metavariables("#Pattern", arity)

        # declare metamath constant
        # this is the actual symbol at the matching logic level used for application
        applicative_symbol = symbol + "-symbol"
        self.load(mm.ConstantStatement((symbol, applicative_symbol)), top_level=True)

        sugared_pattern = mm.Application(symbol, tuple(mm.Metavariable(v) for v in pattern_vars))

        # declare #Symbol
        self.load(
            mm.AxiomaticStatement(
                f"{label}-is-symbol",
                (
                    mm.Application("#Symbol"),
                    mm.Application(applicative_symbol),
                ),
            ),
            top_level=True,
        )

        # declare #Pattern
        self.load(
            mm.AxiomaticStatement(
                f"{label}-is-pattern",
                (
                    mm.Application("#Pattern"),
                    sugared_pattern,
                ),
            ),
            top_level=True,
        )

        # declare syntax sugar
        desugared = mm.Application(applicative_symbol)
        for var in pattern_vars:
            desugared = mm.Application("\\app", (desugared, mm.Metavariable(var)))

        self.load(
            mm.AxiomaticStatement(
                f"{label}-is-sugar",
                (
                    mm.Application("#Notation"),
                    sugared_pattern,
                    desugared,
                ),
            ),
            top_level=True,
        )

        # generate substitution rule
        self.load_constant_substitution_lemma(symbol, arity, label)
        self.load_application_context_lemma(symbol, arity, label)

    def get_metavariable_name(self, typecode: str, n: int) -> str:
        """
        Get the name for the nth metavariable of the given typecode
        """

        if typecode == "#ElementVariable":
            return f"x{n}"
            # return {0: "x", 1: "y", 2: "z", 3: "w"}.get(n, f"x{n}")
        elif typecode == "#Variable":
            # return {0: "xX", 1: "yY", 2: "zZ", 3: "wW"}.get(n, f"xX{n}")
            return f"xX{n}"
        elif typecode == "#Pattern":
            return f"ptn{n}"
        else:
            return f"fv{typecode.replace('#', '').lower()}"

    def gen_metavariables(self, typecode: str, n: int) -> List[str]:
        """
        Generate n metavariables
        and add the new ones to the composer
        """
        metavars = [self.get_metavariable_name(typecode, i) for i in range(n)]
        self.load_metavariables({var: typecode for var in metavars})
        return metavars

    def gen_fresh_metavariables(self, typecode: str, n: int, other_than: Set[str]) -> List[str]:
        """
        Generate n fresh variables other than the variables in `other_than`
        """
        metavars: Set[str] = set()
        current_extra = 0
        while len(metavars.difference(other_than)) < n:
            metavars = set(self.gen_metavariables(typecode, current_extra + n))
            current_extra += 1
        return list(metavars.difference(other_than))

    # TODO: find a better place for this method
    def existentially_quantify_free_variables(self, pattern: kore.Pattern) -> mm.Term:
        free_vars = FreePatternVariableVisitor().visit(pattern)
        encoded_pattern = self.encode_pattern(pattern)

        for var in sorted(free_vars, key=lambda v: v.name, reverse=True):
            encoded_pattern = mm.Application(
                "\\sorted-exists",
                (
                    self.encode_pattern(var),
                    self.encode_pattern(var.sort),
                    encoded_pattern,
                ),
            )

        return encoded_pattern

    def load_no_confusion_hooked_sort(
        self, sort_instance: kore.SortInstance, symbol_definition: kore.SymbolDefinition
    ) -> Theorem:
        num_sort_vars = len(symbol_definition.sort_variables)
        num_arguments = len(symbol_definition.input_sorts)

        encoded_symbol = KoreEncoder.encode_symbol(symbol_definition.symbol)

        pattern_var_names = self.gen_metavariables("#Pattern", num_sort_vars + num_arguments)
        pattern_vars = tuple(mm.Metavariable(v) for v in pattern_var_names)

        left_pattern = mm.Application(encoded_symbol, pattern_vars[:num_sort_vars + num_arguments])
        right_pattern = mm.Application("\\inh", (self.encode_pattern(sort_instance), ))

        assert isinstance(sort_instance.definition, kore.SortDefinition)

        sort_label = self.get_sort_label(sort_instance.definition)
        symbol_label = self.get_symbol_label(symbol_definition)

        axiom = mm.AxiomaticStatement(
            f"hooked-sort-no-confusion-{sort_label}-{symbol_label}",
            (
                mm.Application("|-"),
                mm.Application(
                    "\\not",
                    (mm.Application("\\and", (left_pattern, right_pattern)), ),
                ),
            ),
        )

        theorem = self.load(axiom)
        self.no_confusion_hooked_sort[sort_instance, symbol_definition] = theorem

        return theorem

    def get_no_confusion_hooked_sort(self, sort_instance: kore.SortInstance,
                                     symbol_definition: kore.SymbolDefinition) -> Optional[Theorem]:
        assert isinstance(sort_instance.definition, kore.SortDefinition)

        if not sort_instance.definition.hooked or symbol_definition not in self.constructors:
            return None

        if (sort_instance, symbol_definition) in self.no_confusion_hooked_sort:
            return self.no_confusion_hooked_sort[sort_instance, symbol_definition]

        return self.load_no_confusion_hooked_sort(sort_instance, symbol_definition)

    def load_sort_constructor_axioms(self) -> None:
        """
        Add no-junk axioms for sorts
        """
        # for usual user defined sort
        # if there is at least a constructor or a subsort
        # add the axiom that
        # [S] = ph0 \/ ... \/ phn
        # where each ph0 is of one of the following forms:
        #   - exists x1:S1 ... xn:Sn. f(x1, ..., xn)
        #   - exists x:R. x

        # TODO: what to do with domain values/hooked sorts

        for i, sort_definition in enumerate(self.all_sorts):
            if len(sort_definition.sort_variables) != 0:
                continue

            sort_instance = kore.SortInstance(sort_definition, [])
            sort_instance.resolve(self.module)

            subsorts = self.subsort_relation.get_immediate_subsort_of(sort_instance)
            constructors = self.sort_to_constructors.get(sort_instance, [])

            if len(subsorts) + len(constructors) != 0:
                # collect all components of the sort and make a no junk axiom
                components: List[Union[kore.Variable, kore.Application]] = []

                for subsort in subsorts:
                    (var, ) = self.gen_metavariables("#ElementVariable", 1)
                    components.append(kore.Variable(var, subsort))

                for constructor in constructors:
                    assert (len(constructor.sort_variables) == 0), "sort-parametric constructor is not supported"
                    variables = self.gen_metavariables("#ElementVariable", len(constructor.input_sorts))

                    application = kore.Application(
                        kore.SymbolInstance(constructor, []),
                        [kore.Variable(var, sort) for var, sort in zip(variables, constructor.input_sorts)],
                    )

                    components.append(application)

                assert len(components) != 0

                if len(components) == 1:
                    rhs = self.existentially_quantify_free_variables(components[0])
                else:
                    rhs = self.existentially_quantify_free_variables(components[-1])
                    for component in components[:-1][::-1]:
                        rhs = mm.Application(
                            "\\or",
                            (
                                self.existentially_quantify_free_variables(component),
                                rhs,
                            ),
                        )

                lhs = mm.Application("\\inh", (self.encode_pattern(sort_instance), ))
                axiom = mm.AxiomaticStatement(
                    f"no-junk-axiom-{i}",
                    (mm.Application("|-"), mm.Application("\\eq", (lhs, rhs))),
                )

                self.no_junk_axioms[sort_instance] = self.load(axiom)
                self.sort_components[sort_instance] = components

            # since we don't have information on any hooked sort
            # we will assume that any constructor is disjoint from
            # their domain
            # if sort_definition.hooked:
            #     for j, symbol_definition in enumerate(self.constructors):
            #         self.load_no_confusion_hooked_sort(sort_instance, symbol_definition)

    def get_sort_label(self, sort: kore.SortDefinition) -> str:
        assert sort in self.sort_labels
        return self.sort_labels[sort]

    def get_symbol_label(self, symbol: kore.SymbolDefinition) -> str:
        assert symbol in self.symbol_labels
        return self.symbol_labels[symbol]

    def load_module_sentences(self, module: kore.Module) -> None:
        """
        Load all relavent sentences
        """
        if module.name in self.loaded_modules:
            return

        self.loaded_modules[module.name] = module

        # visit all imported modules
        for import_stmt in module.imports:
            assert isinstance(import_stmt.module, kore.Module)
            self.load_module_sentences(import_stmt.module)

        with self.in_segment("sort"):
            for index, (_, sort_definition) in enumerate(module.sort_map.items()):
                self.sort_labels[sort_definition] = f"{module.name}-sort-{index}"
                self.load_sort_definition(sort_definition)

        with self.in_segment("symbol"):
            for index, (_, symbol_definition) in enumerate(module.symbol_map.items()):
                self.symbol_labels[symbol_definition] = f"{module.name}-symbol-{index}"
                self.load_symbol_definition(symbol_definition)

        for index, axiom in enumerate(module.axioms):
            functional_symbol = KoreTemplates.get_symbol_of_functional_axiom(axiom)
            is_rewrite = KoreTemplates.is_rewrite_axiom(axiom)
            is_anywhere = KoreTemplates.is_anywhere_rule_axiom(axiom)
            equation_head_symbol = KoreTemplates.get_symbol_of_equational_axiom(axiom)
            subsort_tuple = KoreTemplates.get_sorts_of_subsort_axiom(axiom)

            map_sort = KoreTemplates.is_map_commutativity_axiom(axiom)
            if map_sort is not None:
                assert map_sort not in self.map_commutativity_axiom
                self.map_commutativity_axiom[map_sort] = self.load_axiom(axiom, f"{module.name}-axiom-{index}")
                continue

            map_sort = KoreTemplates.is_map_associativity_axiom(axiom)
            if map_sort:
                assert map_sort not in self.map_associativity_axiom
                self.map_associativity_axiom[map_sort] = self.load_axiom(axiom, f"{module.name}-axiom-{index}")
                continue

            map_sort = KoreTemplates.is_map_right_unit_axiom(axiom)
            if map_sort:
                assert map_sort not in self.map_right_unit_axiom
                self.map_right_unit_axiom[map_sort] = self.load_axiom(axiom, f"{module.name}-axiom-{index}")
                continue

            if (functional_symbol is not None or is_rewrite or is_anywhere or equation_head_symbol is not None
                    or subsort_tuple is not None):
                claim = self.load_axiom(
                    axiom,
                    f"{module.name}-axiom-{index}",
                    rename=is_rewrite or is_anywhere or equation_head_symbol is not None,
                )

                # record these statements for later use
                if functional_symbol is not None:
                    self.functional_axioms[functional_symbol] = claim
                elif is_rewrite:
                    uid = KoreTemplates.get_axiom_unique_id(axiom)
                    assert uid is not None
                    self.rewrite_axioms[uid] = claim
                elif is_anywhere:
                    self.anywhere_axioms.append(claim)

                if equation_head_symbol is not None:
                    if equation_head_symbol not in self.equational_axioms:
                        self.equational_axioms[equation_head_symbol] = []
                    self.equational_axioms[equation_head_symbol].append(claim)

                # subsort axioms have the same form as functional axioms
                if subsort_tuple is not None:
                    sort1, sort2 = subsort_tuple
                    self.subsort_relation.add_subsort(sort1, sort2)

    def infer_premise_metavar(self, theorem: Theorem) -> Optional[mm.Metavariable]:
        """
        Given a kore lemma, infer the metavariable for premise
        """

        conclusion_premise, _ = MetamathUtils.destruct_premise(theorem.statement)

        premise: Optional[mm.Term] = conclusion_premise

        for essential in theorem.context.essentials:
            if not MetamathUtils.is_provable(essential.terms):
                continue

            essential_premise, essential_conclusion = MetamathUtils.destruct_premise(essential)
            if not MetamathUtils.is_kore_valid(essential_conclusion):
                continue

            if premise is not None and essential_premise is not None:
                assert premise == essential_premise, \
                       f"distinct premises appearing in the theorem: {premise} and {essential_premise}"
            premise = premise or essential_premise

        if premise is not None:
            assert isinstance(premise, mm.Metavariable), \
                   f"premise should be a metavariable, {premise} appears instead"

        return premise

    def infer_weakest_common_premise(
        self,
        provable_claims: Tuple[Union[Proof, ProvableClaim], ...],
    ) -> mm.Term:
        """
        Infer the weakest common premise used in all the proofs given
        We are basically taking the conjunction of all premises
        """
        common_premise = MetamathUtils.construct_top()

        for provable_claim in provable_claims:
            if isinstance(provable_claim, ProvableClaim):
                premise = self.encode_axiom_premise(provable_claim.claim)

                if premise is not None and not MetamathUtils.is_top(premise):
                    common_premise = MetamathUtils.construct_and(premise, common_premise)

        return common_premise

    def infer_essential_proofs(
        self,
        theorem: Theorem,
        common_premise: mm.Term,
        essential_provable_claims: Tuple[Union[Proof, ProvableClaim], ...],
    ) -> List[Union[Proof, AutoProof]]:
        essential_claim_index = 0
        essential_proofs: List[Union[Proof, AutoProof]] = []

        for essential in theorem.context.essentials:
            if MetamathUtils.is_substitution(essential.terms):
                essential_proofs.append(SubstitutionProver.auto)

            elif MetamathUtils.is_fresh(essential.terms):
                essential_proofs.append(FreshProver.auto)

            elif MetamathUtils.is_provable(essential.terms):
                premise, conclusion = MetamathUtils.destruct_premise(essential)

                if MetamathUtils.is_in_sort(conclusion):
                    essential_proofs.append(SortingProver.auto)

                elif MetamathUtils.is_is_predicate(conclusion) or \
                     MetamathUtils.is_kore_is_predicate(conclusion):
                    essential_proofs.append(PredicateProver.auto)

                else:  # MetamathUtils.is_kore_valid(conclusion):
                    # take from the given essential proofs
                    assert essential_claim_index < len(essential_provable_claims), \
                           f"not enough essential proofs are given"
                    essential_provable_claim = essential_provable_claims[essential_claim_index]
                    essential_claim_index += 1

                    if isinstance(essential_provable_claim, ProvableClaim):
                        essential_proof = essential_provable_claim.proof
                    else:
                        essential_proof = essential_provable_claim

                    # rearrange the premises of essential proofs to match the required form
                    essential_proof = SortingProver.rearrange_premise(
                        self, None if premise is None else common_premise, essential_proof
                    )
                    essential_proofs.append(essential_proof)
            else:
                assert False, f"cannot infer which proof to assign for hypothesis {essential}"

        assert essential_claim_index == len(essential_provable_claims), \
               f"too many essential proofs given"

        return essential_proofs

    def apply_kore_lemma(
        self,
        theorem_name: str,
        *essential_provable_claims: Union[Proof, ProvableClaim],
        goal: Optional[kore.Claim] = None,
        cache_key: Optional[str] = None,
        **substitution: Union[mm.Term, kore.Pattern, kore.Sort],
    ) -> ProvableClaim:
        r"""
        This is an abstraction over the lower level Theorem.apply or Theorem.match_and_apply

        A "kore lemma" refers to a specific form of theorems in the database
        in which:
        
        1. The conclusion is of the form
            |- ( \kore-valid ... )
            or
            |- ( \imp th0 ( \kore-valid ... ) )
        2. Any hypothesis is either of the same form as above or automatically resolvable (e.g. sorting, substitution)
        3. We can figure out all the assignment to any metavariable just by looking at non-trivial hypotheses
           and/or the conclusion
        4. If any of the hypotheses/conclusion has a premise (th0), it should be the same metavariable.
        """

        theorem = self.get_theorem(theorem_name)
        premise_metavar = self.infer_premise_metavar(theorem)
        common_premise = self.infer_weakest_common_premise(essential_provable_claims)

        # preprocess metavar substitution
        metavar_substitution: Dict[str, mm.Term] = {}
        for key, value in substitution.items():
            if isinstance(value, kore.Pattern) or isinstance(value, kore.SortVariable) or isinstance(value,
                                                                                                     kore.SortInstance):
                metavar_substitution[key] = self.encode_pattern(value)
            else:
                metavar_substitution[key] = value

        # construct a temporary list of essential claims
        # and infer the final claim so that we can add
        # necessary premises
        essential_proofs = self.infer_essential_proofs(theorem, common_premise, essential_provable_claims)

        if goal is not None:
            encoded_goal = self.encode_pattern(goal)
            _, goal_body = MetamathUtils.destruct_premise(MetamathUtils.construct_provable(encoded_goal))
            conclusion_premise, _ = MetamathUtils.destruct_premise(theorem.statement)
            if conclusion_premise is not None:
                goal_pattern: Optional[mm.StructuredStatement] = mm.StructuredStatement(
                    "",
                    MetamathUtils.construct_provable(MetamathUtils.construct_imp(common_premise, goal_body), ),
                )
            else:
                goal_pattern = mm.StructuredStatement(
                    "",
                    MetamathUtils.construct_provable(goal_body),
                )
        else:
            goal_pattern = None

        # figure out the form of the final claim
        tmp_substitution = theorem.infer_metavariable_substitution(
            goal_pattern,
            tuple(essential_proofs),
            metavar_substitution,
        )
        final_claim = KoreDecoder(self.module).decode_claim(theorem.get_conclusion_instance(tmp_substitution))
        final_claim_premise = self.encode_axiom_premise(final_claim)

        if not MetamathUtils.is_top(final_claim_premise):
            common_premise = MetamathUtils.construct_and(final_claim_premise, common_premise)

        # construct the final essential proofs
        essential_proofs = self.infer_essential_proofs(theorem, common_premise, essential_provable_claims)

        if premise_metavar is not None:
            metavar_substitution = metavar_substitution.copy()
            metavar_substitution[premise_metavar.name] = common_premise

        if goal is not None:
            encoded_goal = self.encode_pattern(goal)
            goal_premise, goal_body = MetamathUtils.destruct_premise(MetamathUtils.construct_provable(encoded_goal))
            conclusion_premise, _ = MetamathUtils.destruct_premise(theorem.statement)

            # arrange the goal into the expected form
            if conclusion_premise is not None:
                target = mm.StructuredStatement(
                    "",
                    MetamathUtils.construct_provable(MetamathUtils.construct_imp(common_premise, goal_body), ),
                )
            else:
                target = mm.StructuredStatement("", MetamathUtils.construct_provable(goal_body))

            proof = theorem.match_and_apply(target, *essential_proofs, **metavar_substitution)

            # now we need massage the proof to the expected form of the goal
            proof = SortingProver.rearrange_premise(self, goal_premise, proof)

            if cache_key is not None:
                proof = self.cache_proof(cache_key, proof)

            # if the goal is given, we can construct a ProvableClaim
            return ProvableClaim(goal, proof)
        else:
            proof = theorem.apply(*essential_proofs, **metavar_substitution)

            # decode a kore claim from the metamath proof
            body = MetamathUtils.destruct_provable(proof.conclusion)

            claim = KoreDecoder(self.module).decode_claim(body)
            claim_premise = self.encode_axiom_premise(claim)

            proof = SortingProver.rearrange_premise(self, claim_premise, proof)

            if cache_key is not None:
                proof = self.cache_proof(cache_key, proof)

            return ProvableClaim(claim, proof)
