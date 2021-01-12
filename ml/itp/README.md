Metamath interactive theorem prover
---

This is an in-house interactive theorem prover specialized
for proving things in matching logic.

## Usage

```
python3 -m ml.itp <mm file> <statement to prove>
```

## Example 1

Suppose we have the following unproved statement in the theory file `theory/matching-logic.mm`
```
test $p |- ( \imp ph0 ph0 ) $= ? $.
```

Then run
```
python3 -m ml.itp theory/matching-logic.mm test
```

`itp` will print the current goal and wait for input
```
goal(s):
  $? |- ( \imp ph0 ph0 ) $.
> 
```

Input the following proof script
```
apply proof-rule-mp
apply proof-rule-mp
apply proof-rule-prop-2
let $5 = "( \imp ph0 ph0 )"
apply proof-rule-prop-1
apply proof-rule-prop-1
```

If everything goes well, there would be no goals left
```
no goals left!
> 
```

Use `proof` command to show the final proof along with the statement
```
> proof
$p |- ( \imp ph0 ph0 ) $= ph0-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern imp-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern ph0-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern ph0-is-pattern imp-is-pattern imp-is-pattern ph0-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern imp-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern imp-is-pattern ph0-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern ph0-is-pattern proof-rule-prop-2 ph0-is-pattern ph0-is-pattern ph0-is-pattern imp-is-pattern proof-rule-prop-1 proof-rule-mp ph0-is-pattern ph0-is-pattern proof-rule-prop-1 proof-rule-mp $.
```

Use `script` to print the command used (same as the proof script used above)
```
apply proof-rule-mp
apply proof-rule-mp
apply proof-rule-prop-2
let $5 = "( \imp ph0 ph0 )"
apply proof-rule-prop-1
apply proof-rule-prop-1
```

## Example 2

`itp` currently supports a small amount of proof automation.
For instance, suppose we want to prove the following lemma
```
kore-top-valid $p |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $= ? $.
```

Once this is expanded, one can see that this is equivalent to
```
|- ( \eq ( \inh ph0 ) ( \inh ph0 ) )
```
which is true by reflexivity of `\eq`.

So we can apply `notation-proof`:
```
goal(s):
  $? |- ( \kore-valid ph0 ( \kore-top ph0 ) ) $.
> apply notation-proof
goal(s):
  $? |- $0 $.
  $? #Notation ( \kore-valid ph0 ( \kore-top ph0 ) ) $0 $.
> let $0 = "( \eq ( \inh ph0 ) ( \inh ph0 ) )"
goal(s):
  $? |- ( \eq ( \inh ph0 ) ( \inh ph0 ) ) $.
  $? #Notation ( \kore-valid ph0 ( \kore-top ph0 ) ) ( \eq ( \inh ph0 ) ( \inh ph0 ) ) $.
> 
```

The first goal is just by reflexivity
```
> apply lemma-eq-reflexivity
goal(s):
  $? #Notation ( \kore-valid ph0 ( \kore-top ph0 ) ) ( \eq ( \inh ph0 ) ( \inh ph0 ) ) $.
> 
```

The next goal might be tedious to prove if the term is huge,
so one can use the `notation` tactic to try to prove it
automatically.
```
goal(s):
  $? #Notation ( \kore-valid ph0 ( \kore-top ph0 ) ) ( \eq ( \inh ph0 ) ( \inh ph0 ) ) $.
> notation
no goals left!
> 
```

So we have the concise proof script
```
apply notation-proof
let $0 = "( \eq ( \inh ph0 ) ( \inh ph0 ) )"
apply lemma-eq-reflexivity
notation
```
