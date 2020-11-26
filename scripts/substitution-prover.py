"""
A utility script to produce proofs
of the substitution given a new construct
"""

import re
import argparse

from proof.metamath.ast import *
from proof.metamath.parser import load_database
from proof.metamath.composer import Composer, Proof, Theorem
from proof.metamath.visitors import SubstitutionVisitor


def prove_substitution(composer, pattern_axiom_label, sugar_axiom_label) -> Statement:
    pattern_axiom = composer.theorems[pattern_axiom_label]
    sugar_axiom = composer.theorems[sugar_axiom_label]

    assert pattern_axiom.statement.terms[0] == Application("#Pattern")
    head = pattern_axiom.statement.terms[1].symbol
    num_args = len(pattern_axiom.statement.terms[1].subterms)

    subst_var = Metavariable("xX")
    subst_term = Metavariable("ph0")
    subst_label = "substitution-{}".format(re.sub(r"[^a-zA-Z0-9_\-.]", "", head))

    # generate hypotheses
    hypotheses = []
    for i in range(1, num_args + 1):
        hyp = StructuredStatement("e",
            [ Application("#Substitution"), Metavariable(f"ph{i}"), Metavariable(f"ph{i + num_args}"), subst_term, subst_var ],
            f"{subst_label}.{i - 1}"
        )
        hypotheses.append(hyp)

    before_subst = Application(head, [ Metavariable(f"ph{i + num_args}") for i in range(1, num_args + 1) ])
    after_subst = Application(head, [ Metavariable(f"ph{i}") for i in range(1, num_args + 1) ])

    _, sugared, desugared = sugar_axiom.statement.terms

    # desugared version after substitution
    desugar_map = composer.unify_terms_as_instance(sugared, after_subst)
    assert desugar_map is not None
    after_subst_desugared = SubstitutionVisitor(desugar_map).visit(desugared)

    # desugared version before substitution
    desugar_map = composer.unify_terms_as_instance(sugared, before_subst)
    assert desugar_map is not None
    before_subst_desugared = SubstitutionVisitor(desugar_map).visit(desugared)

    """
    Prove the statement "#Substitution ? <term> <subst_term> <subst_var>"
    """
    def prove_substitution_of_term(after_subst: Term, before_subst: Term) -> Proof:
        assert (isinstance(after_subst, Metavariable) and isinstance(before_subst, Metavariable)) or \
               (after_subst.symbol == before_subst.symbol and len(after_subst.subterms) == len(before_subst.subterms))

        if isinstance(after_subst, Metavariable):
            assert after_subst.name.startswith("ph")
            index = int(after_subst.name[2:])
            return Theorem(composer, hypotheses[index - 1], [], []).as_proof()
        else:
            target = StructuredStatement("p", [ Application("#Substitution"), after_subst, before_subst, subst_term, subst_var ])
            subproofs = [ prove_substitution_of_term(t1, t2) for t1, t2 in zip(after_subst.subterms, before_subst.subterms) ]

            if after_subst.symbol == "\\bot":
                return composer.theorems["substitution-bot"].unify_and_apply(target)
            elif len(after_subst.subterms) == 0 and after_subst.symbol.startswith("\\"):
                # guessing this is a symbol...
                # NOTE: this depends on our naming convention
                return composer.theorems["substitution-symbol"].unify_and_apply(target)

            for theorem in composer.theorems.values():
                if len(theorem.essentials) != len(subproofs): continue

                substitution = composer.unify_statements_as_instance(theorem.statement, target)
                if substitution is not None:
                    return theorem.apply(*subproofs)

            assert False, f"failed to find proof for {target}"

    desugared_subst = prove_substitution_of_term(after_subst_desugared, before_subst_desugared)
    after_eq = sugar_axiom.unify_and_apply(StructuredStatement("p", [ Application("#Equal"), after_subst, after_subst_desugared ]))
    before_eq = sugar_axiom.unify_and_apply(StructuredStatement("p", [ Application("#Equal"), before_subst, before_subst_desugared ]))
    subst_term_eq = composer.theorems["equal-reflexivity"].apply(ph0=subst_term)

    goal = composer.theorems["equal-substitution"].apply(desugared_subst, after_eq, before_eq, subst_term_eq)
    goal.statement.label = subst_label

    if len(hypotheses):
        return Block(hypotheses + [ goal.statement ])
    else:
        return goal.statement


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("prelude", help="path to the prelude")
    parser.add_argument("label", nargs="+", help="label prefix of the construct (e.g. inh for \\inh, given that inh-is-pattern and ing-is-sugar exist)")
    args = parser.parse_args()

    prelude_database = load_database(args.prelude)
    composer = Composer()
    composer.load(prelude_database)

    proved_statements = []

    for i, label in enumerate(args.label):
        proved = prove_substitution(composer, f"{label}-is-pattern", f"{label}-is-sugar")
        composer.load(proved)
        proved_statements.append(proved)

        if i != 0:
            print()
            
        print(proved)


if __name__ == "__main__":
    main()
