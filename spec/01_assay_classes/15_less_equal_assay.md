## LessEqualAssay

The `LessEqualAssay` class defines an assertion of comparison around the `#<=`
method. This method usually depends on the `#<=>` method via Ruby's Comparable
mixin, so `LessEqualAssay` is a subclass of `ComapreAssay`, though techincally
the `#<=` method can be defined indenpendently.

    assert LessEqualAssay.pass?( 1, 2)
    assert LessEqualAssay.pass?(-1, 0)
    assert LessEqualAssay.pass?( 1, 1)

    refute LessEqualAssay.pass?(1, 0)

And conversely,

    assert LessEqualAssay.fail?(1, 0)

    refute LessEqualAssay.fail?( 1, 1)
    refute LessEqualAssay.fail?( 1, 2)
    refute LessEqualAssay.fail?(-1, 0)

This applies to any type of object that defines `#<=`, not just numbers.

    assert LessEqualAssay.pass?('a', 'b')
    refute LessEqualAssay.pass?('b', 'a')

    assert LessEqualAssay.fail?('b', 'a')
    refute LessEqualAssay.fail?('a', 'b')

