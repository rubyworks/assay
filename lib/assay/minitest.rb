require_relative 'containers/extensions'
require_relative 'testunit'

module Assay

  module MiniTestAssertions
    # not exact but close enough for now
    include TestUnitAssertions
  end

  module Assertions
    include MiniTestAssertions
  end

  # This module provides extensions for MiniTest compatiblity.
  #
  # The set is not fully compataible, but provides most of MiniTest
  # extensions.
  #
  # Compatability will improve with time.
  #
  module MiniTestExtensions

    #
    #
    # FIXME: should work without argument
    #
    def must_be(operator, argument=nil, msg=nil)
      CompareAssay.assert(self, operator, argument, :message=>msg)
    end

    # Passes if object is like criterion.
    #
    #   object.must_be_like(criterion)
    #
    # See {CompareAssay}.
    #
    def must_be_like(exp, msg=nil)
      LikeAssay.assert(self, exp, :message=>msg, :backtrace=>caller)
    end

    # Passes if object is not like criterion using {CompareAssay}.
    #
    #   object.wont_be_like(criterion)
    #
    # See {CompareAssay}.
    #
    def wont_be_like(act, msg=nil)
      LikeAssay.refute(self, exp, :message=>msg, :backtrace=>caller)
    end

    # Passes if expected and actual are equal within delta tolerance.
    #
    #   assert_in_delta 0.05, (50000.0 / 10**6), 0.00001
    #
    # See {DeltaAssay}.
    #
    def must_be_within_delta(exp, delta, msg=nil)
      WithinAssay.assert(self, exp, delta, :message=>msg, :backtrace=>caller)
    end

    # Passes if expected and actual are equal not within delta tolerance.
    #
    #   assert_not_in_delta 0.05, (50000.0 / 10**6), 0.00001
    #
    # See {WithinAssay}.
    #
    def wont_be_within_delta(exp, delta, msg=nil)
      WithinAssay.refute(self, exp, delta, :message=>msg, :backtrace=>caller)
    end

    # Passes if object is empty.
    #
    #   object.must_be_empty
    #
    def must_be_empty(msg=nil)
      EmptyAssay.assert(self, :message=>msg, :backtrace=>caller)
    end

    # Passes if object is not empty.
    #
    #   object.wont_be_empty
    #
    def wont_be_empty(msg=nil)
      EmptyAssay.refute(self, :message=>msg, :backtrace=>caller)
    end

    # Passes if expected == +actual.
    #
    # Note that the ordering of arguments is important,
    # since a helpful error message is generated when this
    # one fails that tells you the values of expected and actual.
    #
    #   'MY STRING'.must_equal('my string'.upcase)
    #
    def must_equal(exp, msg=nil)
      EqualityAssay.assert(self, exp, :message=>msg, :backtrace=>caller)
    end

    # Passes if expected != actual
    #
    #  'some string'.wont_equal('some other string')
    #
    def assert_not_equal(exp, msg=nil)
       EqualityAssay.refute(self, :message=>msg, :backtrace=>caller)
    end

    # Passes if the block yields successfully.
    #
    #   proc.must_execute("Couldn't do the thing")
    #
    def must_execute(msg=nil)
      ExecutionAssay.assert(:message=>msg, :backtrace=>caller, &self)
    end

    # Passes if the block does not yield successfully.
    #
    #   proc.wont_execute("Could do the thing")
    #
    def wont_execute(msg=nil)
      ExecutionAssay.refute(:message=>msg, :backtrace=>caller, &self)
    end

    # Passes if the block yields successfully.
    #
    #   5.must_satisfy{ |x| x > 3 }
    #
    def must_satisfy(msg=nil, &block)
      ExecutionAssay.assert(self, :message=>msg, :backtrace=>caller, &block)
    end

    # Passes if the block does not yield successfully.
    #
    #   5.wont_satisfy{ |x| x < 3 }
    #
    def wont_satisfy(msg=nil, &block)
      ExecutionAssay.refute(self, :message=>msg, :backtrace=>caller, &block)
    end

    # Passed if object is +false+.
    #
    def must_be_false(msg=nil)
      FalseAssay.assert(self, :message=>msg, :backtrace=>caller)
    end

    # Passed if object is not +false+.
    #
    #   assert_not_false(false)
    #
    def wont_be_false(msg=nil)
      FalseAssay.refute(self, :message=>msg, :backtrace=>caller)
    end

    # Passes if actual is the same exact object as expected.
    #
    #   object.must_be_same_as(object)
    #
    def must_be_same_as(exp, msg=nil)
      IdentityAssay.assert(self, exp, :message=>msg, :backtrace=>caller)
    end

    # Passes if actual is not the same exact object as expected.
    #
    #   object.wont_be_same_as(other)
    #
    def wont_be_same_as(exp, msg=nil)
      IdentityAssay.refute(self, exp, :message=>msg, :backtrace=>caller)
    end

    # Passes if object is an instance of class.
    #
    #   'foo'.must_be_instance_of(String)
    #
    def must_be_instance_of(cls, msg=nil)
      InstanceAssay.assert(self, cls, :message=>msg, :backtrace=>caller)
    end

    # Passes if object is not an instance of class.
    #
    #   'foo'.wont_be_instance_of(Integer)
    #
    def wont_be_instance_of(cls, msg=nil)
      InstanceAssay.refute(self, cls, :message=>msg, :backtrace=>caller)
    end

    # Passes if object is a kind of class.
    #
    #   assert_kind_of(Object, 'foo')
    #
    def must_be_kind_of(cls, msg=nil)
      KindAssay.assert(self, cls, :message=>msg, :backtrace=>caller)
    end

    # Passes if object is not a kind of class.
    #
    #   assert_not_kind_of(Object, 'foo')
    #
    def wont_be_kind_of(cls, msg=nil)
      KindAssay.refute(self, cls, :message=>msg, :backtrace=>caller)
    end

    # Passes if object matches pattern using `#=~` method.
    #
    #   'one 2 three'.must_match(/two/)
    #
    def must_match(exp, msg=nil)
      MatchAssay.assert(self, exp, :message=>msg, :backtrace=>caller)
    end

    # Passes if object does not match pattern using `#=~` method.
    #
    #   'one 2 three'.wont_match(/two/)
    #
    def wont_match(exp, msg=nil)
      MatchAssay.refute(self, exp, :message=>msg, :backtrace=>caller)
    end

    # Passed if object is +nil+.
    #
    def must_be_nil(msg=nil)
      NilAssay.assert(self, :message=>msg, :backtrace=>caller)
    end

    # Passed if object is not +nil+.
    #
    #   assert_not_nil(true)
    #
    def wont_be_nil(msg=nil)
      NilAssay.refute(self, :message=>msg, :backtrace=>caller)
    end

    # Passes if the procedure raises a given exception.
    #
    #   lambda{ raise 'Boom!!!' }.must_raise(RuntimeError)
    #
    def must_raise(exp, msg=nil, call=nil)
      RaiseAssay.assert(exp, msg=nil, call=nil, &self)
    end

    # Passes if the procedure *does not* raise a given exceptions.
    #
    #   lambda{ raise 'Boom!!!' }.wont_raise(IOError)
    #
    def wont_raise(exp, msg=nil, call=nil)
      RaiseAssay.refute(exp, msg, call, &self)
    end

    # Passes if +object+ respond_to? +methods+.
    #
    #   'bugbear'.must_respond_to(:slice)
    #
    def must_respond_to(method, msg=nil)
      ResponseAssay.assert(self, method, :message=>msg, :backtrace=>caller)
    end

    # Passes if +object+ does not respond_to? +methods+.
    #
    #   'bugbear'.wont_respond_to(:slice)
    #
    def wont_respond_to(method, msg=nil)
      ResponseAssay.refute(self, method, :message=>msg, :backtrace=>caller)
    end

    # Passes if `criterion.eql?(actual)`.
    #
    # Note that the ordering of arguments is important,
    # since a helpful error message is generated when this
    # one fails that tells you the values of expected and actual.
    #
    #   'MY STRING'.must_be_equivalent_to('my string'.upcase)
    #
    def must_be_equivalent_to(criterion, msg=nil)
      SameAssay.assert(self, criterion, :message=>msg, :backtrace=>caller)
    end

    alias_method :must_eql, :must_be_equivalent_to

    # Passes if NOT `criterion.eql?(actual)`.
    #
    #   'MY STRING'.wont_be_equivalent_to('some other string')
    #
    def wont_be_equivalent_to(criterion, msg=nil)
      SameAssay.refute(self, criterion, :message=>msg, :backtrace=>caller)
    end

    alias_method :wont_eql, :wont_be_equivalent_to

    # Passes if the block throws expected_symbol
    #
    #   assert_throws :done do
    #     throw :done
    #   end
    #
    def must_throw(sym, msg=nil)
      ThrowAssay.assert(sym, :message=>msg, :backtrace=>caller, &self)
    end

    # Passes if the block throws expected_symbol
    #
    #   refute_throws :done do
    #     throw :chimp
    #   end
    #
    def wont_throw(sym, msg=nil)
      ThrowAssay.refute(sym, :message=>msg, :backtrace=>caller, &self)
    end

    # Passed if object is +true+.
    #
    #   object.must_be_true
    #
    def must_be_true(msg=nil)
      TrueAssay.assert(self, :message=>msg, :backtrace=>caller)
    end

    #
    # Passed if object is not +true+.
    #
    #   object.wont_be_true
    #
    def wont_be_true(msg=nil)
      TrueAssay.refute(self, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if `self.include?(object)`.
    #
    def must_include(object, msg=nil)
      IncludeAssay.assert(self, object, :message=>msg, :backtrace=>caller)
    end

    #
    # Passes if `self.include?(object)`.
    #
    def wont_include(object, msg=nil)
      IncludeAssay.refute(self, object, :message=>msg, :backtrace=>caller)
    end

=begin
    MINITEST_NAMES = {
      :equal    => :equal_to,
      :instance => :instance_of,
      :kind     => :kind_of,
      :within   => :close,
    }

    #
    # Meta-programming routine for creating all the subjective methods.
    #
    def self.bootstrap
      Assay.constants.each do |const|
        next unless const < Assertion

        name = const.assertive_name.to_sym

        name = RSPEC_NAMES[name] || name

        define_method("must_be_#{name}") do |*args|
          const.assert(self, *args)
        end

        define_method("wont_be_#{name}") do |*args|
          const.refute(self, *args)
        end
      end
    end

    #
    # Do it!
    #
    bootstrap
=end

  end

  module Extensions
    include MiniTestExtensions
  end

end

