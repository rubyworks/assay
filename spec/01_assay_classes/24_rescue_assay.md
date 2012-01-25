## RescueAssay

The `RescueAssay` asserts that a procedure will raise a specific error.

    assert RescueAssay.pass?{ raise Exception }
    assert RescueAssay.pass?(StandardError){ raise }
    assert RescueAssay.pass?(ArgumentError){ raise ArgumentError }
    assert RescueAssay.pass?(Exception){ raise ArgumentError }

    refute RescueAssay.pass?(StandardError){ nil }
    refute RescueAssay.pass?(ArgumentError){ raise }

And conversely,

    assert RescueAssay.fail?(StandardError){ nil }
    assert RescueAssay.fail?(ArgumentError){ raise }

    refute RescueAssay.fail?{ raise Exception }
    refute RescueAssay.fail?(StandardError){ raise }
    refute RescueAssay.fail?(ArgumentError){ raise ArgumentError }
    refute RescueAssay.fail?(Exception){ raise ArgumentError }

Making assertions,

    assert RescueAssay.assert!(RuntimeError){ raise }

    expect ::RescueAssay do
      RaiseAssay.assert!(RuntimeError){ nil }
    end

And refutations,

    assert RescueAssay.refute!(RuntimeError){ nil }

    expect ::RescueAssay do
      RaiseAssay.refute!(RuntimeError){ raise }
    end

