## ReturnAssay

The `ReturnAssay` asserts that a procedure runs without error and returns
a specified result.

    assert ReturnAssay.pass?(:foo){ :foo }
    assert ReturnAssay.pass?(true){ true }

    refute ReturnAssay.pass?(:foo){ :bar }
    refute ReturnAssay.pass?(:foo){ true }
    refute ReturnAssay.pass?(:foo){ raise }

And conversely,

    assert ReturnAssay.fail?(:foo){ :bar }
    assert ReturnAssay.fail?(:foo){ true }
    assert ReturnAssay.fail?(:foo){ raise }

    refute ReturnAssay.fail?(:foo){ :foo }
    refute ReturnAssay.fail?(true){ true }

Making assertions,

    assert ReturnAssay.assert!(true){ true }

    expect ::ReturnAssay do
      assert ReturnAssay.assert!(:foo){ :bar }
    end

And refutations,

    assert ReturnAssay.refute!(:foo){ :bar }

    expect ::ReturnAssay do
      assert ReturnAssay.refute!(:foo){ :foo }
    end

