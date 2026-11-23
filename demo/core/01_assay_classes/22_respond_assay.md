## RespondAssay

The `RespondAssay` asserts if a an object responds to a message using
then `#respond_to?` method.

    assert RespondAssay.pass?('a', :to_s)

    refute RespondAssay.pass?('a', :foo)

And conversely,

    assert RespondAssay.fail?('a', :foo)

    refute RespondAssay.fail?('a', :to_s)

