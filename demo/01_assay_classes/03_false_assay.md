## FalseAssay

The `FalseAssay` class asserts that an object is `false.
Reference to any other object will fail.

    assert FalseAssay.pass?(false)

    refute FalseAssay.pass?(true)
    refute FalseAssay.pass?(nil)
    refute FalseAssay.pass?('foo')

And conversely,

    assert FalseAssay.fail?(true)
    assert FalseAssay.fail?(nil)
    assert FalseAssay.fail?('foo')

    refute FalseAssay.fail?(false)

