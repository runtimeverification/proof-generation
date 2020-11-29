Metamath interactive theorem prover
---

This is an in-house interactive theorem prover specialized
for proving lemmas in matching logic.

## Usage

```
python3 -m itp <mm file> <statement to prove>
```

## Example

Suppose we have the following unproved statement in the theory file `theory/matching-logic.mm`
```
test $p |- ( \imp ph0 ph0 ) $= ? $.
```

Then run
```
python3 -m itp theory/matching-logic.mm test
```

itp will print the current goal and wait for input
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
