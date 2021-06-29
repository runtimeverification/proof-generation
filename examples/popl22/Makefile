MAKEFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
REPO_DIR := $(MAKEFILE_DIR)/../..
SPECS_DIR := $(MAKEFILE_DIR)/specs
DEFINITIONS_DIR := $(MAKEFILE_DIR)/definitions

PROVE_REACHABILITY := cd $(REPO_DIR) && pypy3 -m scripts.prove_reachability --standalone
EXP_OPTIONS := --smt-prelude $(MAKEFILE_DIR)/prelude.smt2 --z3-tactic "(and-then qfnra-nlsat default)" --unknown-as-sat

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

proofs/%-exp.mm: $(SPECS_DIR)/%-exp-spec.k
	$(PROVE_REACHABILITY) $(EXP_OPTIONS) $(DEFINITION_PATH) $(MODULE_NAME) $< $(MODULE_NAME)-EXP-SPEC --output $(MAKEFILE_DIR)/$@

proofs/%.mm: $(SPECS_DIR)/%-spec.k
	$(PROVE_REACHABILITY) $(DEFINITION_PATH) $(MODULE_NAME) $< $(shell echo $* | tr '[:lower:]' '[:upper:]')-SPEC --output $(MAKEFILE_DIR)/$@

.PHONY: clean
clean:
	rm -f *.mm
