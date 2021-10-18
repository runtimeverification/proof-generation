from pml import *
from tableau import *
from typing import Dict, List, Tuple, cast
import pytest

S = Symbol("S")
C = Symbol("C")
D = Symbol("D")
NEXT = Symbol("next")
X = SVar("X")
Y = SVar("Y")
e  = EVar("E")
e1 = EVar("E1")
x = EVar("x")
c = EVar("c")
c1 = EVar("c1")
c2 = EVar("c2")
c3 = EVar("c3")
c4 = EVar("c4")
c5 = EVar("c5")

def test_definition_list() -> None:
    assert definition_list(X, []) == []
    assert definition_list(Mu(X, App(S, X)), []) == [Mu(X, App(S, X))]
    assert definition_list(Mu(X, Nu(Y, App(S, X))), []) \
        == [ Mu(X, Nu(Y, App(S, X)))
           , Mu(Y, DApp(S, Not(SVar(0))))
           ]

    assert definition_list(Nu(X, Mu(Y, And(X, Y))), []) \
        == [ Mu(X, Nu(Y, Or(X, Y)))
           , Mu(Y, And(Not(SVar(0)), Y))
           ]

def test_complete_closures_for_signature() -> None:
    assert complete_closures_for_signature([(frozenset(), [])], frozenset(),     [], {C : 0, S : 1}, []) == [(frozenset(), [])]
    assert complete_closures_for_signature([(frozenset(), [])], frozenset({c1}), [], {}, [])             == [(frozenset(), [])]
    cl_pes = complete_closures_for_signature([(frozenset(), [])], frozenset({c1}), [], {C : 0}, [])
    assert len(cl_pes) == 2
    assert cl_pes[0][0] == frozenset([Matches(c1,  App(C))])
    assert cl_pes[1][0] == frozenset([Matches(c1, DApp(C))])

    cl_pes = complete_closures_for_signature([(frozenset(), [])], frozenset({c}), [], {S : 1}, [])
    assert len(cl_pes) == 2
    assert cl_pes[0][0] == frozenset([Matches(c,  App(S,     c ))])
    assert cl_pes[1][0] == frozenset([Matches(c, DApp(S, Not(c)))])

    cl_pes = complete_closures_for_signature([(frozenset(), [])], frozenset({c, c1}), [], {S : 1}, [])
    assert len(cl_pes) == 16
    assert cl_pes[0][0] == frozenset([ Matches(c,   App(S,     c  )) , Matches(c,   App(S,     c1 )) , Matches(c1,  App(S,     c  )) , Matches(c1,  App(S, c1 ))])
    assert cl_pes[1][0] == frozenset([ Matches(c,   App(S,     c  )) , Matches(c,   App(S,     c1 )) , Matches(c1,  App(S,     c  )) , Matches(c1, DApp(S, Not(c1)))])
    assert cl_pes[2][0] == frozenset([ Matches(c,   App(S,     c  )) , Matches(c,   App(S,     c1 )) , Matches(c1, DApp(S, Not(c ))) , Matches(c1,  App(S, c1 ))])

    cl_pes = complete_closures_for_signature([(frozenset(), [])], frozenset({c, c1}), [], {S : 1, C : 0}, [])
    assert len(cl_pes) == 64
    for (cl, pe) in cl_pes:
        assert len(cl) == 6

    cl_pes = complete_closures_for_signature([(frozenset([Matches(c, DApp(S, c1))]), [])], frozenset({c, c1}), [], {S : 1, C : 0}, [])
    assert len(cl_pes) == 64
    for (cl, pe) in cl_pes:
        assert len(cl) == 7

    cl_pes = complete_closures_for_signature([(frozenset([Matches(c, DApp(S, Not(c1)))]), [])], frozenset({c, c1}), [], {S : 1, C : 0}, [])
    assert len(cl_pes) == 32
    for (cl, pe) in cl_pes:
        assert len(cl) == 6

    from typing import FrozenSet, Tuple
    closures : List[Tuple[FrozenSet[Assertion], List[Tuple[Assertion, Assertion]]]] \
             = [( frozenset({ExistsAssertion(frozenset({c}), AllOf(frozenset({Matches(c1, App(S, c)), Matches(c, App(C))}))),
                             Matches(c1, App(S, c)),
                             Matches(c, App(C)),
                             Matches(c1, App(S, c1)),
                             ExistsAssertion(frozenset({c}), Matches(c, App(S, App(C)))),
                             Matches(c1, App(S, App(C))),
                             Matches(c1, App(C))}
                           )
                , [(AllOf(frozenset({Matches(c1, App(S, c)), Matches(c, App(C))})), Matches(c1, App(S, c))),
                   (Matches(c1, App(S, c)), Matches(c1, App(S, c))),
                   (AllOf(frozenset({Matches(c1, App(S, c)), Matches(c, App(C))})), Matches(c, App(C))),
                   (Matches(c, App(C)), Matches(c, App(C)))]
                )]
    cl_pes = complete_closures_for_signature(closures, frozenset({c, c1}), [], {S : 1, C : 0}, [])
    for (cl, pe) in cl_pes:
        apps  = [a for a in cl if isinstance(a, Matches) and isinstance(a.pattern, App) and is_atomic_application(a.pattern)]
        dapps = [a for a in cl if isinstance(a, Matches) and isinstance(a.pattern, DApp) and is_atomic_application(a.pattern.negate())]
        assert len(apps) + len(dapps) == 6

