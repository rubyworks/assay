## LessAssay

The `LessAssay` class defines an assertion of comparison around the `#<`
method. This method usually depends on the `#<=>` method via Ruby's Comparable
mixin, so `LessAssay` is a subclass of `ComapreAssay`, though techincally
the `#<` method can be defined independently.

    assert LessAssay.pass?( 1, 2)
    assert LessAssay.pass?(-1, 0)

    refute LessAssay.pass?(1, 1)
    refute LessAssay.pass?(1, 0)

And conversely,

    assert LessAssay.fail?(1, 1)
    assert LessAssay.fail?(1, 0)

    refute LessAssay.fail?( 1, 2)
    refute LessAssay.fail?(-1, 0)

This applies to any type of object that defines `#<=`, not just numbers.

    assert LessAssay.pass?('a', 'b')
    refute LessAssay.pass?('b', 'a')

    assert LessAssay.fail?('b', 'a')
    refute LessAssay.fail?('a', 'b')

