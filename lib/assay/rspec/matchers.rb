module Assay; end
module Assay::RSpec

  # This module provides matchers for RSpec-compatiblity.
  #
  # The set is not fully compataible, but provides most RSpec matchers.
  # The most notable exlusion for the moment is the `have` matchers.
  #
  # Compatability will improve with time. Feel _obligated_ to submit a
  # patch if you really need it. ;)
  #
  # @see https://www.relishapp.com/rspec/rspec-expectations/docs/built-in-matchers
  #
  module Matchers

    #def self.included(base)
    #  @_once ||= require_relative('should').nil?
    #end

    #def self.extended(base)
    #  @_once ||= require_relative('should').nil?
    #end

    # Passes if the expected and actual are alike.
    #
    #   object.should be_like(criterion)
    #
    # There is no equivalant for this in RSpec, we simply add it
    # here to cover all Assays available.
    #
    # @raise LikeAssay
    #
    def be_like(criterion)
      LikeAssay.assertor(criterion)
    end

    # Passes if expected and actual are nto equal within delta tolerance.
    #
    #   value.should be_close(delta, criterion)
    #
    # @raise WithinAssay
    #
    def be_close(delta, criterion)
      WithinAssay.assertor(criterion, delta)
    end

    # Passes if object is empty.
    #
    #   object.should be_empty
    #
    # @raise EmptyAssay
    #
    def be_empty
      EmptyAssay.assertor
    end

    # Passes if +expected+ == +actual+.
    #
    #   'MY STRING'.should equate_to('my string'.upcase)
    #   'MY STRING'.should_not equate_to('another string')
    #
    # This matcher is not supported by RSpec, but is added so that the
    # EqualityAssay has an explict matcher available.
    #
    # @raise EqualityAssay
    #
    def equate_to(exp)
      EqualityAssay.assertor(exp)
    end

    #
    # Passes if block is satisfied given target object as argument.
    #
    #   5.should satisfy{ |n| n > 3}
    #
    # @raise ExecutionAssay
    #
    def satisfy(&block)
      ExecutionAssay.assertor(&block)
    end

    #
    # Passed if object is +false+.
    #
    #   value.should be_false
    #
    # @raise FalseAssay
    #
    def be_false
      FalseAssay.assertor
    end

    #
    # Passes if actual is the same exact object as expected.
    #
    #   object.should be_identical_to(object)
    #
    # @raise IdentityAssay
    #
    def equal(obj)
      IdentityAssay.assertor(obj)
    end

    alias :be_identical_to :equal

    #
    # Passes if `actual == expected`.
    #
    #   object.should eq(object)
    #
    # @raise EqualAssay
    #
    def eq(obj)
      EqualAssay.assertor(obj)
    end

    #
    # Passes if object is an instance of class.
    #
    #   object.should be_instance_of(class)
    #
    # @raise InstanceAssay
    #
    def be_instance_of(cls)
      InstanceAssay.assertor(cls)
    end

    alias :be_an_instance_of :be_instance_of

    #
    # Pass if object is a kind of class.
    #
    #   object.should be_kind_of(class)
    #
    # @raise KindAssay
    #
    def be_kind_of(cls)
      KindAssay.assertor(cls)
    end

    alias :be_a_kind_of :be_kind_of
    alias :be_a         :be_kind_of
    alias :be_an        :be_kind_of

    #
    # Pass if object matches pattern using `#=~` method.
    #
    #   object.should match(regexp)
    #
    # @raise MatchAssay
    #
    def match(regexp)
      MatchAssay.assertor(regexp)
    end

    #
    # Pass if object is +nil+.
    #
    #   value.should be_nil
    #
    # @raise NilAssay
    #
    def be_nil
      NilAssay.assertor
    end

    #
    # Pass if an exception is raised.
    #
    #   lambda { do_something_risky }.should raise_error
    #   lambda { do_something_risky }.should raise_error(PoorRiskDecisionError)
    #
    # @raise RaiseAssay
    #
    # @todo Support for message matching ?
    #
    def raise_error(exception=Exception)
      RaiseAssay.assertor(exception)
    end

    #
    # Pass if object responds to message.
    #
    #   object.should respond_to(:method_name)
    #
    # @raise RespondAssay
    #
    def respond_to(method)
      RespondAssay.assertor(method)
    end

    #
    # Pass if two objects are equal using `#eql?` method.
    #
    #   object1.should eql(object2)
    #
    # @raise EqualityAssay
    #
    def eql(exp)
      EqualityAssay.assertor(exp)
    end

    #
    # Pass if procedure throws a specified symbol.
    #
    #   lambda { do_something_risky }.should throw_symbol
    #   lambda { do_something_risky }.should throw_symbol(:that_was_risky)
    #
    # @raise ThrowAssay
    #
    # @todo Support for throw argument. (Does RSpec even support this?)
    #
    def throw_symbol(sym=nil) #, arg=nil)
      ThrowAssay.assertor(sym)
    end

    #
    # Passed if object is +true+.
    #
    #   object.should be_true
    #
    # @raise TrueAssay
    #
    def be_true
      TrueAssay.assertor
    end

    #
    #
    #
    def have(n)
      Have.new(n)
    end

    alias :have_exactly :have

    #
    #
    #
    def have_at_least(n)
      Have.new(n, :at_least)
    end

    #
    #
    #
    def have_at_most(n)
      Have.new(n, :at_most)
    end

    #
    # Wrap the target of an expectation, a value or a block.
    #
    #   expect(actual).to eq(3)
    #   expect{ perform }.to raise_error(ArgumentError)
    #
    def expect(*target, &block)
      case
      when block && !target.empty?
        raise ArgumentError, "expect takes a value or a block, not both"
      when block
        Expect.new(block)
      when target.size == 1
        Expect.new(target.first)
      else
        raise ArgumentError, "wrong number of arguments (given #{target.size}, expected 1)"
      end
    end

  end

end
