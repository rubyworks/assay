## ExecutionAssay

The `ExecutionAssay` asserts that a procedure runs without error and returns
a result other than `false` or `nil`. It is not particularly useful, because
what it does is effectively what testing in itself does. So it is rather
redundant. However, it serves as the base class for more specific execution
assertions, such as the `RaiseAssay` and `ThrowAssay`.

    assert ExecutionAssay.pass?{ true }
    assert ExecutionAssay.pass?{ :foo }

    refute ExecutionAssay.pass?{ nil }
    refute ExecutionAssay.pass?{ false }
    refute ExecutionAssay.pass?{ raise }

And conversely,

    assert ExecutionAssay.fail?{ raise }
    assert ExecutionAssay.fail?{ nil }
    assert ExecutionAssay.fail?{ false }

    refute ExecutionAssay.fail?{ true }
    refute ExecutionAssay.fail?{ :foo }

Making assertions,

    assert ExecutionAssay.assert!{ true }

    expect ::ExecutionAssay do
      assert ExecutionAssay.assert!{ false }
    end

And refutations,

    assert ExecutionAssay.refute!{ false }

    expect ::ExecutionAssay do
      assert ExecutionAssay.refute!{ true }
    end

