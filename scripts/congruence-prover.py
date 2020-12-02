"""
Prove the congruence lemma for derived constructs
"""

import argparse

from proof.metamath.ast import *
from proof.metamath.parser import load_database
from proof.metamath.composer import Composer, Proof, Theorem
from proof.metamath.visitors import SubstitutionVisitor


def prove_congruence(composer: Composer, label: str) -> Statement:
    sugar_axiom = composer.theorems[f"{label}-is-sugar"]

    metavars = sugar_axiom.statement.get_metavariables()
    pattern_metavars = [ metavar for metavar in metavars if composer.find_metavariable(metavar) == "#Pattern" ]
    other_metavars = metavars.difference(set(pattern_metavars))

    for metavar in pattern_metavars: assert metavar.startswith("ph")
    pattern_metavars.sort(key=lambda var: int(var[2:]))

    num_subpatterns = len(pattern_metavars)

    default_assignment_for_other_metavars = { var: Metavariable(var) for var in other_metavars }

    desugared_template = sugar_axiom.statement.terms[2]

    lhs_subst = SubstitutionVisitor({ pattern_metavars[i]: Metavariable(f"ph{i}") for i in range(num_subpatterns) })
    rhs_subst = SubstitutionVisitor({ pattern_metavars[i]: Metavariable(f"ph{i + num_subpatterns}") for i in range(num_subpatterns) })

    desugared_lhs = lhs_subst.visit(desugared_template)
    desugared_rhs = rhs_subst.visit(desugared_template)

    hypotheses = [
        StructuredStatement("e", [
            Application("#Equal"),
            Metavariable(f"ph{i}"),
            Metavariable(f"ph{i + num_subpatterns}"),
        ], label=f"equal-{label}.{i}")
        for i in range(num_subpatterns)
    ]

    def prove_desugared_equality(lhs, rhs):
        assert (isinstance(lhs, Metavariable) and isinstance(rhs, Metavariable)) or \
               (isinstance(lhs, Application) and isinstance(rhs, Application) and \
                lhs.symbol == rhs.symbol and len(lhs.subterms) == len(rhs.subterms))

        if lhs == rhs:
            return composer.theorems["equal-reflexivity"].apply(ph0=lhs)

        if isinstance(lhs, Metavariable):
            if composer.find_metavariable(lhs.name) == "#Pattern":
                assert lhs.name.startswith("ph")
                index = int(lhs.name[2:])
                assert int(rhs.name[2:]) == index + num_subpatterns
                return Theorem(composer, hypotheses[index], [], []).as_proof()
            else:
                assert False, f"unable to show equality of metavariables {lhs} and {rhs}"

        else:
            target = StructuredStatement("p", [ Application("#Equal"), lhs, rhs ])

            for theorem in composer.theorems.values():
                # if len(theorem.essentials) != len(subproofs): continue

                substitution = composer.unify_statements_as_instance(theorem.statement, target)
                if substitution is None: continue

                # make sure the matched theorem is not too general
                if not (isinstance(theorem.statement.terms[1], Application) and
                        isinstance(theorem.statement.terms[2], Application)): continue

                subproofs = []

                # only recurse on subpatterns
                for subterm1, subterm2 in zip(lhs.subterms, rhs.subterms):
                    if isinstance(subterm1, Metavariable):
                        typecode = composer.find_metavariable(subterm1.name)
                        # TODO: this "heuristic" might be very flaky
                        if typecode == "#Pattern" or len(theorem.essentials) == len(lhs.subterms):
                            subproofs.append(prove_desugared_equality(subterm1, subterm2))
                    else:
                        subproofs.append(prove_desugared_equality(subterm1, subterm2))

                return theorem.unify_and_apply(target, *subproofs)
            
            assert False, f"unable to find a proof for {target}"

    eq1 = sugar_axiom.apply(**default_assignment_for_other_metavars, **lhs_subst.substitution)
    eq2 = prove_desugared_equality(desugared_lhs, desugared_rhs)
    eq3 = composer.theorems["equal-symmetry"].apply(sugar_axiom.apply(**default_assignment_for_other_metavars, **rhs_subst.substitution))

    eq4 = composer.theorems["equal-transitivity"].apply(eq1, eq2)
    eq5 = composer.theorems["equal-transitivity"].apply(eq4, eq3)

    eq5.statement.label = f"equal-{label}"

    if num_subpatterns == 0:
        return eq5.statement
    else:
        return Block(hypotheses + [ eq5.statement ])


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("prelude", help="path to the prelude")
    parser.add_argument("label", nargs="+", help="label prefix of the defined construct")
    args = parser.parse_args()

    prelude_database = load_database(args.prelude)
    composer = Composer()
    composer.load(prelude_database)

    for i, label in enumerate(args.label):
        proved = prove_congruence(composer, label)
        composer.load(proved)

        if i != 0: print()
        print(proved)


if __name__ == "__main__":
    main()
