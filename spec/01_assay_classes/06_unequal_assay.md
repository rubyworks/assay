## UnequalAssay

The `UnequalAssay` class defines an assertion for equality based on the `!=`
method, which in Ruby 1.8 is a redefinable method all it's own.

    assert UnequalAssay.pass?(1, 2)
    assert UnequalAssay.pass?(1, 'foo')

    refute UnequalAssay.pass?(1, 1)
    refute UnequalAssay.pass?(1, 1.0)

And conversely,

    assert UnequalAssay.fail?(1, 1)
    assert UnequalAssay.fail?(1, 1.0)

    refute UnequalAssay.fail?(1, 2)
    refute UnequalAssay.fail?(1, 'foo')

