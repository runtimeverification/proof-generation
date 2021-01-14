from __future__ import annotations

from typing import Optional, Union, List, Tuple, Mapping, Set, TextIO

import re

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils

from ml.metamath import ast as mm
from ml.metamath.visitors import SubstitutionVisitor
from ml.metamath.composer import Composer, Theorem, Proof
from ml.metamath.auto.substitution import SubstitutionProver

from .encoder import KorePatternEncoder


class ProofGenerator:
    def __init__(self, env: ProofEnvironment):
        self.env = env


"""
A claim in kore and a metamath proof of its encoding
This pair comes up often because we need to
reuse some operations and information on the Kore ast
"""
class ProvableClaim:
    def __init__(self, claim: kore.Claim, proof: Proof):
        encoded_claim = KorePatternEncoder().visit(claim)
        assert isinstance(proof, Proof)
        assert encoded_claim == proof.statement.terms[1], \
               f"provable claim invariant failed: {encoded_claim} != {proof.statement.terms[1]}"
        self.claim = claim
        self.proof = proof


"""
A data structure that stores the subsort
relation (a strict partial order)
"""
class SubsortRelation:
    def __init__(self):
        self.adj_list: \
            Mapping[kore.SortInstance, List[Tuple[kore.SortInstance, Theorem]]] = {}
        # SortInstance -> [ ( supersort, subsorting lemma ) ... ]

    """
    Return a chain of immediate subsorting: sort1 < A < B < ... < sort2,
    if sort1 < sort2; otherwise return None
    """
    def get_subsort_chain(self, sort1: kore.SortInstance, sort2: kore.SortInstance) -> Optional[List[kore.SortInstance]]:
        if sort1 == sort2: return None
        if sort1 not in self.adj_list: return None

        for intermediate, _ in self.adj_list[sort1]:
            if intermediate == sort2:
                return [ sort1, sort2 ]

            chain = self.get_subsort_chain(intermediate, sort2)
            if chain is not None:
                return [ sort1 ] + chain

                # raise NotImplementedError("non-immediate subsorting not supported")
                # TODO: use injection lemma to chain subsorts

        return None

    """
    Add sort1 < sort2
    """
    def add_subsort(self, sort1: kore.SortInstance, sort2: kore.SortInstance, subsort_axiom: Theorem):
        assert sort1 != sort2, f"subsort relation should be irreflexive: {sort1} </ {sort2}"
        assert self.get_subsort_chain(sort2, sort1) is None, f"cyclic subsorting: {sort1} ? {sort2}"

        if sort1 not in self.adj_list:
            self.adj_list[sort1] = []
        self.adj_list[sort1].append((sort2, subsort_axiom))

    def __str__(self):
        return "\n".join([
            "{} < {}".format(sort, ", ".join([ str(supersort) for supersort, _ in supersorts ]))
            for sort, supersorts in self.adj_list.items()
        ])


