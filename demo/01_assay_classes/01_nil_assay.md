## NilAssay

The `NilAssay` asserts that an object reference is `nil`.
Reference to any other object will fail.

    assert NilAssay.pass?(nil)

    refute NilAssay.pass?(true)
    refute NilAssay.pass?(false)
    refute NilAssay.pass?("foo")

And conversely,

    assert NilAssay.fail?(true)
    assert NilAssay.fail?(false)
    assert NilAssay.fail?("foo")

    refute NilAssay.fail?(nil)

Making assertions,

    assert NilAssay.assert!(nil)

    expect ::NilAssay do
      NilAssay.assert!(true)
    end

And refutations,

    assert NilAssay.refute!(true)

    expect ::NilAssay do
      NilAssay.refute!(nil)
    end

