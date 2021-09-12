.PHONY: exec-only
exec-only:
	kompile \
		--backend haskell \
		--md-selector "k" \
		-w all -Wno unused-symbol -Wno useless-rule \
		--main-module MICHELSON \
		--syntax-module SYMBOLIC-UNIT-TEST-SYNTAX \
		michelson.md

.PHONY: all
all:
	kompile \
		--backend haskell \
		--md-selector "k | symbolic | internalized-rl" \
		-w all -Wno unused-symbol -Wno useless-rule \
		--main-module MICHELSON \
		--syntax-module SYMBOLIC-UNIT-TEST-SYNTAX \
		michelson.md
