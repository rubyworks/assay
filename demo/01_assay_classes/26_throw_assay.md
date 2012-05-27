## ThrowAssay

The `ThrowAssay` asserts that a procedure will call `throw` and optionally
of a specific type.

    assert ThrowAssay.pass?(:foo){ throw :foo }
    refute ThrowAssay.pass?(:foo){ throw :bar }

And conversely,

    assert ThrowAssay.fail?(:foo){ throw :bar }
    refute ThrowAssay.fail?(:foo){ throw :foo }

In addition `ThrowAssay` can assert that there is a throw, regardless
of tag.

    assert ThrowAssay.pass?{ throw :foo }
    refute ThrowAssay.pass?{ nil }

And converselry,

    assert ThrowAssay.fail?{ nil }
    refute ThrowAssay.fail?{ throw :bar }

Making assertions, notice that the `#assert!` method requires a `nil`
argument in order to test for any throw. This is not needed on the 
`#pass?` method because the `#pass` method can't take aditional options
for setting the message or backtrace.

    assert ThrowAssay.assert!(nil){ throw :foo }

    assert ThrowAssay.assert!(nil, :message=>"optional message"){
      throw :foo
    }

    expect ThrowAssay do
      ThrowAssay.assert!(nil){ 'nothing' }
    end

And refutations,

    assert ThrowAssay.refute!(:foo){ throw :bar }

    expect ThrowAssay do
      ThrowAssay.refute!(:foo){ throw :foo }
    end

