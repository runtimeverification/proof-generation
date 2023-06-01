POETRY     := poetry
POETRY_RUN := $(POETRY) run

PATH := $(abspath .build/bin):$(abspath deps/k/k-distribution/bin):$(PATH)
export PATH

# Disable all implicit recipes, e.g. those for building C programs.
.SUFFIXES:

default: check test-unit

all: check cov

.PHONY: clean
clean:
	rm -rf dist .coverage cov-* .mypy_cache .pytest_cache
	find -type d -name __pycache__ -prune -exec rm -rf {} \;

.PHONY: build
build:
	$(POETRY) build

.PHONY: poetry-install
poetry-install:
	$(POETRY) install


# Dependencies

METAMATH_EXE := .build/bin/metamath

.PHONY: deps
deps: deps-metamath

.PHONY: deps-metamath
deps-metamath: $(METAMATH_EXE)

$(METAMATH_EXE): deps/metamath-exe/README.TXT
	mkdir -p $(dir $@)
	gcc deps/metamath-exe/src/*.c -o $@
	pwd
	ls .build/bin

# Tests

test: test-all


# Metamath tests

test-all : test-metamath-prelude

%.mm.verify : %.mm $(METAMATH_EXE)
	echo ${PATH}
	bin/metamath-verify $<

METAMATH_PRELUDE_FILES := $(wildcard theory/*.mm)
test-metamath-prelude : $(addsuffix .verify, ${METAMATH_PRELUDE_FILES})


# Python Tests

TEST_ARGS :=

test-all: poetry-install
	$(POETRY_RUN) pytest src/tests --maxfail=1 --verbose --durations=0 --numprocesses=4 --dist=worksteal $(TEST_ARGS)

test-unit: poetry-install
	$(POETRY_RUN) pytest src/tests/unit --maxfail=1 --verbose $(TEST_ARGS)

test-integration: poetry-install
	$(POETRY_RUN) pytest src/tests/integration --maxfail=1 --verbose --durations=0 --numprocesses=4 --dist=worksteal $(TEST_ARGS)


# Coverage

COV_ARGS :=

cov: cov-all

cov-%: TEST_ARGS += --cov=proof_generation --no-cov-on-fail --cov-branch --cov-report=term

cov-all: TEST_ARGS += --cov-report=html:cov-all-html $(COV_ARGS)
cov-all: test-all

cov-unit: TEST_ARGS += --cov-report=html:cov-unit-html $(COV_ARGS)
cov-unit: test-unit

cov-integration: TEST_ARGS += --cov-report=html:cov-integration-html $(COV_ARGS)
cov-integration: test-integration


# Checks and formatting

format: autoflake isort black
check: check-flake8 check-mypy check-autoflake check-isort check-black

check-flake8: poetry-install
	$(POETRY_RUN) flake8 src

check-mypy: poetry-install
	$(POETRY_RUN) mypy src

autoflake: poetry-install
	$(POETRY_RUN) autoflake --quiet --in-place src

check-autoflake: poetry-install
	$(POETRY_RUN) autoflake --quiet --check src

isort: poetry-install
	$(POETRY_RUN) isort src

check-isort: poetry-install
	$(POETRY_RUN) isort --check src

black: poetry-install
	$(POETRY_RUN) black src

check-black: poetry-install
	$(POETRY_RUN) black --check src


# Optional tools

SRC_FILES := $(shell find src -type f -name '*.py')

pyupgrade: poetry-install
	$(POETRY_RUN) pyupgrade --py310-plus $(SRC_FILES)


# Proof generation tests

test-all : test-metamath-imp
.PHONY : test-metamath-imp

.build/examples/imp/imp-haskell/definition/definition.kore: MAIN_MODULE=IMP
.build/%-haskell/definition/definition.kore: %.k
	kompile $< --backend haskell --main-module ${MAIN_MODULE} --output-definition $(dir $@)
.build/examples/imp/imp-haskell/definition.mm: .build/examples/imp/imp-haskell/definition/definition.kore theory/prelude.mm
	$(POETRY_RUN) gen-rewrite-proof --standalone --prelude theory/prelude.mm $< IMP -o $@
test-metamath-imp : .build/examples/imp/imp-haskell/definition.mm.verify

