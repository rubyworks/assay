# Assertion Methods

To use the assertion methods, first require the library.

    require 'assay/testunit'

Then include them into your test scope.

    include ::Assay::Assertions

## assert_equal

    assert_equal(1,1)

    expect ::EqualAssay do
      assert_equal(1,2)
    end

    assert_not_equal(1,2)

## assert_true

    assert_true(true)

    expect ::TrueAssay do
      assert_true(false)
    end

    assert_not_true(false)
    assert_not_true(nil)

## assert_false

    assert_false(false)

    expect ::FalseAssay do
      assert_false(true)
    end

    assert_not_false(true)
    assert_not_false(nil)

## assert_nil

    assert_nil(nil)

    expect ::NilAssay do
      assert_nil(true)
    end

    assert_not_nil(true)
    assert_not_nil(false)

## assert_in_delta

    assert_in_delta(1, 1.5, 2)

    expect ::WithinAssay do
      assert_in_delta(1, 2.5, 1)
    end

    assert_not_in_delta(1, 2, 0.5)

## assert_in_epsilon

    assert_in_epsilon(1, 1.5, 2)
    assert_in_epsilon(0, 1.5, 2)

    expect ::CloseAssay do
      assert_in_epsilon(1, 2.5, 1)
    end

    assert_not_in_epsilon(1, 2.5, 1)
    assert_not_in_epsilon(0, 2.5, 1)

## assert_match

    assert_match(/a/, "abc")

    expect ::MatchAssay do
      assert_match(/x/, "abc")
    end

    assert_not_match(/a/, "bcd")

## assert_no_match

    assert_no_match(/a/, "bcd")

    expect ::NoMatchAssay do
      assert_no_match(/a/, "abc")
    end

## assert_empty

    assert_empty([])

    expect ::EmptyAssay do
      assert_empty([1,2,3])
    end

    assert_not_empty([1,2,3])

## assert_include

    assert_includes([1,2,3], 1)

    expect ::IncludeAssay do
      assert_includes([1,2,3], 4)
    end

    assert_not_includes([1,2,3], 4)

## assert_same

    assert_same(:a, :a)

    expect ::IdentityAssay do
      assert_same("a", "a")
    end

    assert_not_same(:a, :b)

## assert_instance_of

    assert_instance_of(Integer, 1)

    expect ::InstanceAssay do
      assert_instance_of(String, 1)
    end

    assert_not_instance_of(String, 1)

## assert_kind_of

    assert_kind_of(Integer, 1)

    expect ::KindAssay do
      assert_kind_of(String, 1)
    end

    assert_not_kind_of(String, 1)

## assert_raise

    assert_raise(ArgumentError){ raise ArgumentError }

    expect ::RaiseAssay do
      assert_raise(ArgumentError){ raise TypeError }
    end

    assert_not_raised(ArgumentError){ raise TypeError }

## assert_raise_kind_of

    assert_raise_kind_of(StandardError){ raise }

    expect ::RescueAssay do
      assert_raise_kind_of(ArgumentError){ raise TypeError }
    end

    assert_raise_kind_of(Exception){ raise }

## assert_nothing_raised

    assert_nothing_raised{ true }
    assert_nothing_raised{ nil }

    expect ::RescueAssay do
      assert_nothing_raised{ raise }
    end

## assert_respond_to

    assert_respond_to("string", :upcase)

    expect ::RespondAssay do
      assert_respond_to("string", :not_a_method)
    end

    assert_not_respond_to("string", :not_a_method)

## assert_block

    assert_block{ :ok }

    expect ::ExecutionAssay do
      assert_block{ raise }
    end

## assert_throw

    assert_throw(:foo){ throw :foo }

    expect ::ThrowAssay do
      assert_throw(:foo){ throw :bar }
    end

    assert_not_thrown(:foo){ throw :bar }

## assert_nothing_thrown

    assert_nothing_thrown{ nil }

    expect ::ThrowAssay do
      assert_nothing_thrown{ throw :bar }
    end

## assert_compare

    assert_compare(1, :<,  2)
    assert_compare(2, :>,  1)
    assert_compare(1, :<=, 1)
    assert_compare(1, :>=, 1)
    assert_compare(1, :<=, 2)
    assert_compare(2, :>=, 1)
    assert_compare(1, :==, 1)

    expect ArgumentError do
      assert_compare(1, :<=>, 1)
    end

## assert_operator

    assert_operator([], :<<, 1)

## assert_predicate

    assert_predicate(10, :even?)

    assert_not_predicate(10, :odd?)

## assert_path_exist

    assert_path_exist(__FILE__)

    assert_path_not_exist(__FILE__ + '.foobar')

## assert_boolean

    assert_boolean(true)
    assert_boolean(false)

    assert_not_boolean(nil)

## assert_alike

    assert_alike(1,1)
    assert_alike(1,1.0)

    expect ::LikeAssay do
      assert_alike(1,"1")
    end

    assert_not_alike(1,"1")

## assert_equivalent

    assert_equivalent(1, 1)

    expect ::EqualityAssay do
      assert_equivalent(1, 1.0)
    end

    assert_not_equivalent(1, 1.0)

