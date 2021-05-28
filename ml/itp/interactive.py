from __future__ import annotations

from typing import Optional, List, Iterable, TypeVar, Callable, Any, Tuple

import readline
import traceback

from ml.metamath.ast import StructuredStatement, Statement, Application, Metavariable, Encoder
from ml.metamath.parser import load_database
from ml.metamath.composer import Composer, Theorem

from ml.itp.ast import Tactical
from ml.itp.parser import parse_tactical
from ml.itp.state import ProofState, NoStateChangeException

from ml.utils.ansi import ANSI

import ml.itp.auto
import ml.itp.tactics

readline.parse_and_bind("tab: complete")

TAB = "  "

HandlerT = Callable[..., Any]


class BuiltinCommand:
    builtin_commands: List[BuiltinCommand] = []  # list of BuiltinCommand

    def __init__(self, handler: HandlerT, *names: str, help_message: Optional[str] = None):
        self.handler = handler
        self.names = set(names)
        self.help_message = help_message

    @staticmethod
    def add(*args: Any, **kwargs: Any) -> Callable[[HandlerT], HandlerT]:
        def decorator(handler: HandlerT) -> HandlerT:
            BuiltinCommand.builtin_commands.append(BuiltinCommand(handler, *args, **kwargs))
            return handler

        return decorator

    @staticmethod
    def get_all_command_names() -> List[str]:
        return sum([sorted(cmd.names) for cmd in BuiltinCommand.builtin_commands], [])

    @staticmethod
    def print_help() -> None:
        lines = []

        for command in BuiltinCommand.builtin_commands:
            lines.append("{}{} - {}".format(TAB, "/".join(command.names), command.help_message))

        print("""\
usage:
{}<tactic> [options] - apply a tactic
{}""".format(TAB, "\n".join(lines)))


