## KindAssay

The `KindAssay` asserts that an object is a class or any ancestor
of that class.

    assert KindAssay.pass?(1, Integer)
    assert KindAssay.pass?(1, Numeric)

    refute KindAssay.pass?(1, String)

And conversely,

    assert KindAssay.fail?(1, String)

    refute KindAssay.fail?(1, Integer)
    refute KindAssay.fail?(1, Numeric)

