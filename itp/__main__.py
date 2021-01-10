from typing import Optional, List

import argparse
import readline
import traceback

from proof.metamath.ast import StructuredStatement, Statement, Application, Metavariable
from proof.metamath.parser import load_database
from proof.metamath.composer import Composer

from .ast import Command
from .parser import parse_command
from .state import ProofState, NoStateChangeException
from .ansi import ANSI

import itp.auto
import itp.tactics

readline.parse_and_bind("tab: complete")

TAB = "  "


class BuiltinCommand:
    builtin_commands = [] # list of BuiltinCommand

    def __init__(self, *names, help_message=None, handler=None):
        self.names = set(names)
        self.help_message = help_message
        self.handler = handler

    @staticmethod
    def add(*args, **kwargs):
        def decorator(handler):
            BuiltinCommand.builtin_commands.append(BuiltinCommand(*args, **kwargs, handler=handler))
            return handler
        return decorator

    @staticmethod
    def get_all_command_names() -> List[str]:
        return sum([ sorted(cmd.names) for cmd in BuiltinCommand.builtin_commands ], [])

    @staticmethod
    def print_help():
        lines = []

        for command in BuiltinCommand.builtin_commands:
            lines.append("{}{} - {}".format(TAB, "/".join(command.names), command.help_message))

        print("""\
usage:
{}<tactic> [options] - apply a tactic
{}""".format(TAB, "\n".join(lines)))


