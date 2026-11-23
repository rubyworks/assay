## LikeAssay

The `LikeAssay` is a very ... assertion. It is a comparison that
evaluates to true for any of Ruby's many "equal" operators, `equal?`
(same as `identical?`), `eql?`, `==`, `===` and `=~`. If any one
of these evaluates to true, than two objects can be said to be alike.

    assert LikeAssay.pass?(1, 1)
    assert LikeAssay.pass?(1, 1.0)
    assert LikeAssay.pass?("1", /\d/)

    refute LikeAssay.pass?(1, "1")
    refute LikeAssay.pass?("1", /\D/)

And conversely,

    assert LikeAssay.fail?(1, "1")
    assert LikeAssay.fail?("1", /\D/)

