from typing import Optional, Tuple, List, Union

from traceback import print_exc

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils
from ml.kore.visitors import FreePatternVariableVisitor

from ml.metamath import ast as mm
from ml.metamath.composer import Proof
from ml.metamath.auto.substitution import SubstitutionProver
from ml.metamath.auto.sorting import SortingProver

from .env import ProofGenerator
from .encoder import KoreEncoder


class DisjointnessProofGenerator(ProofGenerator):
    r"""
    The disjointness proof generator generates proof for
    patterns of the form

    phi /\ not (exists x1, ..., xn. psi(x1, ..., xn))

    where phi is expected to be a functional pattern

    The primary usage of it is to prove conditions for
    [owise] rules, which assumes that a pattern
    does NOT unify with a pattern.
    """
    def get_free_vars_in_pattern(self, pattern: kore.Pattern) -> List[kore.Variable]:
        free_vars = FreePatternVariableVisitor().visit(pattern)
        return sorted(free_vars, key=lambda v: v.name, reverse=True)

    def existentially_quantify_free_variables(self, pattern: kore.Pattern) -> mm.Term:
        r"""
        Given a Kore pattern, existentially quantify all free variables using \sorted-exists
        then return the encoded metamath pattern
        """

        free_vars = self.get_free_vars_in_pattern(pattern)
        encoded_pattern = self.composer.encode_pattern(pattern)

        for var in free_vars:
            encoded_pattern = mm.Application(
                "\\sorted-exists",
                (
                    self.composer.encode_pattern(var),
                    self.composer.encode_pattern(var.sort),
                    encoded_pattern,
                ),
            )

        return encoded_pattern

    def get_disjointness_pattern(self, left: kore.Pattern, right: kore.Pattern, quantify: bool = True) -> mm.Term:
        r"""
        Return the metamath term
        not (<left> /\ exists x1, ..., xn. <right>)
        all free variables should be exitentially quantified
        """
        left_term = (
            self.existentially_quantify_free_variables(left) if quantify else self.composer.encode_pattern(left)
        )
        right_term = (
            self.existentially_quantify_free_variables(right) if quantify else self.composer.encode_pattern(right)
        )

        return mm.Application("\\not", (mm.Application("\\and", (left_term, right_term)), ))

    def get_disjointness_statement(
        self,
        left: kore.Pattern,
        right: kore.Pattern,
        quantify: bool = True,
    ) -> mm.StructuredStatement:
        """
        Same as above but wraps it in a metamath statement
        """
        disjointness = self.get_disjointness_pattern(left, right, quantify)
        return mm.ProvableStatement(
            "",
            (mm.Application("|-"), disjointness),
        )

    def make_app_context(self, app: mm.Application, i: int) -> Proof:
        """
        Given an application f(ph1, ...)
        make a "hole" at the ith argument to make it an application context,
        and return the proof that it is an application context
        """

        metavars = app.get_metavariables()
        (free_var_name, ) = self.composer.gen_fresh_metavariables("#ElementVariable", 1, metavars)
        free_var = mm.Metavariable(free_var_name)

        # f(..., xX, ...)
        subterms = list(app.subterms)
        subterms[i] = free_var
        app_ctx = mm.Application(app.symbol, tuple(subterms))

        assert app.symbol in self.composer.app_ctx_lemmas and i < len(
            self.composer.app_ctx_lemmas[app.symbol]
        ), f"unable to find the application context lemmas for {app.symbol} at position {i}"

        app_ctx_lemma = self.composer.app_ctx_lemmas[app.symbol][i]

        app_ctx_proof = app_ctx_lemma.match_and_apply(
            mm.ProvableStatement(
                "",
                (mm.Application("#ApplicationContext"), free_var, app_ctx),
            ),
            self.composer.get_theorem("application-context-var").apply(xX=free_var),
        )

        return app_ctx_proof

    def propagate_exists_out(self, app: mm.Application, i: int) -> Proof:
        """
        Propagate all existential quantifiers at the ith argument out
        Given an application f(..., sorted-exists x y. phi(x, y), ...)
        Return the proof of
        (sorted-exists x y. f(..., phi(x, y), ...)) -> f(..., sorted-exists x y. phi(x, y), ...)
        """
        assert i < len(app.subterms)
        ith_arg = app.subterms[i]

        # base case, nothing to propagation, return imp-reflexivity
        if (not isinstance(ith_arg, mm.Application) or ith_arg.symbol != "\\sorted-exists"):
            return self.composer.get_theorem("imp-reflexivity").apply(ph0=app)

        ith_arg_body = ith_arg.subterms[2]

        # create a term that looks like (sorted-exists x y. f(..., phi(x, y), ...))
        app_subterms = list(app.subterms)
        app_subterms[i] = ith_arg_body
        lhs_body = mm.Application(app.symbol, tuple(app_subterms))

        ith_arg_subterms = list(ith_arg.subterms)
        ith_arg_subterms[2] = lhs_body
        lhs = mm.Application(ith_arg.symbol, tuple(ith_arg_subterms))

        app_ctx_proof = self.make_app_context(app, i)
        subproof = self.propagate_exists_out(lhs_body, i)

        # some substitutions required by the theorem (due to meta-incompleteness)
        # see the statement of sorted-exists-propagation-converse for more info
        app_subterms = list(app.subterms)
        app_subterms[i] = mm.Application(
            "\\and",
            (
                mm.Application("\\in-sort", (ith_arg.subterms[0], ith_arg.subterms[1])),
                ith_arg_body,
            ),
        )
        subst1 = mm.Application(app.symbol, tuple(app_subterms))

        app_subterms = list(app.subterms)
        app_subterms[i] = mm.Application("\\and", (mm.Application("\\top"), ith_arg_body))
        subst2 = mm.Application(app.symbol, tuple(app_subterms))

        next_step = self.composer.get_theorem("sorted-exists-propagation-converse").match_and_apply(
            mm.ProvableStatement(
                "",
                (mm.Application("|-"), mm.Application("\\imp", (lhs, app))),
            ),
            app_ctx_proof,
            SubstitutionProver.auto,
            SubstitutionProver.auto,
            SubstitutionProver.auto,
            SubstitutionProver.auto,
            ph3=subst1,
            ph4=subst2,
            ph5=ith_arg_body,
        )

        # build the desired statement for the previous step
        assert isinstance(subproof.conclusion[1], mm.Application)
        prev_step_lhs_body, prev_step_rhs_body = subproof.conclusion[1].subterms

        ith_arg_subterms = list(ith_arg.subterms)
        ith_arg_subterms[2] = prev_step_lhs_body
        prev_step_lhs = mm.Application(ith_arg.symbol, tuple(ith_arg_subterms))

        ith_arg_subterms = list(ith_arg.subterms)
        ith_arg_subterms[2] = prev_step_rhs_body
        prev_step_rhs = mm.Application(ith_arg.symbol, tuple(ith_arg_subterms))

        return self.composer.get_theorem("rule-imp-transitivity").apply(
            self.composer.get_theorem("imp-compat-in-sorted-exists").match_and_apply(
                mm.ProvableStatement(
                    "",
                    (
                        mm.Application("|-"),
                        mm.Application("\\imp", (prev_step_lhs, prev_step_rhs)),
                    ),
                ),
                subproof,
            ),
            next_step,
        )

    # TODO: this probably belows to somewhere else
    def apply_framing_on_application(self, app: mm.Application, i: int, imp: Proof) -> Proof:
        """
        Given an application f(ph0, ph1, ...)
        and a proof of, e.g., |- ph0 -> psi for some psi
        prove that
        f(ph0, ph1, ...) -> f(ph0, psi, ...)
        """
        app_ctx_proof = self.make_app_context(app, i)

        # |- ph0 -> ph1
        assert (
            len(imp.conclusion) == 2 and isinstance(imp.conclusion[1], mm.Application)
            and imp.conclusion[1].symbol == "\\imp"
        )
        lhs, rhs = imp.conclusion[1].subterms

        assert lhs == app.subterms[i]

        app_subterms = list(app.subterms)
        app_subterms[i] = rhs
        right_subst_app = mm.Application(app.symbol, tuple(app_subterms))

        return self.composer.get_theorem("proof-rule-frame").apply(
            app_ctx_proof,
            SubstitutionProver.auto,
            SubstitutionProver.auto,
            imp,
            ph1=app,
            ph2=right_subst_app,
        )

    def apply_bot_propagation(self, app: mm.Application, i: int) -> Proof:
        """
        Given an application with the ith argument being falsum
        return a proof that the entire pattern implies falsum
        """

        assert app.subterms[i] == mm.Application("\\bot")

        return self.composer.get_theorem("proof-rule-propagation-bot").apply(
            self.make_app_context(app, i),
            SubstitutionProver.auto,
            ph1=app,
        )

    def prove_argument_disjointness(
        self,
        left: kore.Application,
        right: kore.Application,
        i: int,
        argument_disjointness: Proof,
    ) -> Proof:
        """
        Given an integer i, left and right (applicatoin) patterns f(...), g(...)
        and a proof that the ith argument is disjoint, return a proof that
        f(...) and exists x1, ..., xn. g(...) are disjoint
        """

        assert left.symbol == right.symbol

        # proof strategy:
        # no confusion says something like
        #   f(ph0, ph1) /\ f(ph2, ph3) -> f(ph0 /\ ph2, ph1 /\ ph3)
        # we have shown (by `argument_disjointness`) that (wlog) !(ph0 /\ ph2)
        # by framing
        #   f(ph0 /\ ph2, ph1 /\ ph3) -> f(bot, ph1 /\ ph3)
        # and by bot propagation,
        #   f(bot, ph1 /\ ph3) -> bot
        # so f(ph0, ph1) /\ f(ph2, ph3) -> bot

        encoded_left_app = self.composer.encode_pattern(left)
        encoded_right_app = self.composer.encode_pattern(right)

        assert isinstance(encoded_left_app, mm.Application)
        assert isinstance(encoded_right_app, mm.Application)

        # existentially quantify the target argument
        # since the disjointness proof is quantified
        encoded_right_app_subterms = list(encoded_right_app.subterms)
        encoded_right_app_subterms[i] = self.existentially_quantify_free_variables(right.arguments[i])
        encoded_right_app.subterms = tuple(encoded_right_app_subterms)

        encoded_left_app_subterms = list(encoded_left_app.subterms)
        for j, (left_arg, right_arg) in enumerate(zip(encoded_left_app.subterms, encoded_right_app.subterms)):
            encoded_left_app_subterms[j] = mm.Application("\\and", (left_arg, right_arg))
        conj_app = mm.Application(encoded_left_app.symbol, tuple(encoded_left_app_subterms))

        # desugar |- ( \not (...) ) to |- ( \imp (...) \bot )
        arg_imp_bot = self.composer.get_theorem("desugar-not-to-imp").apply(argument_disjointness)

        replace_arg_with_bot = self.apply_framing_on_application(conj_app, i, arg_imp_bot)
        assert isinstance(replace_arg_with_bot.conclusion[1], mm.Application)
        _, rhs = replace_arg_with_bot.conclusion[1].subterms
        assert isinstance(rhs, mm.Application)

        # show that the entire application of conjunctions implies falsum
        conj_app_falsum = self.composer.get_theorem("rule-imp-transitivity").apply(
            replace_arg_with_bot,
            self.apply_bot_propagation(rhs, i),
        )

        # now we can apply no confusion
        assert isinstance(left.symbol.definition, kore.SymbolDefinition)
        no_confusion_axiom = self.composer.get_no_confusion_same_constructor(left.symbol.definition)
        assert no_confusion_axiom is not None, f"cannot find no confusion axiom for symbol {no_confusion_axiom}"

        no_confusion_instance = no_confusion_axiom.match_and_apply(
            mm.ProvableStatement(
                "",
                (
                    mm.Application("|-"),
                    mm.Application(
                        "\\imp",
                        (
                            mm.Application("\\and", (encoded_left_app, encoded_right_app)),
                            conj_app,
                        ),
                    ),
                ),
            )
        )

        not_conj = self.composer.get_theorem("sugar-imp-to-not").apply(
            self.composer.get_theorem("rule-imp-transitivity").apply(
                no_confusion_instance,
                conj_app_falsum,
            )
        )

        assert isinstance(not_conj.conclusion[1],
                          mm.Application) and isinstance(not_conj.conclusion[1].subterms[0], mm.Application)
        _, rhs = not_conj.conclusion[1].subterms[0].subterms
        assert isinstance(rhs, mm.Application)
        exists_propagation = self.propagate_exists_out(rhs, i)

        disjointness_proof = self.composer.get_theorem("disjointness-simplify").apply(
            not_conj,
            exists_propagation,
        )

        return disjointness_proof

    """
    Prove that two patterns with different heads are disjoint
    """

    def prove_diff_constructor_disjointness(self, left: kore.Application, right: kore.Application) -> Proof:
        # symmetry
        # self.composer.get_no_confusion_diff_constructor(left.symbol.definition, right.symbol.definition)
        assert isinstance(left.symbol.definition, kore.SymbolDefinition) and \
               isinstance(right.symbol.definition, kore.SymbolDefinition)
        no_confusion = self.composer.get_no_confusion_diff_constructor(left.symbol.definition, right.symbol.definition)
        assert no_confusion is not None, f"unable to find no confusion axiom for {left.symbol} and {right.symbol}"

        # if (
        #         encoded_right_symbol,
        #         encoded_left_symbol,
        # ) in self.composer.no_confusion_diff_constructor:
        #     disjointness_proof = self.composer.get_theorem("disjointness-symmetry").apply(
        #         self.prove_diff_constructor_disjointness(right, left)
        #     )
        # else:
        #     assert (
        #         encoded_left_symbol,
        #         encoded_right_symbol,
        #     ) in self.composer.no_confusion_diff_constructor, f"unable to find no confusion axiom for {encoded_left_symbol} and {encoded_right_symbol}"

        # no_confusion = self.composer.no_confusion_diff_constructor[encoded_left_symbol, encoded_right_symbol]
        disjointness_proof = no_confusion.match_and_apply(self.get_disjointness_statement(left, right, quantify=False))

        # need to quantify all free vars in the rhs
        for var in self.get_free_vars_in_pattern(right):
            disjointness_proof = self.composer.get_theorem("disjointness-quantify").apply(
                disjointness_proof,
                x=self.composer.encode_pattern(var),
                ph2=self.composer.encode_pattern(var.sort),
            )

        return disjointness_proof

    def prove_disjointness_with_disjunction(
        self, left: kore.Pattern, components: List[Union[kore.Variable, kore.Application]]
    ) -> Proof:
        """
        Prove that the left pattern is disjoint from
        any of the components given
        """

        assert len(components) != 0

        first_disjointness = self.prove_disjointness(left, components[0])

        if len(components) == 1:
            return first_disjointness

        return self.composer.get_theorem("disjointness-case").apply(
            first_disjointness,
            self.prove_disjointness_with_disjunction(left, components[1:]),
        )

    def prove_symbol_sort_disjointness(self, left: kore.Pattern, right: kore.Variable) -> Proof:
        """
        Prove that a (concrete) pattern is not in a sort
        """

        assert (
            isinstance(right.sort, kore.SortInstance) and right.sort in self.composer.no_junk_axioms
            and right.sort in self.composer.sort_components
        ), f"unable to find no junk axiom for sort {right.sort}"

        no_junk_axiom = self.composer.no_junk_axioms[right.sort]

        # no junk axiom is of the form
        # |- ( \eq ( \inh <sort> ) ( <disjunction> ) )

        components = self.composer.sort_components[right.sort]
        disjoint_with_disjunction = self.prove_disjointness_with_disjunction(left, components)

        disjoint_with_sort = self.composer.get_theorem("disjointness-simplify").apply(
            disjoint_with_disjunction,
            self.composer.get_theorem("rule-iff-elim-left").apply(
                self.composer.get_theorem("rule-eq-to-iff").apply(no_junk_axiom.as_proof()),
            ),
        )

        disjoint_with_sort_alt = self.composer.get_theorem("disjointness-sort").match_and_apply(
            self.get_disjointness_statement(left, right),
            disjoint_with_sort,
        )

        return disjoint_with_sort_alt

    def prove_inj_disjointness(self, left: kore.Application, right: kore.Application) -> Proof:
        assert len(left.arguments) == 1 and len(right.arguments) == 1
        subproof = self.prove_disjointness(left.arguments[0], right.arguments[0])

        left_input_sort, left_output_sort = left.symbol.sort_arguments
        right_input_sort, right_output_sort = right.symbol.sort_arguments

        disjointness_proof = self.composer.get_theorem("disjointness-eq").apply(
            self.composer.get_theorem("kore-inj-id").apply(
                ph0=self.composer.encode_pattern(left_input_sort),
                ph1=self.composer.encode_pattern(left_output_sort),
                ph2=self.existentially_quantify_free_variables(left.arguments[0]),
            ),
            self.composer.get_theorem("kore-inj-id").apply(
                ph0=self.composer.encode_pattern(right_input_sort),
                ph1=self.composer.encode_pattern(right_output_sort),
                ph2=self.existentially_quantify_free_variables(right.arguments[0]),
            ),
            subproof,
        )

        # propagate out the existential quantifiers at the body of the injection
        assert isinstance(disjointness_proof.conclusion[1],
                          mm.Application) and isinstance(disjointness_proof.conclusion[1].subterms[0], mm.Application)
        rhs = disjointness_proof.conclusion[1].subterms[0].subterms[1]
        assert isinstance(rhs, mm.Application)
        exists_propagation = self.propagate_exists_out(rhs, 2)

        return self.composer.get_theorem("disjointness-simplify").apply(
            disjointness_proof,
            exists_propagation,
        )

    def prove_hooked_sort_disjointness(self, left: kore.Application, var: kore.Variable) -> Proof:
        assert isinstance(var.sort, kore.SortInstance) and \
               isinstance(left.symbol.definition, kore.SymbolDefinition)

        no_confusion = self.composer.get_no_confusion_hooked_sort(var.sort, left.symbol.definition)
        assert no_confusion is not None

        encoded_left = self.composer.encode_pattern(left)
        encoded_sort = self.composer.encode_pattern(var.sort)
        instance = mm.ProvableStatement(
            "",
            (
                mm.Application("|-"),
                mm.Application(
                    "\\not",
                    (mm.Application(
                        "\\and",
                        (
                            encoded_left,
                            mm.Application("\\inh", (encoded_sort, )),
                        ),
                    ), ),
                ),
            ),
        )

        return self.composer.get_theorem("disjointness-sort").match_and_apply(
            self.get_disjointness_statement(left, var),
            no_confusion.match_and_apply(instance),
        )

    def prove_dv_sort_disjointness(self, left: kore.MLPattern, right: kore.Variable) -> Proof:
        """
        Try to prove that a dv pattern is disjoint from a sort
        """
        dv_sort = left.sorts[0]
        assert isinstance(dv_sort, kore.SortInstance) and \
               len(dv_sort.arguments) == 0, f"parametric hooked sort {dv_sort} is not supported"

        right_sort = right.sort
        assert isinstance(right_sort, kore.SortInstance) and \
               len(right_sort.arguments) == 0, f"parametric sort {right_sort} not supported"

        dv_sort_encoded_id = KoreEncoder.encode_sort(dv_sort.get_sort_id())
        right_sort_encoded_id = KoreEncoder.encode_sort(right_sort.get_sort_id())

        # look up disjointness axiom
        if (dv_sort_encoded_id, right_sort_encoded_id) in self.composer.hooked_sort_disjoint_axioms:
            disjoint_axiom = self.composer.hooked_sort_disjoint_axioms[dv_sort_encoded_id,
                                                                       right_sort_encoded_id].as_proof()

        elif (right_sort_encoded_id, dv_sort_encoded_id) in self.composer.hooked_sort_disjoint_axioms:
            disjoint_axiom = self.composer.get_theorem("disjointness-symmetry").apply(
                self.composer.hooked_sort_disjoint_axioms[right_sort_encoded_id, dv_sort_encoded_id].as_proof()
            )

        else:
            assert False, f"unable to find axiom to show the disjointness of sorts {dv_sort} and {right_sort}"

        right_var_encoded = KoreEncoder.encode_variable(right)
        dv_encoded = self.composer.encode_pattern(left)

        return self.composer.get_theorem("disjointness-in-sort").apply(
            SortingProver.auto,
            self.composer.get_theorem("disjointness-sort").apply(
                disjoint_axiom,
                x=mm.Metavariable(right_var_encoded),
            ),
            ph0=dv_encoded,
        )

    def prove_disjointness(self, left: kore.Pattern, right: kore.Pattern) -> Proof:
        r"""
        Prove that the given patterns are disjoint, that is
        not (<left> /\ exists x. <right>)

        Currently only <right> is allowed to have free variables
        which are existentially quantified
        """

        assert KoreUtils.is_concrete(left), f"currently only supports concrete left pattern, but {left} is given"

        right = KoreUtils.strip_exists(right)

        assert isinstance(right, kore.Application) or isinstance(
            right, kore.Variable
        ), f"right pattern {right} should be an application or a variable"

        if isinstance(right, kore.Application):
            assert isinstance(left, kore.Application), f"left pattern {left} should be an application"

            # if both symbols are injections
            # it's enough to prove that the inner patterns are disjoint
            if (left.symbol.definition == self.composer.sort_injection_symbol
                    and right.symbol.definition == self.composer.sort_injection_symbol):
                assert isinstance(right, kore.Application)
                return self.prove_inj_disjointness(left, right)
            elif left.symbol == right.symbol:
                # same symbol, try to find a argument pair that is disjoint
                # then use no confusion to show that the full patterns are disjoint

                assert len(left.arguments) == len(
                    right.arguments
                ), f"same head but different numbers of arguments: {left} vs {right}"

                for i, (left_arg, right_arg) in enumerate(zip(left.arguments, right.arguments)):
                    try:
                        subproof = self.prove_disjointness(left_arg, right_arg)
                    except Exception:
                        print_exc()
                    else:
                        return self.prove_argument_disjointness(left, right, i, subproof)

                assert False, f"failed to show disjointness of {left} and {right}"
            else:
                # different symbols, use no confusion axiom for different constructors
                return self.prove_diff_constructor_disjointness(left, right)
        else:
            assert isinstance(right, kore.Variable)

            # right is a variable and it can be further decomposed, use no junk of the sort
            if right.sort in self.composer.sort_components:
                return self.prove_symbol_sort_disjointness(left, right)

            if isinstance(left, kore.MLPattern) and left.construct == kore.MLPattern.DV:
                return self.prove_dv_sort_disjointness(left, right)

            assert isinstance(left, kore.Application), f"left pattern {left} should be an application"

            # right is a variable of a hooked sort
            assert isinstance(right.sort, kore.SortInstance) and \
                   isinstance(left.symbol.definition, kore.SymbolDefinition)
            if self.composer.get_no_confusion_hooked_sort(right.sort, left.symbol.definition) is not None:
                return self.prove_hooked_sort_disjointness(left, right)

            # TODO: handle parametric sorts

            assert False, f"unable to prove that {left} is not in sort {right.sort}"