def test_instantiations() -> None:
    assert list(instantiations(0, frozenset(), frozenset(), [c1]))     == [()]
    assert list(instantiations(1, frozenset(), frozenset(), [c1]))     == [(c1,)]
    assert list(instantiations(1, frozenset(), frozenset(), [c1, c2])) == [(c1,)]

    assert list(instantiations(1, frozenset([c, c1]), frozenset([c, c1, c2]), [c, c1, c2, c3, c4, c5])) \
        == [ (c,), (c1,), (c3,) ]

    # TODO: Do we need to be more particular about the order?
    assert set(instantiations(2, frozenset([c, c1]), frozenset([c, c1, c2]), [c, c1, c2, c3, c4, c5])) \
        == { (c, c), (c, c1), (c1, c), (c1, c1)             # 0 vars from available
           , (c, c3), (c1, c3), (c3, c), (c3, c1), (c3, c3) # 1 var  from available
           , (c3, c4)                                       # 2 vars from available
           }
    assert set(instantiations(3, frozenset([c, c1]), frozenset([c, c1, c2]), [c, c1, c2, c3, c4, c5])) \
        == { # 0 vars from available
             (c, c, c),   (c, c, c1),   (c, c1, c),  (c, c, c1),   (c, c1, c1)
           , (c1, c, c),  (c1, c, c1),  (c1, c1, c), (c1, c, c1),  (c1, c1, c1)
             # 1 var  from available
           , (c, c, c3),  (c, c1, c3),  (c, c3, c),  (c, c3, c1),  (c, c3, c3)
           , (c1, c, c3), (c1, c1, c3), (c1, c3, c), (c1, c3, c1), (c1, c3, c3)
           , (c3, c, c),  (c3, c, c1),  (c3, c1, c), (c3, c, c1),  (c3, c1, c1)
           , (c3, c, c3), (c3, c1, c3), (c3, c3, c), (c3, c3, c1), (c3, c3, c3)
             # 2 vars from available
           , (c,  c3, c4), (c1, c3, c4), (c3, c,  c4)
           , (c3, c1, c4), (c3, c4, c,), (c3, c4, c1)
           , (c3, c4, c3), (c3, c3, c4), (c3, c4, c4)
             # 3 vars from available
           , (c3, c4, c5)
           }

    # Width of pattern higher than available variables.
    from pytest import raises
    with raises(Exception): list(instantiations(1, frozenset(),    frozenset(),  [ ]))
    with raises(Exception): list(instantiations(1, frozenset(),    frozenset([c]), [c]))
    with raises(Exception): list(instantiations(1, frozenset([c]), frozenset([c]), [c]))

