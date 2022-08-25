// https://github.com/sosy-lab/sv-benchmarks/blob/master/c/loops-crafted-1/in-de31.c
/*
Original test case:

int main()
{
  unsigned int n = __VERIFIER_nondet_uint();
  unsigned int x=n, y=0, z;
  while(x>0)
  {
  x--;
  y++;
  }

  z = y;
  while(z>0)
  {
  x++;
  z--;
  }

  while(y>0)
  {
  y--;
  z++;
  }

  __VERIFIER_assert(z==n);
  return 0;
}
*/

module IMP-INDE31-SPEC

imports IMP

syntax Id ::= "x" [token]
      | "y" [token]
      | "z" [token]

// The main goal
claim
  <k>
    int x, y, z;
    x = X:Int;
    y = 0;
    z = 0;

    // equiv to y += x; x = 0;
    while (x > 0) {
      x = x - 1;
      y = y + 1;
    }

    z = y;

    // equiv to x += z; z = 0;
    while (z > 0) {
      x = x + 1;
      z = z - 1;
    }

    // equiv to z += y; y = 0;
    while (y > 0) {
      y = y - 1;
      z = z + 1;
    }
    =>
    .
  </k>
  <state>
    .Map =>
    x |-> X
    y |-> 0 // x, y are not specified in the original postcondition, but we still need to specify them here
    z |-> X
  </state>
  requires X >=Int 0
  [one-path]

// inductive invariant for loop 1
claim
  <k>
    while (x > 0) {
      x = x - 1;
      y = y + 1;
    }
    => .
    ... // note we need these dots here to allow some unfinished computation
  </k>
  <state>
    x |-> (X:Int => 0)
    y |-> (Y:Int => X +Int Y)
    z |-> _:Int
  </state>
  requires X >=Int 0
  [one-path]

// inductive invariant for loop 2
claim
  <k>
    while (z > 0) {
      x = x + 1;
      z = z - 1;
    }
    => .
    ...
  </k>
  <state>
    x |-> (X:Int => X +Int Z)
    y |-> _:Int
    z |-> (Z:Int => 0)
  </state>
  requires Z >=Int 0
  [one-path]

// inductive invariant for loop 3
claim
  <k>
    while (y > 0) {
      y = y - 1;
      z = z + 1;
    }
    => .
    ...
  </k>
  <state>
    x |-> _:Int
    y |-> (Y:Int => 0)
    z |-> (Z:Int => Z +Int Y)
  </state>
  requires Y >=Int 0
  [one-path]

endmodule
