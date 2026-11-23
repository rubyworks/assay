## Grammer

    require 'assay/fluidity/assert'

Now we have a fluent notation with which to make assertions.

    true.assert.true
    false.assert.false

    (5 + 5).must.equal 10

    [1,2,3].must.include(2)

We can also use the associated operator (Ruby's built-in query method name).

    false.assert.false?
    true.assert.true?

    (5 + 5).assert == 10

    (9 + 9).assert.not == 10

    12.assert.kind_of?(Integer)

As is `not` for negation.

    12.assert.not.equal(20)

Or `should_not` can also be used.

    12.should_not.equal(20)

We must also make sure such assertions can fail. Since #assert is special
method to assay classes, we can use it as on these as part of our test
grmmer. So we use the raw `#assert!` method to handle the test.

    RaiseAssay.assert!(IncludeAssay) do
      [1,2,3].assert.include(4)
    end

    RaiseAssay.assert!(FalseAssay) do
      true.assert.false
    end

    RaiseAssay.assert!(EqualAssay) do
      (5 + 5).assert == 11
    end

Matcher notation is also supported, if you have any matcher classes
to use. Assay classes can be converted to matchers, so we can use 
one of those to try this out. 

    is_sixteen = EqualAssay[16.0]

    16.assert is_sixteen


The ordinary form of `assert`, given a truth value, still works as it
does without the fluent notation.

    o = Object.new

    o.instance_eval{ assert(true) }

    RaiseAssay.assert!(RuntimeError) do
      o.instance_eval{ assert(false) }
    end

    RaiseAssay.assert!(RuntimeError) do
      o.instance_eval{ assert(nil) }
    end
