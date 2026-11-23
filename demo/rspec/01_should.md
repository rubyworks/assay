## RSpec Should Method

### should

Becuase the `#should` method used `=~` as the assertion operator,
you can do something a bit unexpected, such as,

    'a'.should /a/

### should=

As a shortcut one can also use the `#should=` method instead of
the usual two-step `should ==` call.

    10.should = 10

    assert_raises ::EqualAssay do
      10.should = 20
    end

The same is true for `#should_not`.

    10.should_not = 20

