## IncludeAssay

The `IncludeAssay` asserts that a collection includes a specific member, using
the `#include?` method.

    assert IncludeAssay.pass?([1], 1)

    refute IncludeAssay.pass?([],  1)
    refute IncludeAssay.pass?([2], 1)

And conversely,

    assert IncludeAssay.fail?([],  1)
    assert IncludeAssay.fail?([2], 1)

    refute IncludeAssay.fail?([1], 1)

