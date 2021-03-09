
from typing import Optional, Tuple

from traceback import print_exc

from ml.kore import ast as kore
from ml.kore.utils import KoreUtils
from ml.kore.visitors import FreePatternVariableVisitor

from ml.metamath import ast as mm
from ml.metamath.composer import Proof
from ml.metamath.visitors import CopyVisitor
from ml.metamath.auto.substitution import SubstitutionProver

from .env import ProofEnvironment, ProofGenerator
from .encoder import KorePatternEncoder


r"""
The disjointness proof generator generates proof for
patterns of the form

phi /\ not (exists x1, ..., xn. psi(x1, ..., xn))

where phi is expected to be a functional pattern

The primary usage of it is to prove conditions for
[owise] rules, which assumes that a pattern
does NOT unify with a pattern.
"""
class DisjointnessProofGenerator(ProofGenerator):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.arg_disjointness_counter = 0
        self.diff_constructor_disjointness_counter = 0
        self.var_disjointness_assumption = 0

    r"""
    Given a Kore pattern, existentially quantify all free variables using \sorted-exists
    then return the encoded metamath pattern
    """
    def existentially_quantify_free_variables(self, pattern: kore.Pattern) -> mm.Term:
        free_vars = FreePatternVariableVisitor().visit(pattern)
        free_vars = list(free_vars)
        free_vars.sort(key=lambda v: v.name, reverse=True)

        encoded_pattern = self.env.encode_pattern(pattern)

        for var in free_vars:
            encoded_pattern = mm.Application(
                "\\sorted-exists",
                [
                    self.env.encode_pattern(var),
                    self.env.encode_pattern(var.sort),
                    encoded_pattern,
                ],
            )

        return encoded_pattern

    r"""
    Return the metamath term
    not (<left> /\ exists x1, ..., xn. <right>)
    all free variables should be exitentially quantified
    """
    def get_disjointness_pattern(self, left: kore.Pattern, right: kore.Pattern) -> mm.Term:
        left_term = self.existentially_quantify_free_variables(left)
        right_term = self.existentially_quantify_free_variables(right)

        return mm.Application("\\not", [
            mm.Application("\\and", [
                left_term,
                right_term
            ])
        ])

    """
    Same as above but wraps it in a metamath statement
    """
    def get_disjointness_statement(self, left: kore.Pattern, right: kore.Pattern, label: str) -> mm.StructuredStatement:
        disjointness = self.get_disjointness_pattern(left, right)
        return mm.StructuredStatement(
            mm.Statement.PROVABLE,
            [ mm.Application("|-"), disjointness ],
            label=label,
        )

    """
    Given an application f(ph1, ...)
    make a "hole" at the ith argument to make it an application context,
    and return the proof that it is an application context
    """
    def make_app_context(self, app: mm.Application, i: int) -> Proof:
        metavars = app.get_metavariables()
        free_var, = self.env.gen_fresh_metavariables("#ElementVariable", 1, metavars)
        free_var = mm.Metavariable(free_var)

        # f(..., xX, ...)
        app_ctx = CopyVisitor().visit(app)
        app_ctx.subterms[i] = free_var

        assert app.symbol in self.env.app_ctx_lemmas and \
               i < len(self.env.app_ctx_lemmas[app.symbol]), \
               f"unable to find the application context lemmas for {app.symbol} at position {i}"

        app_ctx_lemma = self.env.app_ctx_lemmas[app.symbol][i]

        app_ctx_proof = app_ctx_lemma.match_and_apply(
            mm.StructuredStatement(
                mm.Statement.PROVABLE,
                [ mm.Application("#ApplicationContext"), free_var, app_ctx ],
            ),
            self.env.get_theorem("application-context-var").apply(xX=free_var),
        )

        return app_ctx_proof

    """
    Propagate all existential quantifiers at the ith argument out
    Given an application f(..., sorted-exists x y. phi(x, y), ...)
    Return the proof of
      (sorted-exists x y. f(..., phi(x, y), ...)) -> f(..., sorted-exists x y. phi(x, y), ...)
    """
    def propagate_exists_out(self, app: mm.Application, i: int) -> Proof:
        assert i < len(app.subterms)
        ith_arg = app.subterms[i]

        # base case, nothing to propagation, return imp-reflexivity
        if not isinstance(ith_arg, mm.Application) or \
           ith_arg.symbol != "\\sorted-exists":
            return self.env.get_theorem("imp-reflexivity").apply(ph0=app)

        ith_arg_body = ith_arg.subterms[2]

        # create a term that looks like (sorted-exists x y. f(..., phi(x, y), ...))
        lhs_body = CopyVisitor().visit(app)
        lhs_body.subterms[i] = ith_arg_body

        lhs = CopyVisitor().visit(ith_arg)
        lhs.subterms[2] = lhs_body

        app_ctx_proof = self.make_app_context(app, i)

        subproof = self.propagate_exists_out(lhs_body, i)

        next_step = self.env.get_theorem("sorted-exists-propagation-converse").match_and_apply(
            mm.StructuredStatement(
                mm.Statement.PROVABLE,
                [ mm.Application("|-"), mm.Application("\\imp", [ lhs, app ]) ],
            ),
            app_ctx_proof,
            SubstitutionProver.auto,
            SubstitutionProver.auto,
            ph3=ith_arg_body,
        )

        # build the desired statement for the previous step
        prev_step_lhs_body, prev_step_rhs_body = subproof.statement.terms[1].subterms
        prev_step_lhs = CopyVisitor().visit(ith_arg)
        prev_step_lhs.subterms[2] = prev_step_lhs_body
        prev_step_rhs = CopyVisitor().visit(ith_arg)
        prev_step_rhs.subterms[2] = prev_step_rhs_body

        return self.env.get_theorem("rule-imp-transitivity").apply(
            self.env.get_theorem("imp-compat-in-sorted-exists").match_and_apply(
                mm.StructuredStatement(
                    mm.Statement.PROVABLE,
                    [ mm.Application("|-"), mm.Application("\\imp", [ prev_step_lhs, prev_step_rhs ]) ],
                ),
                subproof,
            ),
            next_step,
        )

    # TODO: this probably belows to somewhere else
    """
    Given an application f(ph0, ph1, ...)
    and a proof of, e.g., |- ph0 -> psi for some psi
    prove that
      f(ph0, ph1, ...) -> f(ph0, psi, ...)
    """
    def apply_framing_on_application(self, app: mm.Application, i: int, imp: Proof) -> Proof:
        app_ctx_proof = self.make_app_context(app, i)

        # |- ph0 -> ph1
        assert len(imp.statement.terms) == 2 and \
               isinstance(imp.statement.terms[1], mm.Application) and \
               imp.statement.terms[1].symbol == "\\imp"
        lhs, rhs = imp.statement.terms[1].subterms

        assert lhs == app.subterms[i]

        right_subst_app = CopyVisitor().visit(app)
        right_subst_app.subterms[i] = rhs

        return self.env.get_theorem("proof-rule-frame").apply(
            app_ctx_proof,
            SubstitutionProver.auto,
            SubstitutionProver.auto,
            imp,
            ph1=app,
            ph2=right_subst_app,
        )

    """
    Given an application with the ith argument being falsum
    return a proof that the entire pattern implies falsum
    """
    def apply_bot_propagation(self, app: mm.Application, i: int) -> Proof:
        assert app.subterms[i] == mm.Application("\\bot")

        return self.env.get_theorem("proof-rule-propagation-bot").apply(
            self.make_app_context(app, i),
            SubstitutionProver.auto,
            ph1=app,
        )

    """
    Given an integer i, left and right (applicatoin) patterns f(...), g(...)
    and a proof that the ith argument is disjoint, return a proof that
    f(...) and exists x1, ..., xn. g(...) are disjoint
    """
    def prove_argument_disjointness(self, left: kore.Application, right: kore.Application, i: int, argument_disjointness: Proof) -> Proof:
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

        encoded_left_app = self.env.encode_pattern(left)

        encoded_right_app = self.env.encode_pattern(right)
        # existentially quantify the target argument
        # since the disjointness proof is quantified
        encoded_right_app.subterms[i] = self.existentially_quantify_free_variables(right.arguments[i])

        conj_app = CopyVisitor().visit(encoded_left_app)
        for j, (left_arg, right_arg) in enumerate(zip(encoded_left_app.subterms, encoded_right_app.subterms)):
            conj_app.subterms[j] = mm.Application("\\and", [ left_arg, right_arg ])

        # desugar |- ( \not (...) ) to |- ( \imp (...) \bot )
        arg_imp_bot = self.env.get_theorem("desugar-not-to-imp").apply(argument_disjointness)

        replace_arg_with_bot = self.apply_framing_on_application(conj_app, i, arg_imp_bot)
        _, rhs = replace_arg_with_bot.statement.terms[1].subterms

        # show that the entire application of conjunctions implies falsum
        conj_app_falsum = self.env.get_theorem("rule-imp-transitivity").apply(
            replace_arg_with_bot,
            self.apply_bot_propagation(rhs, i),
        )

        # now we can apply no confusion
        encoded_symbol = KorePatternEncoder.encode_symbol(left.symbol)
        assert encoded_symbol in self.env.no_confusion_same_constructor, \
               f"cannot find no confusion axiom for symbol {encoded_symbol}"

        no_confusion_axiom = self.env.no_confusion_same_constructor[encoded_symbol]

        no_confusion_instance = no_confusion_axiom.match_and_apply(
            mm.StructuredStatement(
                mm.Statement.PROVABLE,
                [
                    mm.Application("|-"), mm.Application("\\imp", [
                        mm.Application("\\and", [ encoded_left_app, encoded_right_app ]),
                        conj_app,
                    ])
                ],
            )
        )

        not_conj = self.env.get_theorem("sugar-imp-to-not").apply(
            self.env.get_theorem("rule-imp-transitivity").apply(
                no_confusion_instance,
                conj_app_falsum,
            )
        )

        _, rhs = not_conj.statement.terms[1].subterms[0].subterms
        exists_propagation = self.propagate_exists_out(rhs, i)

        disjointness_proof = self.env.get_theorem("simpl-lemma-for-disjointness").apply(
            not_conj,
            exists_propagation,
        )

        return disjointness_proof

    r"""
    Prove that the given patterns are disjoint, that is
    not (<left> /\ exists x. <right>)

    Currently only <right> is allowed to have free variables
    which are existentially quantified
    """
    def prove_disjointness(self, left: kore.Pattern, right: kore.Pattern) -> Proof:
        assert KoreUtils.is_concrete(left), \
               f"currently only supports concrete left pattern, but {left} is given"

        right = KoreUtils.strip_exists(right)

        assert isinstance(left, kore.Application), \
               f"left pattern {left} should be an application"
        assert isinstance(right, kore.Application) or isinstance(right, kore.Variable), \
               f"right pattern {right} should be an application or a variable"

        left_symbol = left.symbol

        if isinstance(right, kore.Application):
            right_symbol = right.symbol
        else:
            right_symbol = None

        # if both symbols are injections
        # it's enough to prove that the inner patterns are disjoint
        if left_symbol.definition == self.env.sort_injection_symbol and \
           right_symbol.definition == self.env.sort_injection_symbol:
            assert len(left.arguments) == 1 and len(right.arguments) == 1
            subproof = self.prove_disjointness(left.arguments[0], right.arguments[0])
            
            left_input_sort, left_output_sort = left_symbol.sort_arguments
            right_input_sort, right_output_sort = right_symbol.sort_arguments

            disjointness_proof = self.env.get_theorem("eq-lemma-for-disjointness").apply(
                self.env.get_theorem("kore-inj-id").apply(
                    ph0=self.env.encode_pattern(left_input_sort),
                    ph1=self.env.encode_pattern(left_output_sort),
                    ph2=self.existentially_quantify_free_variables(left.arguments[0]),
                ),
                self.env.get_theorem("kore-inj-id").apply(
                    ph0=self.env.encode_pattern(right_input_sort),
                    ph1=self.env.encode_pattern(right_output_sort),
                    ph2=self.existentially_quantify_free_variables(right.arguments[0]),
                ),
                subproof,
            )

            # propagate out the existential quantifiers at the body of the injection
            rhs = disjointness_proof.statement.terms[1].subterms[0].subterms[1]
            exists_propagation = self.propagate_exists_out(rhs, 2)

            return self.env.get_theorem("simpl-lemma-for-disjointness").apply(
                disjointness_proof,
                exists_propagation,
            )

        if left_symbol == right_symbol:
            # same symbol, try to find a argument pair that is disjoint
            # then use no confusion to show that the full patterns are disjoint

            assert len(left.arguments) == len(right.arguments), \
                   f"same head but different numbers of arguments: {left} vs {right}"

            for i, (left_arg, right_arg) in enumerate(zip(left.arguments, right.arguments)):
                try:
                    subproof = self.prove_disjointness(left_arg, right_arg)
                except:
                    print_exc()
                else:
                    return self.prove_argument_disjointness(left, right, i, subproof)

            assert False, f"failed to show disjointness of {left} and {right}"

        elif right_symbol is not None:
            # different symbols, use no confusion axiom for different constructors
            # TODO: for now we just assume that it's true...
            disjointness_stmt = self.get_disjointness_statement(
                left, right,
                f"diff-constructor-disjointness-assumption-{self.diff_constructor_disjointness_counter}",
            )
            self.diff_constructor_disjointness_counter += 1

            theorem = self.env.load_metamath_statement(disjointness_stmt)
            return theorem.as_proof()

        else:
            assert isinstance(right, kore.Variable)
            # right is a variable use no junk of the sort
            # to decompose it to multiple queries

            # TODO: assumes it for now as well
            disjointness_stmt = self.get_disjointness_statement(
                left, right,
                f"var-disjointness-assumption-{self.var_disjointness_assumption}",
            )
            self.var_disjointness_assumption += 1

            theorem = self.env.load_metamath_statement(disjointness_stmt)
            return theorem.as_proof()
