## MoreAssay

The `MoreAssay` class defines an assertion of comparison around the `#>`
method. This method usually depends on the `#<=>` method via Ruby's Comparable
mixin, so `MoreAssay` is a subclass of `ComapreAssay`, though techincally
the `#>` method can be defined indenpendently.

    assert MoreAssay.pass?(2,  1)
    assert MoreAssay.pass?(0, -1)
    assert MoreAssay.pass?(1,  0)

    refute MoreAssay.pass?(1, 1)
    refute MoreAssay.pass?(1, 2)

And conversely,

    assert MoreAssay.fail?(1, 1)
    assert MoreAssay.fail?(0, 1)

    refute MoreAssay.fail?(2,  1)
    refute MoreAssay.fail?(0, -1)

This applies to any type of object that defines `#>`, not just numbers.

    assert MoreAssay.pass?('b', 'a')
    refute MoreAssay.pass?('a', 'b')

    assert MoreAssay.fail?('a', 'b')
    refute MoreAssay.fail?('b', 'a')
