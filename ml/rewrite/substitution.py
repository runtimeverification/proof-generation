from typing import List, Union, Tuple, TypeVar, Any

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils

from ml.metamath import ast as mm
from ml.metamath.composer import Theorem, Proof

from .encoder import KorePatternEncoder

from .env import KoreComposer, ProofGenerator

PAS = TypeVar("PAS", kore.Pattern, kore.Axiom, kore.Sort)


class SingleSubstitutionProofGenerator(ProofGenerator, kore.KoreVisitor[Union[kore.Pattern, kore.Axiom, kore.Sort],
                                                                        Proof]):
    """
    Given a kore pattern phi, pattern psi, and variable x, generate a proof for

    #Substitution phi[psi/x] phi psi x

    where phi[psi/x] is the actual pattern with x substituted with phi,
    with the assumption that distinct meta #Variable varible are disjoint

    This also support substituting sort variables
    """
    def __init__(
        self,
        env: KoreComposer,
        var: Union[kore.Variable, kore.SortVariable],
        substitute: Union[kore.Pattern, kore.Sort],
    ):
        super().__init__(env)

        if isinstance(var, kore.Variable):
            assert isinstance(substitute, kore.Pattern)
        else:
            assert isinstance(substitute, kore.SortVariable) or isinstance(substitute, kore.SortInstance)

        self.var = var
        self.substitute = substitute

        self.var_encoded = self.composer.encode_pattern(var)
        self.substitute_encoded = self.composer.encode_pattern(substitute)

        # get a "template" for the target statement
        # for convenience
        tmp1, tmp2 = self.composer.gen_metavariables("#Pattern", 2)
        self.target = mm.ProvableStatement(
            "",
            (
                mm.Application("#Substitution"),
                mm.Metavariable(tmp1),
                mm.Metavariable(tmp2),
                self.substitute_encoded,
                self.var_encoded,
            ),
        )

    def get_substituted_ast(self, pattern_or_sort: PAS) -> PAS:
        if isinstance(self.var, kore.Variable):
            assert isinstance(self.substitute, kore.Pattern)
            return KoreUtils.copy_and_substitute_pattern(pattern_or_sort, {self.var: self.substitute})
        else:
            assert isinstance(self.substitute, kore.SortVariable) or isinstance(self.substitute, kore.SortInstance)
            return KoreUtils.copy_and_substitute_sort(pattern_or_sort, {self.var: self.substitute})

    def prove_substitution(self, pattern_or_sort: PAS) -> Proof:
        return self.prove_substitution_with_result(pattern_or_sort)[0]

    def prove_substitution_with_result(self, pattern_or_sort: PAS) -> Tuple[Proof, PAS]:
        """
        In addition to the substitution proof, also return a actual substituted pattern/sort
        """
        substituted = self.get_substituted_ast(pattern_or_sort)

        # look up proof cache
        cache_key = (
            mm.Application("#Substitution"),
            self.composer.encode_pattern(substituted),
            self.composer.encode_pattern(pattern_or_sort),
            self.substitute_encoded,
            self.var_encoded,
        )
        cached_proof = self.composer.lookup_proof_cache("substitution-cache", cache_key)
        if cached_proof is not None:
            return cached_proof, substituted

        return self.composer.cache_proof("substitution-cache", self.visit(pattern_or_sort)), substituted

    def postvisit_axiom(self, axiom: kore.Axiom) -> Proof:
        # prove substitution of the pattern
        # \kore-forall-sort S1 ... \kore-forall-sort Sn \kore-valid ph0 ph1

        pattern_sort = KoreUtils.infer_sort(axiom.pattern)
        pattern_subst_proof = self.visit(axiom.pattern)
        sort_subst_proof = self.visit(pattern_sort)

        proof = self.composer.get_theorem("substitution-kore-valid").apply(
            sort_subst_proof,
            pattern_subst_proof,
        )

        shadowed_index = len(axiom.sort_variables)
        if isinstance(self.var, kore.SortVariable):
            # try to locate the position of the quantifer
            # which coincides with the substitution variables
            for i, sort_var in enumerate(axiom.sort_variables):
                if sort_var == self.var:
                    shadowed_index = i
                    break

            if shadowed_index < len(axiom.sort_variables):
                body = proof.conclusion[1]
                for sort_var in axiom.sort_variables[shadowed_index + 1:][::-1]:
                    encoded_sort_var = KorePatternEncoder.encode_sort_variable(sort_var)
                    body = mm.Application(
                        KorePatternEncoder.FORALL_SORT,
                        (
                            mm.Metavariable(encoded_sort_var),
                            body,
                        ),
                    )

                proof = self.composer.get_theorem("substitution-kore-forall-sort-shadowed").apply(
                    x=self.var_encoded,
                    ph0=body,
                    ph1=self.substitute_encoded,
                )

        # wrap the rest of forall-sort quantifiers
        for sort_var in axiom.sort_variables[:shadowed_index][::-1]:
            encoded_sort_var = KorePatternEncoder.encode_sort_variable(sort_var)
            proof = self.composer.get_theorem("substitution-kore-forall-sort").apply(
                proof, x=mm.Metavariable(encoded_sort_var)
            )

        return proof

    def postvisit_sort_instance(self, sort_instance: kore.SortInstance) -> Proof:
        symbol = KorePatternEncoder.encode_sort(sort_instance)
        return self.composer.substitution_axioms[symbol].match_and_apply(
            self.target,
            *(self.visit(arg) for arg in sort_instance.arguments),
        )

    def postvisit_sort_variable(self, sort_variable: kore.SortVariable) -> Proof:
        if sort_variable.name == self.var.name:
            return self.composer.get_theorem("substitution-var-same").apply(
                ph0=self.substitute_encoded, xX=self.var_encoded
            )
        else:
            return self.composer.get_theorem("substitution-var-diff").apply(
                yY=self.composer.encode_pattern(sort_variable),
                ph0=self.substitute_encoded,
                xX=self.var_encoded,
            )

    def postvisit_variable(self, var: kore.Variable) -> Proof:
        if var.name == self.var.name:
            return self.composer.get_theorem("substitution-var-same").apply(
                ph0=self.substitute_encoded, xX=self.var_encoded
            )
        else:
            return self.composer.get_theorem("substitution-var-diff").apply(
                yY=self.composer.encode_pattern(var),
                ph0=self.substitute_encoded,
                xX=self.var_encoded,
            )

    def postvisit_string_literal(self, literal: kore.StringLiteral) -> Proof:
        symbol = KorePatternEncoder.encode_string_literal(literal)
        return self.composer.substitution_axioms[symbol].match_and_apply(self.target)

    def postvisit_application(self, application: kore.Application) -> Proof:
        symbol = KorePatternEncoder.encode_symbol(application.symbol)
        return self.composer.substitution_axioms[symbol].match_and_apply(
            self.target,
            *(self.visit(arg) for arg in application.symbol.sort_arguments),
            *(self.visit(arg) for arg in application.arguments),
        )

    ML_PATTERN_SUBST_MAP = {
        kore.MLPattern.TOP: "substitution-kore-top",
        kore.MLPattern.BOTTOM: "substitution-kore-bottom",
        kore.MLPattern.NOT: "substitution-kore-not",
        kore.MLPattern.AND: "substitution-kore-and",
        kore.MLPattern.OR: "substitution-kore-or",
        kore.MLPattern.CEIL: "substitution-kore-ceil",
        kore.MLPattern.FLOOR: "substitution-kore-floor",
        kore.MLPattern.EQUALS: "substitution-kore-equals",
        kore.MLPattern.IN: "substitution-kore-in",
        kore.MLPattern.REWRITES: "substitution-kore-rewrites",
        kore.MLPattern.REWRITES_STAR: "substitution-kore-rewrites-star",
        kore.MLPattern.DV: "substitution-kore-dv",
        kore.MLPattern.IMPLIES: "substitution-kore-implies",
    }

    def postvisit_ml_pattern(self, ml_pattern: kore.MLPattern) -> Proof:
        if (ml_pattern.construct in SingleSubstitutionProofGenerator.ML_PATTERN_SUBST_MAP):
            theorem_label = SingleSubstitutionProofGenerator.ML_PATTERN_SUBST_MAP[ml_pattern.construct]
            return self.composer.get_theorem(theorem_label).apply(
                *(self.visit(arg) for arg in ml_pattern.sorts),
                *(self.visit(arg) for arg in ml_pattern.arguments),
            )
        elif (ml_pattern.construct == kore.MLPattern.FORALL or ml_pattern.construct == kore.MLPattern.EXISTS):
            binding_var = ml_pattern.get_binding_variable()
            assert binding_var is not None

            body = ml_pattern.arguments[1]
            body_sort = ml_pattern.sorts[0]

            if binding_var == self.var:
                # shadowed
                theorem_name = (
                    "substitution-kore-forall-shadowed"
                    if ml_pattern.construct == kore.MLPattern.FORALL else "substitution-kore-exists-shadowed"
                )
                return self.composer.get_theorem(theorem_name).apply(ph2=self.composer.encode_pattern(body))
            else:
                theorem_name = (
                    "substitution-kore-forall"
                    if ml_pattern.construct == kore.MLPattern.FORALL else "substitution-kore-exists"
                )

                var_sort_subproof = self.visit(binding_var.sort)
                body_subproof = self.visit(body)

                encoded_body_sort = self.composer.encode_pattern(body_sort)

                return self.composer.get_theorem(theorem_name).apply(
                    var_sort_subproof,
                    body_subproof,
                    ph1=encoded_body_sort,
                    ph4=encoded_body_sort,
                    y=self.composer.encode_pattern(binding_var),  # still need to specify the binding variable
                )

        else:
            raise Exception("unsupported construct {}".format(ml_pattern))
