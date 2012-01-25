## RaiseAssay

The `RaiseAssay` asserts that a procedure will raise a specific error.

    assert RaiseAssay.pass?{ raise Exception }
    assert RaiseAssay.pass?(StandardError){ raise }
    assert RaiseAssay.pass?(ArgumentError){ raise ArgumentError }

    refute RaiseAssay.pass?(StandardError){ nil }
    refute RaiseAssay.pass?(ArgumentError){ raise }

And conversely,

    assert RaiseAssay.fail?(StandardError){ nil }
    assert RaiseAssay.fail?(ArgumentError){ raise }

    refute RaiseAssay.fail?{ raise Exception }
    refute RaiseAssay.fail?(StandardError){ raise }
    refute RaiseAssay.fail?(ArgumentError){ raise ArgumentError }

Making assertions,

    assert RaiseAssay.assert!(StandardError){ raise }

    expect ::RaiseAssay do
      RaiseAssay.assert!(StandardError){ nil }
    end

And refutations,

    assert RaiseAssay.refute!(StandardError){ nil }

    expect ::RaiseAssay do
      RaiseAssay.refute!(StandardError){ raise }
    end

