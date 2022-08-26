MAKEFILE_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
REPO_DIR := $(MAKEFILE_DIR)/../..
SPECS_DIR := $(MAKEFILE_DIR)/specs
STATS_DIR := $(MAKEFILE_DIR)/stats
DEFINITIONS_DIR := $(MAKEFILE_DIR)/definitions

PROVE_REACHABILITY := pypy3 -m scripts.prove_reachability --standalone
EXP_OPTIONS := --smt-prelude $(MAKEFILE_DIR)/exp.smt2 --z3-tactic "(and-then qfnra-nlsat default)" --unknown-as-sat
GCD_OPTIONS := --smt-prelude $(MAKEFILE_DIR)/gcd.smt2 --z3-timeout 10000 --unknown-as-sat
COUNT_BY_K_OPTIONS := --smt-prelude $(MAKEFILE_DIR)/count-by-k.smt2 --z3-tactic "(! default :random_seed 0)" --z3-timeout 60000 --unknown-as-sat

CARGO := cargo
MMVERIFY := pypy3 $(MAKEFILE_DIR)/mmverify.py
RUST_METAMATH := $(REPO_DIR)/rust-metamath/target/release/rust-metamath
SMETAMATH := smetamath --verify --silent

SPLIT_DASH = $(word $2,$(subst -, ,$1))

ALL_TARGETS := \
	proofs/imp-sum.mm \
	proofs/imp-exp.mm \
	proofs/imp-collatz.mm \
	proofs/imp-gcd.mm \
	proofs/imp-product.mm \
	proofs/reg-sum.mm \
	proofs/reg-exp.mm \
	proofs/reg-collatz.mm \
	proofs/reg-gcd.mm \
	proofs/reg-product.mm \
	proofs/pcf-sum.mm \
	proofs/pcf-exp.mm \
	proofs/pcf-collatz.mm \
	proofs/pcf-gcd.mm \
	proofs/pcf-product.mm \
	proofs/imp-loop-new-count-by-1.mm \
	proofs/imp-loop-new-count-by-2.mm \
	proofs/imp-loop-new-half.mm \
	proofs/imp-loop-new-gauss-sum.mm \
	proofs/imp-loop-new-nested-1.mm
# proofs/imp-loop-new-count-by-k.mm \

DEFINITION_NAME = $(call SPLIT_DASH,$*,1)
MODULE_NAME = $(shell echo $(DEFINITION_NAME) | tr '[:lower:]' '[:upper:]')
DEFINITION_PATH = $(DEFINITIONS_DIR)/$(DEFINITION_NAME).k

.PHONY: all
all: verify verify-with-rust-metamath verify-compressed

# generate all uncompressed proofs
.PHONY: gen
gen: $(ALL_TARGETS)

.PHONY: compress
compress: $(addsuffix .xz,$(ALL_TARGETS))

.PHONY: verify
verify: $(subst proofs/,stats/,$(addsuffix .verify.time,$(ALL_TARGETS)))

.PHONY: rust-metamath verify-with-rust-metamath
verify-with-rust-metamath: $(subst proofs/,stats/,$(addsuffix .verify-with-rust-metamath.time,$(ALL_TARGETS)))

.PHONY: verify
verify-compressed: $(subst proofs/,stats/,$(addsuffix .verify-compressed.time,$(ALL_TARGETS)))

.PHONY: rust-metamath
rust-metamath:
	cd $(REPO_DIR)/rust-metamath && cargo build --release

proofs/%-exp.mm: $(SPECS_DIR)/%-exp-spec.k
	cd $(REPO_DIR) && \
	\time -v -o $(STATS_DIR)/$*-exp.mm.time \
	$(PROVE_REACHABILITY) $(EXP_OPTIONS) $(DEFINITION_PATH) $(MODULE_NAME) $< $(MODULE_NAME)-EXP-SPEC --output $(MAKEFILE_DIR)/$@ \
	1> $(STATS_DIR)/$*-exp.mm.stdout \
	2> $(STATS_DIR)/$*-exp.mm.stderr

proofs/%-gcd.mm: $(SPECS_DIR)/%-gcd-spec.k
	cd $(REPO_DIR) && \
	\time -v -o $(STATS_DIR)/$*-gcd.mm.time \
	$(PROVE_REACHABILITY) $(GCD_OPTIONS) $(DEFINITION_PATH) $(MODULE_NAME) $< $(MODULE_NAME)-GCD-SPEC --output $(MAKEFILE_DIR)/$@ \
	1> $(STATS_DIR)/$*-gcd.mm.stdout \
	2> $(STATS_DIR)/$*-gcd.mm.stderr

proofs/%-loop-new-count-by-k.mm: $(SPECS_DIR)/%-loop-new-count-by-k-spec.k
	cd $(REPO_DIR) && \
	\time -v -o $(STATS_DIR)/$*-loop-new-count-by-k.mm.time \
	$(PROVE_REACHABILITY) $(COUNT_BY_K_OPTIONS) $(DEFINITION_PATH) $(MODULE_NAME) $< $(MODULE_NAME)-LOOP-NEW-COUNT-BY-K-SPEC --output $(MAKEFILE_DIR)/$@ \
	1> $(STATS_DIR)/$*-loop-new-count-by-k.mm.stdout \
	2> $(STATS_DIR)/$*-loop-new-count-by-k.mm.stderr

proofs/%.mm: $(SPECS_DIR)/%-spec.k
	cd $(REPO_DIR) && \
	\time -v -o $(STATS_DIR)/$*.mm.time \
	$(PROVE_REACHABILITY) $(DEFINITION_PATH) $(MODULE_NAME) $< $(shell echo $* | tr '[:lower:]' '[:upper:]')-SPEC --output $(MAKEFILE_DIR)/$@ \
	1> $(STATS_DIR)/$*.mm.stdout \
	2> $(STATS_DIR)/$*.mm.stderr

stats/%.mm.verify.time: proofs/%.mm
	\time -v -o $@ $(SMETAMATH) $<

stats/%.mm.verify-with-rust-metamath.time: proofs/%.mm
	\time -v -o $@ $(RUST_METAMATH) $<

stats/%.mm.verify-compressed.time: SHELL:=/bin/bash
stats/%.mm.verify-compressed.time: proofs/%.mm.xz
	\time -v -o $@ $(SMETAMATH) <(xz -dc $<)

proofs/%.mm.xz: proofs/%.mm
	xz -zk -6 < $< > $@

.PHONY: clean
clean:
	rm -f proofs/*.mm stats/*.time stats/*.stdout stats/*.stderr