def test_add_to_closure() -> None:
    K = [c, c1, c2, c3, c4]
    def_list : DefList = []
    signature = { S : 1, C : 0 }

    assertion = Matches(c, Bottom())
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    assert cl_pes == []

    assertion = Matches(c, Top())
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    assert cl_pes == [(frozenset(), [(assertion, assertion)])]

    assertion = Matches(c, c1)
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    assert cl_pes == []

    assertion = Matches(c, c)
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    assert cl_pes == [(frozenset([Matches(c, c)]), [(assertion, assertion)])]

    assertion = Matches(c, App(C))
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    assert cl_pes == [ (frozenset({assertion}), [(assertion, assertion)]) ]

    assertion = Matches(c, App(S, c))
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    assert cl_pes == [ (frozenset({assertion}), [(assertion, assertion)]) ]

    assertion = Matches(c, DApp(C))
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    assert cl_pes == [ (frozenset({assertion}), [(assertion, assertion)]) ]

    assertion = Matches(c, DApp(S, Not(c)))
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    assert cl_pes == [ (frozenset({assertion}), [(assertion, assertion)]) ]

    assertion = Matches(c, And(App(C), DApp(C)))
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    assert cl_pes == []

    assertion = Matches(c, And(App(C), DApp(S, Not(c))))
    left  = Matches(c, App(C))
    right = Matches(c, DApp(S, Not(c)))
    all_of = AllOf(frozenset([left, right]))
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    assert cl_pes == [( frozenset({left, right})
                      , [ (assertion,  all_of)
                        , (all_of,     left)
                        , (left,       left)
                        , (all_of,     right)
                        , (right,      right)
                        ]
                      )]

    assertion = Matches(c, Or(App(C), DApp(C)))
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    left = Matches(c, App(C))
    right = Matches(c, DApp(C))
    any_of = AnyOf(frozenset([left, right]))
    assert cl_pes == [ (frozenset({right}), [ (assertion, any_of)
                                              , (any_of, right)
                                              , (right, right)
                                              ])
                     , (frozenset({left}), [ (assertion, any_of)
                                              , (any_of, left)
                                              , (left, left)
                                              ])
                     ]


    assertion = Matches(c, App(S, App(C)))
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    exists_assertion = ExistsAssertion( frozenset([c1])
                                      , AllOf(frozenset([Matches(c, App(S, c1)), Matches(c1, App(C))]))
                                      )
    assert cl_pes == [(frozenset({exists_assertion}), [(assertion, exists_assertion), (exists_assertion, exists_assertion)])]

    assertion = Matches(c, DApp(S, DApp(C)))
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    uninstatiated_match_1 = Matches(c, DApp(S, Not(c1)))
    uninstatiated_match_2 = Matches(c1, DApp(C))
    uninstatiated_any_of = AnyOf(frozenset([uninstatiated_match_1, uninstatiated_match_2]))
    forall_assertion = ForallAssertion(frozenset([c1]), uninstatiated_any_of)
    any_of = uninstatiated_any_of.substitute(c1, c)
    match_1 = uninstatiated_match_1.substitute(c1, c)
    match_2 = uninstatiated_match_2.substitute(c1, c)
    assert cl_pes == [ (frozenset({forall_assertion, match_2})
                       , [(assertion, forall_assertion), (forall_assertion, forall_assertion), (forall_assertion, any_of), (any_of, match_2), (match_2, match_2)])
                     , (frozenset({forall_assertion, match_1})
                       , [(assertion, forall_assertion), (forall_assertion, forall_assertion), (forall_assertion, any_of), (any_of, match_1), (match_1, match_1)])
                     ]

    assertion = Matches(c, And(App(S, App(C)), DApp(S, DApp(C))))
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    # TODO: Complete me

    assertion = Matches(c, Nu(X, X))
    def_list = definition_list(assertion.pattern, [])
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    unfolded = Matches(c, Not(SVar(0)))
    assert cl_pes == [( frozenset()
                      , [ (assertion, unfolded)
                        , (unfolded, assertion)
                        ]
                      )]

    assertion = Matches(c, Nu(X, App(S, X)))
    def_list = definition_list(assertion.pattern, [])
    cl_pes = add_to_closure(assertion, frozenset(), [], assertion.free_evars(), K, def_list)
    unfolded = Matches(c, App(S, Not(SVar(0))))
    exists_assertion = ExistsAssertion(frozenset([c1]), AllOf(frozenset([Matches(c, App(S, c1)), Matches(c1, Not(SVar(0)))])))
    assert cl_pes == [( frozenset([exists_assertion])
                      , [(assertion, unfolded), (unfolded, exists_assertion), (exists_assertion, exists_assertion)]
                      )]
    cl_pes = instantiate_universals(cl_pes, assertion.free_evars(), K, def_list)
    cl_pes = complete_closures_for_signature(cl_pes, frozenset([c, c1]), K, signature, def_list)
    games = build_games(cl_pes, {})
 
signature = {C: 0, S: 1}

def commentid(args:Tuple[str, bool, Pattern, List[EVar], Dict[Symbol, int]]) -> str:
    comment, sat, pat, consts, sig  = args
    return comment

