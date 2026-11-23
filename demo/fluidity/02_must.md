## Must

    require 'assay/fluidity/must'

Now we have a fluent notation with which to make assertions.

    true.must.be.true
    false.must.be.false

    (5 + 5).must.equal 10

    [1,2,3].must.include(2)

We can also use the associated operator (Ruby's built-in query method name).

    false.must.be.false?
    true.must.be.true?

    (5 + 5).must == 10

Indefinite article `a` and `an` are suppored.

    12.must.be.a.kind_of?(Integer)

    12.must.be.an.instance_of?(Integer)

As is `not` for negation.

    12.must.not.equal(20)

Or `must_not` can also be used.

    12.must_not.equal(20)

We must also make sure such assertions can fail.

    IncludeAssay.must.be.raised do
      [1,2,3].must.include(4)
    end

    FalseAssay.must.be.raised do
      true.must.be.false
    end

    EqualAssay.must.be.raised do
      (5 + 5).must == 11
    end

Matcher notation is also supported, if you have any matcher classes
to use. Assay classes can be converted to matchers, so we can use 
one of those to try this out. 

    be_sixteen = EqualAssay[16.0]

    16.must be_sixteen

    15.must_not be_sixteen