class InteractiveState:
    def __init__(self, theory_path: str, goal_name: str, debug: bool = False):
        self.undo_states: List[Tuple[ProofState, Tactical]] = []
        self.redo_states: List[Tuple[ProofState, Tactical]] = []
        self.debug = debug

        self.init_from_theory_and_goal(theory_path, goal_name)

    def init_from_theory_and_goal(self, theory_path: str, goal_name: str) -> None:
        composer = Composer()
        database = load_database(theory_path, include_proof=False)
        goal = composer.load(database, stop_at=goal_name)
        assert goal is not None, f"failed to load goal {goal_name}"

        composer.remove_theorem(goal_name)

        self.init_theory_path: str = theory_path
        self.init_goal: Theorem = goal
        self.goal_name: str = goal_name
        self.proof_state: ProofState = ProofState(composer, goal.statement)

        # initialize completer
        readline.set_completer_delims(" ")
        readline.set_completer(self.command_completer)

    def command_completer(self, text: str, state: int) -> Optional[str]:
        command_names = (sorted(ProofState.all_tactics.keys()) + BuiltinCommand.get_all_command_names())

        theorem_names = list(self.proof_state.composer.theorems.keys()) + \
            [ theorem.statement.label for theorem in self.proof_state.get_all_essentials_for_top_goal() if theorem.statement.label is not None ] + \
            [ claim.theorem.statement.label for claim in self.proof_state.get_all_global_claims() ] + \
            [ claim.theorem.statement.label for claim in self.proof_state.get_all_local_claims() ]
        theorem_names.sort()

        current_buffer = readline.get_line_buffer().lstrip()
        split = current_buffer.split("&")[-1].split("|")[-1].lstrip().split(" ")

        if len(split) > 1:
            filtered_names = [name for name in theorem_names if name.startswith(text)]

            if text.startswith('"'):
                filtered_names = ['"' + name + '"' for name in theorem_names if name.startswith(text[1:])]
            else:
                filtered_names = [name for name in theorem_names if name.startswith(text)]
        else:
            filtered_names = [name + " " for name in command_names if name.startswith(text)]

        if state < len(filtered_names):
            return filtered_names[state]

        return None

    def loop(self) -> None:
        self.print_state()
        while True:
            try:
                tactical_src = input("> ").strip()
                if not tactical_src:
                    continue

                lowered = tactical_src.lower()
                split = lowered.split()
                for command in BuiltinCommand.builtin_commands:
                    if split[0] in command.names:
                        command.handler(self, *split[1:])
                        break
                else:
                    # apply a tactical then
                    tactical = parse_tactical(tactical_src)
                    if tactical is None:
                        continue
                    self.apply_tactical(tactical)

            except EOFError:
                if self.debug:
                    traceback.print_exc()
                self.command_quit()

            except KeyboardInterrupt:
                if self.debug:
                    traceback.print_exc()
                self.command_quit()

            except NoStateChangeException:
                continue

            except Exception as exc:
                if self.debug:
                    traceback.print_exc()
                else:
                    print(f"{ANSI.in_bold_red('error:')} {ANSI.in_bold(exc)}")

    def apply_tactical(self, tactical: Tactical) -> None:
        old_state = self.proof_state
        self.proof_state = tactical.apply(self.proof_state)

        # store the history once the tactic goes through
        self.undo_states.append((old_state, tactical))
        self.redo_states = []
        self.print_state()

    def print_state(self) -> None:
        segments = []

        # print all current inline claims
        global_claims = self.proof_state.get_all_global_claims()
        if len(global_claims):
            lines = ["claim(s):"]

            for claim in global_claims:
                if len(claim.theorem.context.essentials) == 0:
                    lines.append(TAB + str(claim.theorem.statement))
                else:
                    for i, essential in enumerate(claim.theorem.context.essentials):
                        line = TAB
                        if i == 0: line += "${ "
                        else: line += "   "
                        line += str(essential)
                        lines.append(line)

                    lines.append(TAB + "   " + str(claim.theorem.statement) + " $}")

            segments.append("\n".join(lines))

        # print all current goals
        current_goals = self.proof_state.get_current_goal_statements()
        if len(current_goals):
            # print all essential hypotheses usable for the current goal
            essentials = self.proof_state.get_all_essentials_for_top_goal()
            local_claims = self.proof_state.get_all_local_claims()
            disjoints = self.proof_state.composer.get_all_disjoints()

            if len(essentials) or len(local_claims) or len(disjoints):
                segments.append(
                    "\n".join(
                        [
                            "hypotheses:",
                            *[
                                TAB + "$d " + " ".join(map(str, disjoint.metavariables)) + " $."
                                for disjoint in disjoints
                            ],
                            *[TAB + str(essential.statement) for essential in essentials],
                            *[TAB + str(claim.theorem.statement) for claim in local_claims],
                        ]
                    )
                )

            segments.append(
                "\n".join(
                    [
                        "goal(s):",
                        *[
                            f"{TAB}{ANSI.in_bold(goal)}" if i == 0 else f"{TAB}{goal}"
                            for i, goal in enumerate(current_goals)
                        ],
                    ]
                )
            )
        else:
            segments.append("no goals left!")

        separator = "===================="
        print(separator + "\n" + f"\n{separator}\n".join(segments))

    @BuiltinCommand.add("reload", help_message="reload the theory file and re-apply all tactics")
    def command_reload(self) -> None:
        ans = input(f"are you sure to reload {self.init_theory_path}? (y/n) <n> ")
        if ans.strip().lower() != "y":
            return

        if len(self.undo_states):
            print("re-applying the following script:")
            print("==================")
            self.command_script()
            print("==================")

        old_tacticals = [tactical for _, tactical in self.undo_states]
        self.init_from_theory_and_goal(self.init_theory_path, self.init_goal.statement.label)
        self.undo_states = []
        self.redo_states = []

        # re-apply all tactics
        for tactical in old_tacticals:
            print(f"applying the tactical: {tactical}")
            self.apply_tactical(tactical)

        if len(self.undo_states) == 0:
            self.print_state()

    @BuiltinCommand.add("undo", help_message="undo a tactic")
    def command_undo(self) -> None:
        if len(self.undo_states):
            old_state, tactical = self.undo_states.pop()
            self.redo_states.append((self.proof_state, tactical))
            print(f"undoing tactical {tactical}")
            self.proof_state = old_state
            self.print_state()
        else:
            print("no previous state")

    @BuiltinCommand.add("redo", help_message="redo a tactic")
    def command_redo(self) -> None:
        if len(self.redo_states):
            new_state, tactical = self.redo_states.pop()
            self.undo_states.append((self.proof_state, tactical))
            print(f"redoing tactical `{tactical}`")
            self.proof_state = new_state
            self.print_state()
        else:
            print("no newer state")

    @BuiltinCommand.add("goal", help_message="print the current goal(s)")
    def command_goal(self) -> None:
        self.print_state()

    @BuiltinCommand.add("proof", help_message="once all goals are resolved, print the final proof")
    def command_proof(self, output_file: Optional[str] = None) -> None:
        proof = self.proof_state.gen_proof()
        stmt = proof.as_compressed_statement(self.goal_name, self.proof_state.composer.context)
        proof_text = Encoder.encode_string(stmt)

        if output_file is not None:
            with open(output_file, "w") as output:
                output.write(proof_text)
        else:
            print(proof_text)

    @BuiltinCommand.add("script", help_message="print all tactics applied")
    def command_script(self) -> None:
        print("\n".join(map(lambda t: str(t[1]), self.undo_states)))

    @BuiltinCommand.add("help", help_message="print this help message")
    def command_help(self) -> None:
        BuiltinCommand.print_help()
        print("\navailable tactics:")
        for name, (_, help_msg) in self.proof_state.all_tactics.items():
            print(f"{TAB}{name} - {help_msg or '<no help message>'}")

    @BuiltinCommand.add("q", "quit", "exit", help_message="quit itp")
    def command_quit(self) -> None:
        try:
            ans = input("\nquit? (y/n) <n> ")

        except EOFError:
            print("okay...")
            exit(1)

        except KeyboardInterrupt:
            print("okay...")
            exit(1)

        if ans.strip().lower() == "y":
            exit(0)
