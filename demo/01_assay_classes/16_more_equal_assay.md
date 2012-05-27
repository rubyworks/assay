## MoreEqualAssay

The `MoreEqualAssay` class defines an assertion of comparison around the `#>=`
method. This method usually depends on the `#<=>` method via Ruby's Comparable
mixin, so `MoreEqualAssay` is a subclass of `ComapreAssay`, though techincally
the `#>=` method can be defined indenpendently.

    assert MoreEqualAssay.pass?(2,  1)
    assert MoreEqualAssay.pass?(0, -1)
    assert MoreEqualAssay.pass?(1,  1)

    refute MoreEqualAssay.pass?(0, 1)

And conversely,

    assert MoreEqualAssay.fail?(0, 1)

    refute MoreEqualAssay.fail?( 1, 1)
    refute MoreEqualAssay.fail?( 2, 1)
    refute MoreEqualAssay.fail?( 0, -1)

This applies to any type of object that defines `#<=`, not just numbers.

    assert MoreEqualAssay.pass?('b', 'a')
    refute MoreEqualAssay.pass?('a', 'b')

    assert MoreEqualAssay.fail?('a', 'b')
    refute MoreEqualAssay.fail?('b', 'a')

