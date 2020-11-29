from proof.metamath.ast import StructuredStatement, Statement, Application, Metavariable
from proof.metamath.parser import load_database
from proof.metamath.composer import Composer

from .parser import parse_script
from .env import Environment, GoalStack, ProofStack


composer = Composer()
database = load_database("theory/kore.mm")
composer.load(database)

env = Environment(composer)
goal_stack = GoalStack([
    StructuredStatement("?", [
        Application("|-"),
        Application("\\imp", [ Metavariable("ph0"), Metavariable("ph0") ])
    ]),
])

ast = parse_script(r"""
apply proof-rule-mp
apply proof-rule-mp
apply proof-rule-prop-2
meh
apply proof-rule-prop-1 with ph1 = "ph0"
apply proof-rule-prop-1
""")

tactics = [ command.get_tactic(env) for command in ast.commands ]

for tactic in tactics:
    print("goals:")
    print("\n".join(map(lambda g: "    " + str(g), list(goal_stack)[::-1])))
    goal_stack = tactic.apply(env, goal_stack)

print("goals:")
print("\n".join(map(lambda g: "    " + str(g), list(goal_stack)[::-1])))

proof_stack = ProofStack([])

for tactic in tactics[::-1]:
    proof_stack = tactic.resolve(env, proof_stack)

assert len(proof_stack) == 1
proof = proof_stack[0]
print(proof)
