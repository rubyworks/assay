## EqualityAssay

The `EqualityAssay` class defines an assertion for strict equality via
the `eql?` method.

    assert EqualityAssay.pass?(1, 1)

    refute EqualityAssay.pass?(1, 1.0)
    refute EqualityAssay.pass?(1, 2)
    refute EqualityAssay.pass?(1, 'foo')

And conversely,

    assert EqualityAssay.fail?(1, 2)
    assert EqualityAssay.fail?(1, 1.0)
    assert EqualityAssay.fail?(1, 'foo')

    refute EqualityAssay.fail?(1, 1)

