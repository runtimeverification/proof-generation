import argparse

from ml.metamath.composer import ProofCache
ProofCache.DISABLED = True

from .interactive import InteractiveState


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
