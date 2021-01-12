from typing import List

from ..ast import Metavariable, Term, Application, StructuredStatement, Statement
from ..composer import Composer, Proof, Theorem

from .notation import NotationProver
from .typecode import TypecodeProver


"""
TODO: subsitution of patterns with \\exists and \\mu is not supported yet
"""
class SubstitutionProver:
    @staticmethod
    def get_target(
        after_pattern: Term,
        before_pattern: Term,
        subst_pattern: Term,
        subst_var: Metavariable,
    ) -> StructuredStatement:
        return StructuredStatement(Statement.PROVABLE, [
            Application("#Substitution"),
            after_pattern,
            before_pattern,
            subst_pattern,
            subst_var,
        ])

    """
    This method only deals with patterns consisting of
    the most basic constructs (\\bot, \\imp, \\app, \\exists, \\mu)
    and metavariables
    """
    @staticmethod
    def prove_desugared_substitution(
        composer: Composer,
        after_pattern: Term,
        before_pattern: Term,
        subst_pattern: Term,
        subst_var: Metavariable,
        hypotheses: List[Theorem]=[],
    ) -> Proof:
        target = SubstitutionProver.get_target(after_pattern, before_pattern, subst_pattern, subst_var)

        is_variable_metavar = TypecodeProver.prove_typecode(composer, "#Variable", before_pattern) is not None
        is_pattern_metavar = TypecodeProver.prove_typecode(composer, "#Pattern", before_pattern) is not None
        is_symbol_metavar = TypecodeProver.prove_typecode(composer, "#Symbol", before_pattern) is not None

        if before_pattern == subst_var and after_pattern == subst_pattern:
            return composer.find_theorem("substitution-var-same").match_and_apply(target)

        if after_pattern == before_pattern:
            if is_variable_metavar and before_pattern != subst_var:
                return composer.find_theorem("substitution-var-diff").match_and_apply(target)
            
            if subst_pattern == subst_var:
                return composer.find_theorem("substitution-identity").match_and_apply(target)
            
            if is_symbol_metavar:
                return composer.find_theorem("substitution-symbol").match_and_apply(target)

        if is_pattern_metavar:
            # try to find a hypothesis that says so
            for hypothesis in hypotheses:
                if hypothesis.statement.terms == target.terms:
                    return hypothesis.apply()

        if isinstance(before_pattern, Application):
            arity_map = {
                "\\bot": (0, "substitution-bot"),
                "\\imp": (2, "substitution-imp"),
                "\\app": (2, "substitution-app"),
            }

            if before_pattern.symbol in arity_map:
                arity, theorem_label = arity_map[before_pattern.symbol]

                assert len(after_pattern.subterms) == len(before_pattern.subterms) == arity

                subproofs = [
                    SubstitutionProver.prove_desugared_substitution(composer, after_subpattern, before_subpattern, subst_pattern, subst_var, hypotheses)
                    for after_subpattern, before_subpattern in zip(after_pattern.subterms, before_pattern.subterms)
                ]

                return composer.find_theorem(theorem_label).match_and_apply(target, *subproofs)

        assert False, f"unable to prove #Substitution {after_pattern} {before_pattern} {subst_pattern} {subst_var}"
    
    """
    Prove statement of the form
    #Substitution ph0 ph1 ph2 xX
    where ph0 is the result of substituting ph2 for xX in ph1

    Notations are also considered
    """
    @staticmethod
    def prove_substitution(
        composer: Composer,
        after_pattern: Term,
        before_pattern: Term,
        subst_pattern: Term,
        subst_var: Metavariable,
        hypotheses: List[Theorem]=[],
    ) -> Proof:
        # desugar everything first
        # TODO: there might be a more efficient way

        expanded_after_pattern, expansion_subproof1 = NotationProver.expand_sugar_with_proof(composer, after_pattern, desugar_all=True)
        expanded_before_pattern, expansion_subproof2 = NotationProver.expand_sugar_with_proof(composer, before_pattern, desugar_all=True)
        expanded_subst_pattern, expansion_subproof3 = NotationProver.expand_sugar_with_proof(composer, subst_pattern, desugar_all=True)

        subst_proof = SubstitutionProver.prove_desugared_substitution(
            composer,
            expanded_after_pattern,
            expanded_before_pattern,
            expanded_subst_pattern,
            subst_var,
            hypotheses=hypotheses
        )

        target = SubstitutionProver.get_target(expanded_after_pattern, expanded_before_pattern, expanded_subst_pattern, subst_var)
        assert subst_proof.statement.terms == target.terms

        return composer.find_theorem("notation-substitution").apply(
            subst_proof,
            expansion_subproof1,
            expansion_subproof2,
            expansion_subproof3,
        )
