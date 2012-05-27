## IdentityAssay

The `IdentityAssay` class defines an assertion for identity comparison via
the `#identical?` method, which is an alias for the `#equal?` method.
We have choosen not to use the term `equal` to avoid confusion with the
ordinary `==` type of equality.

    assert IdentityAssay.pass?(1, 1)
    assert IdentityAssay.pass?(:a, :a)

    refute IdentityAssay.pass?('a', 'a')
    refute IdentityAssay.pass?(1, 1.0)
    refute IdentityAssay.pass?(1, 2)
    refute IdentityAssay.pass?(1, 'foo')

And conversely,

    assert IdentityAssay.fail?(1, 2)
    assert IdentityAssay.fail?(1, 1.0)
    assert IdentityAssay.fail?(1, 'foo')
    assert IdentityAssay.fail?('a', 'a')

    refute IdentityAssay.fail?(1, 1)
    refute IdentityAssay.fail?(:a, :a)
