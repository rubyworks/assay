## EmptyAssay

The `EmptyAssay` asserts that a collection includes no members, using the 
`#empty?` method.

    assert EmptyAssay.pass?([])

    refute EmptyAssay.pass?([1])

And conversely,

    assert EmptyAssay.fail?([1])

    refute EmptyAssay.fail?([])

