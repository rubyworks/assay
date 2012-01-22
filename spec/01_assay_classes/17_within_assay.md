## WithinAssay

The `WithinAssay` class defines an assertion for matching that two values
lie with a range.

    assert WithinAssay.pass?(1, 1,   0)
    assert WithinAssay.pass?(1, 1.1, 0.1)

    refute WithinAssay.pass?(1, 2,   0)
    refute WithinAssay.pass?(1, 1.2, 0.1)

And conversely,

    assert WithinAssay.fail?(1, 2,   0)
    assert WithinAssay.fail?(1, 1.2, 0.1)

    refute WithinAssay.fail?(1, 1,   0)
    refute WithinAssay.fail?(1, 1.1, 0.1)

