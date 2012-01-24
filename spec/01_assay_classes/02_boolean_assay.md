## BooleanAssay

The `BooleanAssay` asserts that an object reference is `nil`.
Reference to any other object will fail.

    assert BooleanAssay.pass?(true)
    assert BooleanAssay.pass?(false)

    refute BooleanAssay.pass?(nil)
    refute BooleanAssay.pass?("foo")

And conversely,

    assert BooleanAssay.fail?(nil)
    assert BooleanAssay.fail?("foo")

    refute BooleanAssay.fail?(true)
    refute BooleanAssay.fail?(false)

Making assertions,

    assert BooleanAssay.assert!(true)

    expect ::BooleanAssay do
      BooleanAssay.assert!(nil)
    end

And refutations,

    assert BooleanAssay.refute!(nil)

    expect ::BooleanAssay do
      BooleanAssay.refute!(true)
    end

