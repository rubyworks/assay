## CompareAssay

The `CompareAssay` class defines an assertion of comparison around the `#<=>`
method. Since `#<=>` can return either a `1`, `0` or `-1`, an extra criterion
is needed when making testing the assertion.

    assert CompareAssay.pass?(1, 1,  0)
    assert CompareAssay.pass?(1, 2, -1)
    assert CompareAssay.pass?(2, 1,  1)

    refute CompareAssay.pass?(1, 1,  1)
    refute CompareAssay.pass?(1, 1, -1)

    refute CompareAssay.pass?(1, 'foo', 0)

And conversely,

    assert CompareAssay.fail?(1, 1,  1)
    assert CompareAssay.fail?(1, 1, -1)

    refute CompareAssay.fail?(1, 1,  0)
    refute CompareAssay.fail?(1, 2, -1)
    refute CompareAssay.fail?(2, 1,  1)

