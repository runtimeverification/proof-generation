import subprocess
from scripts.runtest import gen_proof

tests_run_counter = 0

test_parameters = [
    ("examples/two-counters/two-counters.k",
     "TWO-COUNTERS",
     "examples/two-counters/programs/10.two-counters",
     "tmp"),
    ("examples/map-test/map-test.k",
     "MAP-TEST",
     "examples/map-test/pgm-comm.map-test",
     "tmp"),
]

def call_metamath_verifier():
    subprocess.run(["metamath", "read \"tmp/goal.mm\"", "verify proof *", "exit"])

def run_test(kore_definition: str, module: str, program: str, output_dir: str):
    global tests_run_counter
    print("-" * 10)
    gen_proof(kore_definition, module, program, output_dir)
    call_metamath_verifier()
    print("-" * 10)
    tests_run_counter = tests_run_counter + 1

def main():
    global tests_run_counter
    global test_parameters

    print("=" * 20)
    print("  Running Test(s)")
    print("=" * 20)
    print('\n')

    for koredef, module, pgm, output in test_parameters:
        run_test(koredef, module, pgm, output)
    
    print("=" * 20)
    print("  ", tests_run_counter, "Test(s) Done.")
    print("=" * 20)
    print('\n')

if __name__ == "__main__":
    main()