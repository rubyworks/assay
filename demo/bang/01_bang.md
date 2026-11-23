# Bang

Bang turns a query method into an assertion: call it with `!` in place
of `?`. Where Assay has a class for the assertion, that is the failure
raised.

    require 'assay/bang'

## true!

    true.true!

    expect ::TrueAssay do
      false.true!
    end

    false.not_true!

## false!

    false.false!

    expect ::FalseAssay do
      true.false!
    end

    true.not_false!

## nil!

    nil.nil!

    expect ::NilAssay do
      true.nil!
    end

    true.not_nil!

## equal!

    1.equal!(1)

    expect ::EqualAssay do
      1.equal!(2)
    end

    1.not_equal!(2)

## eql!

    1.eql!(1)

    expect ::EqualityAssay do
      1.eql!(1.0)
    end

    1.not_eql!(1.0)

## identical!

Ruby's built-in query method for this is `#equal?`, but obviously that conflicts
with our use of `#equal!` to test equality using `#==`. So instead we use `#identical!`
which makes more sense really.

    :a.identical!(:a)

    expect ::IdentityAssay do
      "a".identical!("a")
    end

    :a.not_identical!('a')

## instance_of!

    1.instance_of!(Integer)

    expect ::InstanceAssay do
      1.instance_of!(String)
    end

    1.not_instance_of!(String)

## kind_of!

    1.kind_of!(Integer)

    expect ::KindAssay do
      1.kind_of!(String)
    end

    1.not_kind_of!(String)

## within!

    1.within!(2, 1.5)

    expect ::WithinAssay do
      1.within!(2, 0.5)
    end

    1.not_within!(2, 0.5)

## close!

    1.close!(2, 1.5)

    expect ::CloseAssay do
      1.close!(5, 0.5)
    end

    1.not_close!(5, 0.5)

## match!

    "abc".match!(/a/)

    expect ::MatchAssay do
      "abc".match!(/x/)
    end

    "abc".not_match!(/g/)

## respond_to!

    "string".respond_to!(:upcase)

    expect ::RespondAssay do
      "string".respond_to!(:not_a_method)
    end

    "string".not_respond_to!(:not_a_method)

## satisfy!

    5.satisfy!{ |x| x > 3 }

    expect ::ExecutionAssay do
      5.satisfy!{ |x| x < 3 }
    end

    5.not_satisfy!{ |x| x < 3 }

## raises!

    ::ArgumentError.raised!{ raise ::ArgumentError }

An extension to Proc class can also be used.

    procedure = lambda{ raise ::ArgumentError }

    procedure.raises!(::ArgumentError)

    expect ::RaiseAssay do
      procedure.raises!(::TypeError)
    end

## rescues!

    ::ArgumentError.rescued!{ raise ::ArgumentError }

An extension to Proc class can also be used.

    procedure = lambda{ raise ::ArgumentError }

    procedure.rescues!(::StandardError)

    expect ::RescueAssay do
      procedure.rescues!(::TypeError)
    end

## throws!

    :foo.thrown!{ throw :foo }

An extension to Proc class can also be used.

    procedure = lambda{ throw :foo }

    procedure.throws!(:foo)

    expect ::ThrowAssay do
      procedure.throws!(:bar)
    end

## Other query methods

A query method that Assay has no class for works the same way, by
calling the object's own method. It fails with a plain `Assertion`.

    10.even!
    10.not_odd!
    10.between!(1, 20)

    expect ::Assertion do
      10.odd!
    end

    expect ::Assertion do
      10.not_between!(1, 20)
    end

Hashes can be compared like anything else.

    {:a=>1}.equal!({:a=>1})

    expect ::EqualAssay do
      {:a=>1}.equal!({:a=>2})
    end

A bang method that means nothing is still a NoMethodError, and Ruby's
own bang methods are left alone.

    expect ::NoMethodError do
      10.no_such_thing!
    end

    "abc".upcase!.equal!("ABC")

    10.respond_to?(:even!).true!
    10.respond_to?(:no_such_thing!).false!
