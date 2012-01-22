## NoMatchAssay

The `NoMatchAssay` class defines an assertion for matching using the `#!~`
method. As of Ruby 1.9, the `#!~` method is redefinable independent of `#=~`,
so a separate assertion class is needed to cover it.

    assert NoMatchAssay.pass?('a', /b/)

    refute NoMatchAssay.pass?('a', /a/)

And conversely,

    assert NoMatchAssay.fail?('a', /a/)

    refute NoMatchAssay.fail?('a', /b/)

