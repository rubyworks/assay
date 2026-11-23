## Methods Every Object Has

    require 'assay/fluidity'

Some query methods belong to every object: `kind_of?`, `instance_of?`,
`nil?`, `eql?`, `equal?`, `respond_to?`, `is_a?`, `frozen?`. Used in an
assertion they are still about the object under test, so they pass and
fail like any other.

    10.assert.kind_of?(Integer)
    10.should.be.kind_of?(Integer)
    10.must.be.an.instance_of?(Integer)
    nil.should.be.nil?
    10.assert.eql?(10)
    10.assert.respond_to?(:succ)
    10.assert.is_a?(Numeric)
    :a.assert.equal?(:a)
    "abc".freeze.assert.frozen?

Each of these fails when it should. Where an Assay class covers the
method, the failure is of that class.

    RaiseAssay.assert!(KindAssay) do
      10.assert.kind_of?(String)
    end

    RaiseAssay.assert!(KindAssay) do
      10.should.be.kind_of?(String)
    end

    RaiseAssay.assert!(InstanceAssay) do
      10.must.be.an.instance_of?(Numeric)
    end

    RaiseAssay.assert!(NilAssay) do
      10.should.be.nil?
    end

    RaiseAssay.assert!(EqualityAssay) do
      10.assert.eql?(10.0)
    end

    RaiseAssay.assert!(RespondAssay) do
      10.assert.respond_to?(:upcase)
    end

Where none does, the object's own method decides, and the failure is a
plain Assertion.

    RaiseAssay.assert!(Assertion) do
      10.assert.is_a?(String)
    end

    RaiseAssay.assert!(Assertion) do
      "abc".assert.equal?("abc".dup)
    end

    RaiseAssay.assert!(Assertion) do
      "abc".dup.assert.frozen?
    end

The same goes for negation.

    10.should_not.be.kind_of?(String)
    10.assert.not.nil?

    RaiseAssay.assert!(KindAssay) do
      10.should_not.be.kind_of?(Integer)
    end

    RaiseAssay.assert!(NilAssay) do
      nil.assert.not.nil?
    end

The `!=` operator is the opposite of `==`.

    10.assert != 11

    RaiseAssay.assert!(UnequalAssay) do
      10.assert != 10
    end

Keyword arguments are passed along to the object's method.

    gate = Class.new do
      def open?(strict: false)
        !strict
      end
    end

    gate.new.should.be.open?(strict: false)

    RaiseAssay.assert!(Assertion) do
      gate.new.should.be.open?(strict: true)
    end

A method the object doesn't have is an error, not an assertion.

    RaiseAssay.assert!(NoMethodError) do
      10.assert.zork
    end

