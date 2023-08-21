To translate ITP scripts to the new DSL format, copy the script to a file,
like the following for `bot-elim`, and add `dsl` to the end.

```
apply "proof-rule-mp"
let $0 = "( \imp \bot ( \imp ( \imp ph0 \bot ) \bot ) )"
apply "proof-rule-mp"
let $2 = "( \imp \bot ( \imp ( \imp ( \imp ph0 \bot ) \bot ) ph0 ) )"
apply "proof-rule-prop-2"
apply "proof-rule-mp"
let $7 = "( \imp ( \imp ( \imp ph0 \bot ) \bot ) ph0 )"
apply "proof-rule-prop-1"
apply "proof-rule-prop-3"
apply "proof-rule-prop-1"
dsl
```

The, run:

```
poetry run python -m ml.itp theory/matching-logic-propositional.mm bot-elim <  bot-elim.itp
```
