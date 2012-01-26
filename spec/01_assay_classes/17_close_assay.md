## CloseAssay

The `CloseAssay` class defines an assertion for matching that two values
are within a relative difference.

    assert CloseAssay.pass?(1, 1,   0)
    assert CloseAssay.pass?(1, 1.1, 0.1)

    refute CloseAssay.pass?(1, 2,   0)
    refute CloseAssay.pass?(1, 1.2, 0.1)

And conversely,

    assert CloseAssay.fail?(1, 2,   0)
    assert CloseAssay.fail?(1, 1.2, 0.1)

    refute CloseAssay.fail?(1, 1,   0)
    refute CloseAssay.fail?(1, 1.1, 0.1)

The object do not have to be numbers necessaity, just so long as they
are comparable and subtractable.

    time = Time.now

    assert CloseAssay.pass?(time, time+1, 2)

Making assertions,

    assert CloseAssay.assert!(10, 11, 1)

    expect ::CloseAssay do
      CloseAssay.assert!(10, 15, 0.25)
    end

And refutations,

    assert CloseAssay.refute!(10, 11, 0.01)

    expect ::CloseAssay do
      CloseAssay.refute!(10, 11, 1)
    end

