MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
REPO_DIR := $(MAKEFILE_DIR)/../..
SPECS_DIR := $(MAKEFILE_DIR)/specs
STATS_DIR := $(MAKEFILE_DIR)/stats
DEFINITIONS_DIR := $(MAKEFILE_DIR)/definitions

PROVE_REACHABILITY := pypy3 -m scripts.prove_reachability --standalone
EXP_OPTIONS := --smt-prelude $(MAKEFILE_DIR)/prelude.smt2 --z3-tactic "(and-then qfnra-nlsat default)" --unknown-as-sat

MMVERIFY := pypy3 $(MAKEFILE_DIR)/mmverify.py

SPLIT_DASH = $(word $2,$(subst -, ,$1))

ALL_TARGETS := \
	proofs/imp-sum.mm \
	proofs/imp-exp.mm \
	proofs/imp-collatz.mm \
	proofs/reg-sum.mm \
	proofs/reg-exp.mm \
	proofs/reg-collatz.mm \
	proofs/pcf-sum.mm \
	proofs/pcf-exp.mm \
	proofs/pcf-collatz.mm

DEFINITION_NAME = $(call SPLIT_DASH,$*,1)
MODULE_NAME = $(shell echo $(DEFINITION_NAME) | tr '[:lower:]' '[:upper:]')
DEFINITION_PATH = $(DEFINITIONS_DIR)/$(DEFINITION_NAME).k

.PHONY: all
all: $(ALL_TARGETS)

.PHONY: verify
verify: $(subst proofs/,stats/,$(addsuffix .verify.time,$(ALL_TARGETS)))

.PHONY: verify
compressed-verify: $(subst proofs/,stats/,$(addsuffix .compressed-verify.time,$(ALL_TARGETS)))

.PHONY: compress
compress: $(addsuffix .xz,$(ALL_TARGETS))
	du -sh proofs/*.mm.xz

proofs/%-exp.mm: $(SPECS_DIR)/%-exp-spec.k
	cd $(REPO_DIR) && \
	\time -v -o $(STATS_DIR)/$*-exp.mm.time \
	$(PROVE_REACHABILITY) $(EXP_OPTIONS) $(DEFINITION_PATH) $(MODULE_NAME) $< $(MODULE_NAME)-EXP-SPEC --output $(MAKEFILE_DIR)/$@

proofs/%.mm: $(SPECS_DIR)/%-spec.k
	cd $(REPO_DIR) && \
	\time -v -o $(STATS_DIR)/$*.mm.time \
	$(PROVE_REACHABILITY) $(DEFINITION_PATH) $(MODULE_NAME) $< $(shell echo $* | tr '[:lower:]' '[:upper:]')-SPEC --output $(MAKEFILE_DIR)/$@

stats/%.mm.verify.time: proofs/%.mm
	\time -v -o $@ $(MMVERIFY) < $<

stats/%.mm.compressed-verify.time: proofs/%.mm.xz
	xz -dc $< | \time -v -o $@ $(MMVERIFY)

proofs/%.mm.xz: proofs/%.mm
	xz -zk -6 < $< > $@

.PHONY: clean
clean:
	rm -f *.mm
