## ThrowAssay

The `ThrowAssay` asserts that a procedure will call `throw` and optionally
of a specific type.

    assert ThrowAssay.pass?(:foo){ throw :foo }

    refute ThrowAssay.pass?(:foo){ throw :bar }

And conversely,

    assert ThrowAssay.fail?(:foo){ throw :bar }

    refute ThrowAssay.fail?(:foo){ throw :foo }

