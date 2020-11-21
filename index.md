---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

Welcome to matching logic proof checker!
The goal of this project is to define a rigorous
proof system of [matching logic](http://www.matching-logic.org/index.php/Matching_Logic)
in a suitable tool (we are currently using [Metamath](http://us.metamath.org/)),
so that we can have a minimal trust base for all the
tools we build around matching logic and [K](https://kframework.org/).

Right now, we are building a proof generator
and checker for [Kore](https://github.com/kframework/kore) (the core calculus of K),
which is able to take a Kore definition and
a trace for the execution of a program, and
generate a proof for the correctness of the
execution, essentially showing that the initial
configuration indeed rewrites to the final
configuration.

For instance, suppose we have the following K definition:
```
module FOO
    imports DOMAINS

    syntax Foo ::= foo(Int)
                 | id(Foo)
                 | bar(Foo, Foo)

    rule id(X:Foo) => X
    rule bar(X:Foo, Y:Foo) => X
endmodule
```

When we execute this simple program:
```
bar(id(foo(13)), id(foo(12)))
```

It should rewrite to `foo(13)` through the trace:
```
   bar(id(foo(13)), id(foo(12)))
=> id(foo(13))
=> foo(13)
```

And given these pieces of information, our generator
would generate a Metamath file that contains proofs
for the rewriting steps

```
<Axioms and definitions of Kore>

<Axioms in the FOO module>

$( the actual encoding is different $)

step-1 $p |- <bar(id(foo(13)), id(foo(12)))> => <id(foo(13))> $= ... $.
step-2 $p |- <id(foo(13))> => <foo(13)> $= ... $.

goal $p |- <bar(id(foo(13)), id(foo(12)))> => <id(foo(13))> $= ... $.
```

which is automatically checkable using Metamath.
