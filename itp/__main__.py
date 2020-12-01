import argparse
import readline
import traceback

from proof.metamath.ast import StructuredStatement, Statement, Application, Metavariable
from proof.metamath.parser import load_database
from proof.metamath.composer import Composer

from .parser import parse_command
from .state import ProofState
from .ansi import ANSI

import itp.auto


def quit_prompt():
    try:
        ans = input("\nquit? (y/n) <n> ")
    except KeyboardInterrupt:
        print("okay...")
        exit(1)

    if ans.lower() == "y":
        exit(0)


def print_state(state: ProofState):
    if len(state.goal_stack):
        print("goal(s):")
        for i, goal in enumerate(state.goal_stack[::-1]):
            if i == 0:
                print(f"  {ANSI.BOLD}{goal}{ANSI.RESET}")
            else:
                print(f"  {goal}")
    else:
        print("no goals left!")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("theory", help=".mm theory file")
    parser.add_argument("goal", help="the initial goal statement")
    parser.add_argument("--debug", action="store_const", const=True, default=False, help="enable debug mode")
    args = parser.parse_args()

    composer = Composer()
    database = load_database(args.theory)
    composer.load(database)
    assert args.goal in composer.theorems, f"cannot find label {args.goal} in the theory file {args.theory}"

    goal = composer.theorems[args.goal]
    composer.remove_theorem(args.goal)
    
    state = ProofState(composer, [ goal.statement ], [ composer.load(essential) for essential in goal.essentials ])

    undo_states = [] # [(state before command, applied_command)]
    redo_states = [] # [(state after command, applied_command)]

    print_state(state)

    while True:
        try:
            command_src = input("> ").strip()
            if not command_src: continue

            if command_src.lower() in { "q", "quit", "exit" }:
                quit_prompt()
            elif command_src.lower() == "undo":
                if len(undo_states):
                    old_state, command = undo_states.pop()
                    redo_states.append((state, command))
                    print(f"undoing command {command}")
                    state = old_state
                else:
                    print("no previous state")
            elif command_src.lower() == "redo":
                if len(redo_states):
                    undo_states.append((state, command))
                    new_state, command = redo_states.pop()
                    print(f"redoing command `{command}`")
                    state = new_state
                else:
                    print("no newer state")
            elif command_src.lower() == "proof":
                proof = state.gen_proof()
                print(proof)
            elif command_src.lower() == "script":
                print("\n".join(map(lambda t: str(t[1]), undo_states)))
            else:
                command = parse_command(command_src)

                # applying the command
                old_state = state
                state = state.apply_tactic(command.get_tactic(state))

                # store the history once the tactic goes through
                undo_states.append((old_state, command))
                redo_states = []

                print_state(state)

        except Exception as exc:
            if args.debug:
                traceback.print_exc()
            else:
                print(f"{ANSI.COLOR_RED}error:{ANSI.RESET} {ANSI.BOLD}{exc}{ANSI.RESET}")

        except KeyboardInterrupt:
            if args.debug:
                traceback.print_exc()
            quit_prompt()


if __name__ == "__main__":
    main()