@pytest.mark.parametrize('args', [
    # Basic
    ('bottom',          False,  Bottom(),                    [c, c1], signature),
    ('top',             True,   Top(),                       [c, c1], signature),

    # App/And
    ('app',             True,   App(C),                      [c, c1], signature),
    ('dapp',            True,   DApp(C),                     [c, c1], signature),
    ('app and neg',     False,  And(App(C),DApp(C)),         [c, c1], signature),
    ('app and neg 2',   True,   And(App(D), Not(App(C))),    [c, c1], {C: 0, D: 0}),

    ('app-nested',      True,   App(S, App(C)),              [c, c1, c2, c3], signature),
    ('app-nested-neg',  False,  And( App(S, App(C))
                                   , DApp(S, DApp(C))),      [c, c1, c2, c3], signature),

    ('non-normal-form', True,   DApp(S, Not(App(C))),        [c, c1, c2, c3], signature),
    ('non-normal-form', False,  And(App(C), Not(App(C))),    [c, c1, c2, c3], signature),
    ('non-normal-form', False,  And( App(S, App(C))
                                   , DApp(S, Not(App(C)))),  [c, c1, c2, c3], signature),

    # App/Or
    ('or',              True,   Or(App(C), Not(App(C))),     [c, c1, c2, c3], signature),
    ('or-app-nested',   True,   Or( App(S, App(C))
                                  , DApp(S, Not(App(C)))),   [c, c1, c2, c3], signature),
    ('or-unsat',        False,  Or( And(App(C), Not(App(C)))
                                  , And(App(C), Not(App(C)))
                                  ),                         [c, c1], signature),

    # Fixed points
    ('nu-top',          True,   Nu(X, X), [c, c1], signature),
    ('mu-bot',          False,  Mu(X, X), [c, c1], signature),

    ('eventually-c',    True,   Mu(X,  Or(X,  App(C))), [c, c1], signature),
    ('always-not-c',    True,   Nu(X, And(X, DApp(C))), [c, c1], signature),
    ('Ec-and-A-not-c',  False,  And( Nu(X, And(X, DApp(C)))
                                   , Mu(X,  Or(X, App(C)))), [c, c1], signature),

    ('nu-or-app',       True,   Nu(X, Or(X,  App(C))),  [c, c1], signature),
    ('mu-and-dapp',     False,  Mu(X, And(X, DApp(C))), [c, c1], signature),

    ('nu-mu',           False,  Nu(X, Mu(X, X)), [c, c1], signature),
    ('mu-nu',           True,   Mu(X, Nu(X, X)), [c, c1], signature),

    ('nu-mu-and',       False,  Nu(X, Mu(Y, And(X, Y))), [c, c1], signature),

    ('mu-and-nu',       False,  Mu(X, And(X, Nu(X, X))), [c, c1], signature),
    ('mu-or-nu',        True,   Mu(X,  Or(X, Nu(X, X))), [c, c1], signature),

    ('nu-and-dapp',     True,   Nu(X, And(X, DApp(C))), [c, c1], signature),
    ('nu-and-dapp-app', True,   Nu(X, And(X, DApp(S, App(C)))), [c, c1], signature),

    ('nu-app',          True,   Nu(X, App(S, X)), [c, c1, c2, c3], { S : 1 }),
    ('fp-1',            False,  And( Nu(X, And(App(C), App(S, X)))
                                   , DApp(S, Not(App(C)))
                                   ), [c, c1, c2, c3], signature),

], ids=commentid)
def test_is_sat(args:Tuple[str, bool, Pattern, List[EVar], Dict[Symbol, int]]) -> None:
    comment, sat, pattern, consts, sig = args
    assert sat is is_sat(pattern, consts, sig)


#    assert not is_sat(Mu(X, App(S, X))
#                     , [c, c1, c2, c3], signature)
#
#    assert     is_sat(Nu(X, And( Mu(Y, Or(App(C), App(S , Y)) )
#                                       , App(S , X)
#                                       ))
#                     , [c, c1, c2, c3], signature)
#    assert not is_sat(Mu(X, And( Nu(Y, Or( App(C), App(S , Y)) )
#                                         , App(S , X)
#                                         ))
#                     , [c, c1, c2, c3], signature)

# def test_is_satisfiable_existential_only() -> None:
#     assert not is_sat(Exists(frozenset(c), And(EVar('c'), Not(EVar('c')))), [c, c1], signature)
#     assert not is_sat(Exists(frozenset(c), And(Not(EVar('c')), EVar('c'))), [c, c1], signature)
