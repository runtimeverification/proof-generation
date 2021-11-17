import os
import re

os.chdir(os.path.dirname(os.path.abspath(__file__)))


# A script to collect all stats and generate a table

tasks = [
    ("sum.imp", { "def": "imp", "spec": "sum" }),
    ("sum.reg", { "def": "reg", "spec": "sum" }),
    ("sum.pcf", { "def": "pcf", "spec": "sum" }),
    ("exp.imp", { "def": "imp", "spec": "exp" }),
    ("exp.reg", { "def": "reg", "spec": "exp" }),
    ("exp.pcf", { "def": "pcf", "spec": "exp" }),
    ("collatz.imp", { "def": "imp", "spec": "collatz" }),
    ("collatz.reg", { "def": "reg", "spec": "collatz" }),
    ("collatz.pcf", { "def": "pcf", "spec": "collatz" }),
    ("product.imp", { "def": "imp", "spec": "product" }),
    ("product.reg", { "def": "reg", "spec": "product" }),
    ("product.pcf", { "def": "pcf", "spec": "product" }),
    ("gcd.imp", { "def": "imp", "spec": "gcd" }),
    ("gcd.reg", { "def": "reg", "spec": "gcd" }),
    ("gcd.pcf", { "def": "pcf", "spec": "gcd" }),
    ("ln/count-by-1", { "def": "imp", "spec": "loop-new-count-by-1" }),
    ("ln/count-by-2", { "def": "imp", "spec": "loop-new-count-by-2" }),
    ("ln/count-by-k", { "def": "imp", "spec": "loop-new-count-by-k" }),
    ("ln/gauss-sum", { "def": "imp", "spec": "loop-new-gauss-sum" }),
    ("ln/half", { "def": "imp", "spec": "loop-new-half" }),
    ("ln/nested-1", { "def": "imp", "spec": "loop-new-nested-1" }),
]


def get_user_time(path):
    assert os.path.isfile(path)
    with open(path) as f:
        content = f.read()
        match = re.search(r"User time \(seconds\): ([\d\.]+)", content)
        assert match is not None
        return float(match.group(1))


def get_proof_gen_time(config):
    return get_user_time(f"stats/{config['def']}-{config['spec']}.mm.time")


def get_symbolic_steps(config):
    hint_file = f"definitions/.ml-proof-cache-{config['def']}/reachability-task-{config['def']}-{config['spec']}-spec.yml"
    return sum(line.count("applied-rules:") for line in open(hint_file))


def get_hint_file_size(config):
    # in bytes
    return os.path.getsize(f"definitions/.ml-proof-cache-{config['def']}/reachability-task-{config['def']}-{config['spec']}-spec.yml")


def get_proof_size(config):
    # in bytes
    return os.path.getsize(f"proofs/{config['def']}-{config['spec']}.mm")


def get_compressed_proof_size(config):
    # in bytes
    return os.path.getsize(f"proofs/{config['def']}-{config['spec']}.mm.xz")


def get_proof_checking_time(config):
    return get_user_time(f"stats/{config['def']}-{config['spec']}.mm.verify.time")


def main():
    for name, config in tasks:
        gen_time = get_proof_gen_time(config)
        steps = get_symbolic_steps(config)
        hint_size = get_hint_file_size(config)
        proof_size = get_proof_size(config)
        compressed_proof_size = get_compressed_proof_size(config)
        verify_time = get_proof_checking_time(config)
        # compressed_verify_time = get_user_time(f"stats/{config['def']}-{config['spec']}.mm.compressed-verify.time")
        print(f"\\code{{{name}}} & {round(gen_time)}\\,s & {steps} & {round(hint_size / 1e6, 2)}\\,MB & {round(proof_size / 1e6)}/{round(compressed_proof_size / 1e6, 1)}\\,MB & {round(verify_time, 1)}\\,s \\\\")


if __name__ == "__main__":
    main()
