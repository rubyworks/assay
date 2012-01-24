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

The object do not have to be numbers necessaity, just so long as they
are comparable and subtractable.

    time = Time.now

    assert WithinAssay.pass?(time, time+1, 2)

Making assertions,

    assert WithinAssay.assert!(10, 11, 1)

    expect ::WithinAssay do
      WithinAssay.assert!(10, 15, 2)
    end

And refutations,

    assert WithinAssay.refute!(10, 11, 0.1)

    expect ::WithinAssay do
      WithinAssay.refute!(10, 11, 1)
    end

