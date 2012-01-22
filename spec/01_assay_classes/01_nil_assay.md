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


