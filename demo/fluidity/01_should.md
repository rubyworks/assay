## Should

    require 'assay/fluidity/should'

Now we have a fluent notation with which to make assertions.

    true.should.be.true
    false.should.be.false

    (5 + 5).should.equal 10

    [1,2,3].should.include(2)

We can also use the associated operator (Ruby's built-in query method name).

    false.should.be.false?
    true.should.be.true?

    (5 + 5).should == 10

Indefinite article `a` and `an` are suppored.

    12.should.be.a.kind_of?(Integer)

As is `not` for negation.

    12.should.not.equal(20)

We should also make sure such assertions can fail.

    IncludeAssay.should.be.raised do
      [1,2,3].should.include(4)
    end

    FalseAssay.should.be.raised do
      true.should.be.false
    end

    EqualAssay.should.be.raised do
      (5 + 5).should == 11
    end

Matcher notation is also supported, if you have any matcher classes
to use. Assay classes can be converted to matchers, so we can use 
one of those to try this out. 

    be_sixteen = EqualAssay[16.0]

    16.should be_sixteen

    15.should_not be_sixteen

