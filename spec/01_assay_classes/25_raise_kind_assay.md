## RaiseKindAssay

The `RaiseKindAssay` asserts that a procedure will raise a specific error.

    assert RaiseKindAssay.pass?{ raise Exception }
    assert RaiseKindAssay.pass?(StandardError){ raise }
    assert RaiseKindAssay.pass?(ArgumentError){ raise ArgumentError }
    assert RaiseKindAssay.pass?(Exception){ raise ArgumentError }

    refute RaiseKindAssay.pass?(StandardError){ nil }
    refute RaiseKindAssay.pass?(ArgumentError){ raise }

And conversely,

    assert RaiseKindAssay.fail?(StandardError){ nil }
    assert RaiseKindAssay.fail?(ArgumentError){ raise }

    refute RaiseKindAssay.fail?{ raise Exception }
    refute RaiseKindAssay.fail?(StandardError){ raise }
    refute RaiseKindAssay.fail?(ArgumentError){ raise ArgumentError }
    refute RaiseKindAssay.fail?(Exception){ raise ArgumentError }

Making assertions,

    assert RaiseKindAssay.assert!(RuntimeError){ raise }

    expect ::RaiseKindAssay do
      RaiseAssay.assert!(RuntimeError){ nil }
    end

And refutations,

    assert RaiseKindAssay.refute!(RuntimeError){ nil }

    expect ::RaiseKindAssay do
      RaiseAssay.refute!(RuntimeError){ raise }
    end