"""
ProofEnvironment holds a composer
and current status of a database

This should be independent of the
type of proof one wants to build
"""
class ProofEnvironment:
    def __init__(self, composer: Composer=Composer()):
        self.module = None
        self.loaded_modules = {}

        #################################
        # some axioms that will be used later
        #################################
        self.functional_axioms = {} # symbol instance -> provable claim
        self.domain_value_functional_axioms = {} # (sort, string literal) -> provable claim
        self.rewrite_axioms = {} # unique id -> provable claim
        self.anywhere_axioms = [] # provable claims
        self.substitution_axioms = {} # constant symbol (in metamath) -> theorem
        self.sort_axioms = {} # constant symbol (in metamath) -> theorem
        self.sorting_lemmas = {} # constant symbol (in metamath) -> theorem
        self.equational_axioms = {} # symbol instance -> provable claim

        self.sort_injection_symbol = None
        self.sort_injection_axiom = None
        self.subsort_relation = SubsortRelation()

        self.domain_values = set() # set of (sort, string literal)

        self.composer = composer

    """
    Expand all aliases and quantify all free variables
    """
    def preprocess_module(self, module: kore.Module):
        print("preprocessing module {}".format(module.name))

        for import_stmt in module.imports:
            self.preprocess_module(import_stmt.module)

        KoreUtils.instantiate_all_alias_uses(module)
        KoreUtils.quantify_all_free_variables(module)

    """
    Translate all axioms in the kore module
    """
    def load_module(self, module: kore.Module):
        assert self.module is None, "loading multiple modules"

        self.module = module

        self.preprocess_module(self.module)
        self.load_module_sentences(self.module)

        # load INJ module for the sort injection axiom
        if "INJ" in self.loaded_modules:
            inj_module = self.loaded_modules["INJ"]
            assert "inj" in inj_module.symbol_map, "cannot find sort injection function symbol"
            self.sort_injection_symbol = inj_module.symbol_map["inj"]

            assert len(inj_module.axioms) == 1, "unexpected INJ module content"
            self.sort_injection_axiom = ProvableClaim(
                inj_module.axioms[0],
                self.load_axiom(inj_module.axioms[0], "kore-inj-axiom").as_proof(),
            )

    def sanitize_label_name(self, label):
        # metamath does not allow some characters in the label
        return re.sub(r"[^a-zA-Z0-9_\-.]", "", label)

    """
    Load metavariables into the composer
    metavar_map: map from metavariable name to typecode
    """
    def load_metavariables(self, metavar_map: Mapping[str, str]):
        self.composer.start_segment("variable")

        # filter out existing metavariables and
        # check duplication (different typecode for the same variable)
        new_metavars = {}
        for var, typecode in metavar_map.items():
            found_typecode = self.find_metavariable(var)

            if found_typecode is None:
                new_metavars[var] = typecode
            else:
                assert found_typecode == typecode, \
                       "inconsistent metavariable typecode: both {} and {} for variable {}".format(found_typecode, typecode, var)

        if not new_metavars:
            self.composer.end_segment()
            return

        self.load_comment(f"adding {len(new_metavars)} new metavariable(s)")

        var_stmt = mm.RawStatement(mm.Statement.VARIABLE, list(new_metavars.keys()))
        self.load_metamath_statement(var_stmt)

        for var, typecode in new_metavars.items():
            floating_stmt = mm.StructuredStatement(mm.Statement.FLOATING, [
                mm.Application(typecode),
                mm.Metavariable(var),
            ], label=f"{self.sanitize_label_name(var)}-{typecode.replace('#', '').lower()}")

            self.load_metamath_statement(floating_stmt)

        # if we have added any #ElementVariable
        # and the total number of element variables
        # is > 1, then generate a new disjoint statement
        if "#ElementVariable" in set(new_metavars.values()):
            element_vars = self.composer.find_metavariables_of_typecode("#ElementVariable")
            if len(element_vars) > 1:
                disjoint_stmt = mm.StructuredStatement(mm.Statement.DISJOINT, list(map(mm.Metavariable, element_vars)))
                self.load_metamath_statement(disjoint_stmt)

        self.composer.end_segment()

    def encode_pattern(self, pattern: Union[kore.Axiom, kore.Pattern, kore.Sort]) -> mm.Term:
        encoder = KorePatternEncoder()
        term = encoder.visit(pattern)
        self.load_metavariables(encoder.metavariables)
        self.load_domain_values(encoder.domain_values)
        return term

    def get_theorem(self, label: str) -> Theorem:
        return self.composer.theorems[label]

    def load_metamath_database(self, database: mm.Database):
        return self.composer.load(database)

    def load_metamath_statement(self, statement: mm.Statement) -> Optional[Theorem]:
        return self.composer.load(statement)

    def load_comment(self, comment: str):
        return self.load_metamath_statement(mm.Comment(comment))

    """
    Given a proof of some statement, turns it into a theorem
    """
    def load_proof_as_theorem(self, label: str, proof: Proof) -> Theorem:
        proof.statement.label = label
        return self.load_metamath_statement(proof.statement)

    """
    Returns a new provable claim with the proof using the loaded theorem
    """
    def load_provable_claim_as_theorem(self, label: str, provable: ProvableClaim) -> ProvableClaim:
        new_proof = self.load_proof_as_theorem(label, provable.proof).as_proof()
        return ProvableClaim(provable.claim, new_proof)


    """
    Encode and load a Kore axiom into the generator
    and return the corresponding theorem object
    """
    def load_axiom(self, axiom: kore.Axiom, label: str, comment=True, provable=False) -> Theorem:
        term = self.encode_pattern(axiom)

        if comment:
            self.load_comment(str(axiom))

        # <label> $a |- <axiom> $.
        stmt = mm.StructuredStatement(
            mm.Statement.AXIOM if not provable else mm.Statement.PROVABLE,
            [ mm.Application("|-"), term ],
            label=label,
        )
        
        return self.load_metamath_statement(stmt)

    def load_symbol_sorting_lemma(self, symbol_definition: kore.SymbolDefinition, label: str):
        encoded_symbol = KorePatternEncoder.encode_symbol(symbol_definition.symbol)
        arity = len(symbol_definition.sort_variables) + len(symbol_definition.input_sorts)

        pattern_vars = self.gen_metavariables("#Pattern", arity)
        pattern_vars = [ mm.Metavariable(v) for v in pattern_vars ]

        sort_pattern_vars = pattern_vars[:len(symbol_definition.sort_variables)]
        argument_pattern_vars = pattern_vars[len(symbol_definition.sort_variables):]

        # for simplicity, we replace all sort variables (which are #ElementVariable's)
        # by pattern variables since \\kore-is-sort implies they are singletons
        sort_var_subst = {
            self.encode_pattern(element_var).name: pattern_var
            for element_var, pattern_var in zip(symbol_definition.sort_variables, sort_pattern_vars)
        }
        sort_var_subst_visitor = SubstitutionVisitor(sort_var_subst)

        encoded_output_sort = self.encode_pattern(symbol_definition.output_sort)
        encoded_output_sort = sort_var_subst_visitor.visit(encoded_output_sort)

        sorting_axiom_rhs = mm.Application("\\in-sort", [
            mm.Application(encoded_symbol, [ v for v in pattern_vars ]),
            encoded_output_sort,
        ])

        sorting_axiom_hypotheses = []

        # add hypotheses for sort arguments
        for v in sort_pattern_vars:
            sorting_axiom_hypotheses.append(mm.Application("\\kore-is-sort", [ v ]))

        # add hypotheses for pattern arguments
        for v, sort in zip(argument_pattern_vars, symbol_definition.input_sorts):
            encoded_sort = self.encode_pattern(sort)
            encoded_sort = sort_var_subst_visitor.visit(encoded_sort)
            sorting_axiom_hypotheses.append(mm.Application("\\in-sort", [ v, encoded_sort ]))

        # construct the hypothesis and the entire statement
        # hypothesis: \and ( \in-sort ph0 <sort0> ) ( \in-sort ph1 <sort1> ) ...
        if len(sorting_axiom_hypotheses) == 0:
            sorting_axiom_term = sorting_axiom_rhs
        elif len(sorting_axiom_hypotheses) == 1:
            sorting_axiom_term = mm.Application("\\imp", [ sorting_axiom_hypotheses[0], sorting_axiom_rhs ])
        else:
            lhs = mm.Application("\\and", sorting_axiom_hypotheses[:2])
            for hyp in sorting_axiom_hypotheses[2:]:
                lhs = mm.Application("\\and", [ lhs, hyp ])
            sorting_axiom_term = mm.Application("\\imp", [ lhs, sorting_axiom_rhs ])

        self.sorting_lemmas[encoded_symbol] = self.load_metamath_statement(mm.StructuredStatement(
            mm.Statement.AXIOM,
            [
                mm.Application("|-"),
                sorting_axiom_term,
            ],
            label=f"{label}-sorting",
        ))

    def load_symbol_definition(self, symbol_definition: kore.SymbolDefinition, label: str):
        encoded_symbol = KorePatternEncoder.encode_symbol(symbol_definition.symbol)
        arity = len(symbol_definition.sort_variables) + len(symbol_definition.input_sorts)

        self.load_comment(str(symbol_definition))
        self.load_constant(encoded_symbol, arity, label)

        self.load_symbol_sorting_lemma(symbol_definition, label)

    def load_sort_definition(self, sort_definition: kore.SortDefinition, label: str):
        encoded_sort = KorePatternEncoder.encode_sort(sort_definition.sort_id)
        arity = len(sort_definition.sort_variables)

        assert arity == 0, "parametric sort not supported"

        self.load_comment(str(sort_definition))
        self.load_constant(encoded_sort, arity, label)

        self.sort_axioms[encoded_sort] = self.load_metamath_statement(mm.StructuredStatement(
            mm.Statement.AXIOM,
            [
                mm.Application("|-"),
                mm.Application(KorePatternEncoder.IS_SORT, [ mm.Application(encoded_sort) ]),
            ],
            label=f"{label}-sort",
        ))

    """
    Load a domain value and generate the corresponding functional axiom
    """
    def load_domain_values(self, domain_values: Set[Tuple[kore.Sort, kore.StringLiteral]]):
        new_domain_values = domain_values.difference(self.domain_values)
        offset = len(self.domain_values)
        self.domain_values.update(new_domain_values)

        self.composer.start_segment("dv")

        for index, (sort, literal) in enumerate(new_domain_values):
            index += offset

            self.load_comment(f"domain value {literal} of sort {sort}")

            self.load_constant(KorePatternEncoder.encode_string_literal(literal), 0, f"domain-value-{index}")

            functional_rule_name = f"domain-value-{index}-functional"

            # TODO: check the literal is actually correct

            sort_var, functional_var = self.gen_metavariables("#ElementVariable", 2)

            functional_axiom = kore.Axiom(
                [ kore.SortVariable(sort_var) ],
                kore.MLPattern(
                    kore.MLPattern.EXISTS,
                    [ kore.SortVariable(sort_var) ],
                    [
                        kore.Variable(functional_var, sort),
                        kore.MLPattern(
                            kore.MLPattern.EQUALS,
                            [ sort, kore.SortVariable(sort_var) ],
                            [
                                kore.Variable(functional_var, sort),
                                kore.MLPattern(
                                    kore.MLPattern.DV,
                                    [ sort ], [ literal ],
                                ),
                            ],
                        ),
                    ],
                ),
                []
            )
            
            functional_axiom.resolve(self.module)

            theorem = self.load_axiom(functional_axiom, functional_rule_name)
            self.domain_value_functional_axioms[sort, literal] = ProvableClaim(functional_axiom, theorem.as_proof())

        self.composer.end_segment()

    """
    Load a constant symbol into the composer
    and generate appropriate axioms (e.g. substitution rule)
    """
    def load_constant(self, symbol: str, arity: int, label: str):
        # allocate all required metavariable at once
        subst_var, = self.gen_metavariables("#Variable", 1)
        pattern_var, *subpattern_vars = self.gen_metavariables("#Pattern", arity * 2 + 1)
        pattern_vars = [ pattern_var ] + list(subpattern_vars)

        # declare metamath constant
        # this is the actual symbol at the matching logic level used for application
        applicative_symbol = symbol + "-symbol"
        self.load_metamath_statement(mm.RawStatement(mm.Statement.CONSTANT, [ symbol, applicative_symbol ]))

        sugared_pattern = mm.Application(symbol, [ mm.Metavariable(v) for v in pattern_vars[:arity] ])

        # declare #Symbol
        self.load_metamath_statement(mm.StructuredStatement(mm.Statement.AXIOM, [
            mm.Application("#Symbol"),
            mm.Application(applicative_symbol),
        ], label=label + "-is-symbol"))

        # declare #Pattern
        self.load_metamath_statement(mm.StructuredStatement(mm.Statement.AXIOM, [
            mm.Application("#Pattern"),
            sugared_pattern,
        ], label=label + "-is-pattern"))

        # declare syntax sugar
        desugared = mm.Application(applicative_symbol)
        for var in pattern_vars[:arity]:
            desugared = mm.Application("\\app", [ desugared, mm.Metavariable(var) ])

        self.load_metamath_statement(mm.StructuredStatement(mm.Statement.AXIOM, [
            mm.Application("#Notation"),
            sugared_pattern,
            desugared,
        ], label=label + "-is-sugar"))

        # generate substitution rule
        self.composer.start_segment("substitution")

        substitution_rule_name = label + "-substitution"
        essentials = []
        essential_theorems = []

        for i in range(arity):
            after = subpattern_vars[i]
            before = subpattern_vars[i + arity]

            essential = mm.StructuredStatement(mm.Statement.ESSENTITAL, [
                mm.Application("#Substitution"),
                mm.Metavariable(after),
                mm.Metavariable(before),
                mm.Metavariable(pattern_var),
                mm.Metavariable(subst_var),
            ], label=f"{substitution_rule_name}.{i}")

            essentials.append(essential)
            essential_theorems.append(Theorem(self.composer, essential, [], []))

        # prove the substitution rule
        subst_proof = SubstitutionProver.prove_substitution(
            self.composer,
            mm.Application(symbol, list(map(mm.Metavariable, subpattern_vars[:arity]))),
            mm.Application(symbol, list(map(mm.Metavariable, subpattern_vars[arity:]))),
            mm.Metavariable(pattern_var),
            mm.Metavariable(subst_var),
            essential_theorems,
        )
        subst_proof.statement.label = substitution_rule_name

        self.load_metamath_statement(mm.Block(essentials + [ subst_proof.statement ]))

        self.composer.end_segment()

        assert substitution_rule_name in self.composer.theorems
        self.substitution_axioms[symbol] = self.composer.theorems[substitution_rule_name]

    """
    Get the name for the nth metavariable of the given typecode
    """
    def get_metavariable_name(self, typecode: str, n: int) -> str:
        if typecode == "#ElementVariable":
            return { 0: "x", 1: "y", 2: "z", 3: "w" }.get(n, f"x{n}")
        elif typecode == "#Variable":
            return { 0: "xX", 1: "yY", 2: "zZ", 3: "wW" }.get(n, f"xX{n}")
        elif typecode == "#Pattern":
            return f"ph{n}"
        else:
            return f"var-{typecode.replace('#', '').lower()}"

    def find_metavariable(self, var: str) -> str:
        return self.composer.find_metavariable(var)

    """
    Generate n metavariables
    and add the new ones to the composer
    """
    def gen_metavariables(self, typecode: str, n: int) -> List[str]:
        metavars = [ self.get_metavariable_name(typecode, i) for i in range(n) ]
        self.load_metavariables({ var: typecode for var in metavars })
        return metavars

    """
    Generate n fresh variables other than the variables in `other_than`
    """
    def gen_fresh_metavariables(self, typecode: str, n: int, other_than: Set[str]) -> List[str]:
        metavars = set()
        current_extra = 0
        while len(metavars.difference(other_than)) < n:
            metavars = set(self.gen_metavariables(typecode, current_extra + n))
            current_extra += 1 
        return list(metavars.difference(other_than))

    def is_rewrite_axiom(self, axiom: kore.Axiom) -> bool:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        return isinstance(inner_pattern, kore.MLPattern) and inner_pattern.construct == kore.MLPattern.REWRITES

    def is_anywhere_rule_axiom(self, axiom: kore.Axiom) -> bool:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        return isinstance(inner_pattern, kore.MLPattern) and \
               inner_pattern.construct == kore.MLPattern.IMPLIES and \
               isinstance(inner_pattern.arguments[1], kore.MLPattern) and \
               inner_pattern.arguments[1].construct == kore.MLPattern.AND and \
               isinstance(inner_pattern.arguments[1].arguments[0], kore.Pattern) and \
               inner_pattern.arguments[1].arguments[0].construct == kore.MLPattern.EQUALS

    def is_functional_axiom(self, axiom: kore.Axiom) -> bool:
        return axiom.get_attribute_by_symbol("functional") is not None or \
               axiom.get_attribute_by_symbol("subsort") is not None

    def is_equational_axiom(self, axiom: kore.Axiom) -> Optional[kore.SymbolInstance]:
        inner_pattern = KoreUtils.strip_forall(axiom.pattern)
        if not (isinstance(inner_pattern, kore.MLPattern) and inner_pattern.construct == kore.MLPattern.IMPLIES):
            return None

        rhs = inner_pattern.arguments[1]
        if not (isinstance(rhs, kore.MLPattern) and rhs.construct == kore.MLPattern.AND):
            return None

        equation = rhs.arguments[0]
        if not (isinstance(equation, kore.MLPattern) and equation.construct == kore.MLPattern.EQUALS):
            return None

        eqn_lhs = equation.arguments[0]
        if not isinstance(eqn_lhs, kore.Application):
            return None

        return eqn_lhs.symbol

    def is_subsort_axiom(self, axiom: kore.Axiom) -> Optional[Tuple[kore.SortInstance, kore.SortInstance]]:
        attribute = axiom.get_attribute_by_symbol("subsort")
        if attribute is None: return None

        sort1, sort2 = attribute.symbol.sort_arguments
        sort1.resolve(axiom.get_parent())
        sort2.resolve(axiom.get_parent())

        return sort1, sort2

    """
    Get the content of the attribute UNIQUE'Unds'ID{}(...)
    """
    def get_axiom_unique_id(self, axiom: kore.Axiom) -> Optional[str]:
        id_term = axiom.get_attribute_by_symbol("UNIQUE'Unds'ID")
        if id_term is None: return None
        assert len(id_term.arguments) == 1 and isinstance(id_term.arguments[0], kore.StringLiteral)
        return id_term.arguments[0].content

    """
    Get the corresponding symbol instance of the given functional axiom
    """
    def get_functional_axiom_symbol(self, axiom: kore.Axiom) -> kore.SymbolInstance:
        assert isinstance(axiom.pattern, kore.MLPattern)

        inner_existential = axiom.pattern

        # get to the inner existential pattern
        while inner_existential.construct == kore.MLPattern.FORALL:
            inner_existential = inner_existential.arguments[1]
            assert isinstance(inner_existential, kore.MLPattern)

        assert inner_existential.construct == kore.MLPattern.EXISTS

        equality = inner_existential.arguments[1]
        assert isinstance(equality, kore.MLPattern) and equality.construct == kore.MLPattern.EQUALS

        rhs = equality.arguments[1]
        assert isinstance(rhs, kore.Application)

        return rhs.symbol

    """
    Load all relavent sentences
    """
    def load_module_sentences(self, module: kore.Module):
        if module.name in self.loaded_modules:
            return

        self.loaded_modules[module.name] = module

        # visit all imported modules
        for import_stmt in module.imports:
            self.load_module_sentences(import_stmt.module)

        self.composer.start_segment("sort")
        for index, (_, sort_definition) in enumerate(module.sort_map.items()):
            self.load_sort_definition(sort_definition, f"{module.name}-sort-{index}")
        self.composer.end_segment()

        self.composer.start_segment("symbol")
        for index, (_, symbol_definition) in enumerate(module.symbol_map.items()):
            self.load_symbol_definition(symbol_definition, f"{module.name}-symbol-{index}")
        self.composer.end_segment()

        for index, axiom in enumerate(module.axioms):
            is_functional = self.is_functional_axiom(axiom)
            is_rewrite = self.is_rewrite_axiom(axiom)
            is_anywhere = self.is_anywhere_rule_axiom(axiom)
            equation_head_symbol = self.is_equational_axiom(axiom)
            subsort_tuple = self.is_subsort_axiom(axiom)

            if is_functional or is_rewrite or is_anywhere or equation_head_symbol is not None or subsort_tuple is not None:
                theorem = self.load_axiom(axiom, f"{module.name}-axiom-{index}")

                # record these statements for later use
                if is_functional:
                    symbol = self.get_functional_axiom_symbol(axiom)
                    self.functional_axioms[symbol] = ProvableClaim(axiom, theorem.as_proof())
                elif is_rewrite:
                    uid = self.get_axiom_unique_id(axiom)
                    self.rewrite_axioms[uid] = ProvableClaim(axiom, theorem.as_proof())
                elif is_anywhere:
                    self.anywhere_axioms.append(ProvableClaim(axiom, theorem.as_proof()))
                
                if equation_head_symbol is not None:
                    if equation_head_symbol not in self.equational_axioms:
                        self.equational_axioms[equation_head_symbol] = []
                    self.equational_axioms[equation_head_symbol].append(ProvableClaim(axiom, theorem.as_proof()))
                
                # subsort axioms have the same form as functional axioms
                if subsort_tuple is not None:
                    sort1, sort2 = subsort_tuple
                    self.subsort_relation.add_subsort(sort1, sort2, theorem)
