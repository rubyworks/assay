## EqualAssay

The `EqualAssay` class defines an assertion for equality based on the `==` method.

    assert EqualAssay.pass?(1, 1)
    assert EqualAssay.pass?(1, 1.0)

    refute EqualAssay.pass?(1, 2)
    refute EqualAssay.pass?(1, 'foo')

And conversely,

    assert EqualAssay.fail?(1, 2)
    assert EqualAssay.fail?(1, 'foo')

    refute EqualAssay.fail?(1, 1)
    refute EqualAssay.fail?(1, 1.0)


