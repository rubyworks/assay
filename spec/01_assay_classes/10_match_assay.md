## MatchAssay

The `MatchAssay` class defines an assertion for matching using the `#=~`
method.

    assert MatchAssay.pass?('a', /a/)

    refute MatchAssay.pass?('a', /b/)

And conversely,

    assert MatchAssay.fail?('a', /b/)

    refute MatchAssay.fail?('a', /a/)