class InteractiveState:
    def __init__(self, debug=False):
        self.undo_states = []
        self.redo_states = []
        self.proof_state = None
        self.debug = debug

        self.init_theory_path = None
        self.init_goal = None

    def init_from_theory_and_goal(self, theory_path: str, goal_name: str):
        composer = Composer()
        database = load_database(theory_path, include_proof=False)
        composer.load(database)
        assert goal_name in composer.theorems, f"cannot find label {goal_name} in the theory file {theory_path}"

        goal = composer.theorems[goal_name]
        composer.remove_theorem(goal_name)

        # TODO: this assumes no essential statements in the top-level block
        for essential in goal.essentials:
            composer.load(essential)

        self.init_theory_path = theory_path
        self.init_goal = goal
        self.proof_state = ProofState(composer, goal.statement)

        # initialize completer
        readline.set_completer_delims(" ")
        readline.set_completer(self.command_completer)

    def command_completer(self, text: str, state: int) -> List[str]:
        command_names = sorted(ProofState.all_tactics.keys()) + BuiltinCommand.get_all_command_names()
        theorem_names = sorted(self.proof_state.composer.theorems.keys())

        current_buffer = readline.get_line_buffer().decode().lstrip()
        split = current_buffer.split(" ")

        if len(split) > 1:
            filtered_names = [ name for name in theorem_names if name.startswith(text) ]

            if text.startswith("\""):
                filtered_names = [ "\"" + name + "\"" for name in theorem_names if name.startswith(text[1:]) ]
            else:
                filtered_names = [ name for name in theorem_names if name.startswith(text) ]
        else:
            filtered_names = [ name + " " for name in command_names if name.startswith(text) ]

        return (filtered_names + [ None ])[state]

    def loop(self):
        self.print_state()
        while True:
            try:
                command_src = input("> ").strip()
                if not command_src: continue

                lowered = command_src.lower()
                split = lowered.split()
                for command in BuiltinCommand.builtin_commands:
                    if split[0] in command.names:
                        command.handler(self, *split[1:])
                        break
                else:
                    # apply a tactic command then
                    command = parse_command(command_src)
                    if command is None: continue
                    self.apply_tactic_command(command)

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
                    print(f"{ANSI.COLOR_RED}error:{ANSI.RESET} {ANSI.BOLD}{exc}{ANSI.RESET}")

    def apply_tactic_command(self, command: Command):
        old_state = self.proof_state
        self.proof_state = command.apply_tactic(self.proof_state)

        # store the history once the tactic goes through
        self.undo_states.append((old_state, command))
        self.redo_states = []
        self.print_state()

    def print_state(self):
        segments = []

        # print all current inline claims
        claims = self.proof_state.get_all_claims()
        if len(claims):
            segments.append("\n".join([
                "inline claim(s):",
                *[ TAB + str(claim.statement) for claim in claims ],
            ]))

        # print all current goals
        current_goals = self.proof_state.get_current_goal_statements()
        if len(current_goals):
            # print all essential hypotheses usable for the current goal
            essentials = self.proof_state.get_all_essentials_for_current_top_goal()
            if len(essentials):
                segments.append("\n".join([
                    "essential(s):",
                    *[ TAB + str(essential.statement) for essential in essentials ],
                ]))


            segments.append("\n".join([
                "goal(s):",
                *[
                    f"{TAB}{ANSI.BOLD}{goal}{ANSI.RESET}" if i == 0 else f"{TAB}{goal}"
                    for i, goal in enumerate(current_goals)
                ]
            ]))
        else:
            segments.append("no goals left!")

        separator = "===================="
        print(separator + "\n" + f"\n{separator}\n".join(segments))

    @BuiltinCommand.add("reload", help_message="reload the theory file and re-apply all tactics")
    def command_reload(self):
        ans = input(f"are you sure to reload {self.init_theory_path}? (y/n) <n> ")
        if ans.strip().lower() != "y": return

        if len(self.undo_states):
            print("re-applying the following script:")
            print("==================")
            self.command_script()
            print("==================")

        old_commands = [ command for _, command in self.undo_states ]
        self.init_from_theory_and_goal(self.init_theory_path, self.init_goal.statement.label)
        self.undo_states = []
        self.redo_states = []

        # re-apply all tactics
        for command in old_commands:
            print(f"applying the command: {command}")
            self.apply_tactic_command(command)

        if len(self.undo_states) == 0:
            self.print_state()

    @BuiltinCommand.add("undo", help_message="undo a tactic")
    def command_undo(self):
        if len(self.undo_states):
            old_state, command = self.undo_states.pop()
            self.redo_states.append((self.proof_state, command))
            print(f"undoing command {command}")
            self.proof_state = old_state
            self.print_state()
        else:
            print("no previous state")

    @BuiltinCommand.add("redo", help_message="redo a tactic")
    def command_redo(self):
        if len(self.redo_states):
            new_state, command = self.redo_states.pop()
            self.undo_states.append((self.proof_state, command))
            print(f"redoing command `{command}`")
            self.proof_state = new_state
            self.print_state()
        else:
            print("no newer state")

    @BuiltinCommand.add("goal", help_message="print the current goal(s)")
    def command_goal(self):
        self.print_state()

    @BuiltinCommand.add("proof", help_message="once all goals are resolved, print the final proof")
    def command_proof(self, output_file=None):
        proof_text = str(self.proof_state.gen_proof())
        if output_file is not None:
            with open(output_file, "w") as output:
                output.write(proof_text)
        else:
            print(proof_text)

    @BuiltinCommand.add("script", help_message="print all tactics applied")
    def command_script(self):
        print("\n".join(map(lambda t: str(t[1]), self.undo_states)))

    @BuiltinCommand.add("help", help_message="print this help message")
    def command_help(self):
        BuiltinCommand.print_help()
        print("\navailable tactics:")
        for name, (_, help_msg) in self.proof_state.all_tactics.items():
            print(f"{TAB}{name} - {help_msg or '<no help message>'}")

    @BuiltinCommand.add("q", "quit", "exit", help_message="quit itp")
    def command_quit(self):
        try:
            ans = input("\nquit? (y/n) <n> ")
        except KeyboardInterrupt:
            print("okay...")
            exit(1)

        if ans.strip().lower() == "y":
            exit(0)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("theory", help=".mm theory file")
    parser.add_argument("goal", help="the initial goal statement")
    parser.add_argument("--debug", action="store_const", const=True, default=False, help="enable debug mode")
    args = parser.parse_args()

    itp_state = InteractiveState(debug=args.debug)
    itp_state.init_from_theory_and_goal(args.theory, args.goal)
    itp_state.loop()


if __name__ == "__main__":
    main()
