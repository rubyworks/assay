## RaiseAssay

The `RaiseAssay` asserts that a procedure will raise a specific error.

    assert RaiseAssay.pass?{ raise }
    assert RaiseAssay.pass?(RuntimeError){ raise }
    assert RaiseAssay.pass?(ArgumentError){ raise ArgumentError }

    refute RaiseAssay.pass?{ raise Exception }
    refute RaiseAssay.pass?(Exception){ raise ArgumentError }
    refute RaiseAssay.pass?(StandardError){ nil }
    refute RaiseAssay.pass?(ArgumentError){ raise }

And conversely,

    assert RaiseAssay.fail?{ raise Exception }
    assert RaiseAssay.fail?(RuntimeError){ nil }
    assert RaiseAssay.fail?(ArgumentError){ raise }
    assert RaiseAssay.fail?(Exception){ raise ArgumentError }

    refute RaiseAssay.fail?{ raise }
    refute RaiseAssay.fail?(RuntimeError){ raise }
    refute RaiseAssay.fail?(ArgumentError){ raise ArgumentError }

Making assertions,

    assert RaiseAssay.assert!(RuntimeError){ raise }

    expect ::RaiseAssay do
      RaiseAssay.assert!(RuntimeError){ nil }
    end

And refutations,

    assert RaiseAssay.refute!(RuntimeError){ nil }

    expect ::RaiseAssay do
      RaiseAssay.refute!(RuntimeError){ raise }
    end

