## TrueAssay

The `TrueAssay` class asserts that an object is `true`.
Reference to any other object will fail.

    assert TrueAssay.pass?(true)

    refute TrueAssay.pass?(false)
    refute TrueAssay.pass?(nil)
    refute TrueAssay.pass?('foo')

And conversely,

    assert TrueAssay.fail?(false)
    assert TrueAssay.fail?(nil)
    assert TrueAssay.fail?('foo')

    refute TrueAssay.fail?(true)


