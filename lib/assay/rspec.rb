require_relative '../assay'
require_relative 'containers/matchers'
require_relative 'handlers/should'

module Assay

  # This module provides matchers for RSpec-compatiblity.
  #
  # The set is not fully compataible, but provides most traditional Rspec
  # matchers, less some extraneous verbosity (use of `a` and `an`) and
  # some of the more complex and less common matchers.
  #
  # Compatability will improve with time.
  #
  module RSpecMatchers

    # Passes if the expected and actual are alike.
    #
    #   object.should be_like(criterion)
    #
    # There is not equivalant for this in RSpec, we simply add it
    # here to cover all Assays available.
    #
    # See {LikeAssay}.
    #
    def be_like(exp)
      LikeAssay.to_matcher(exp)
    end

    # Passes if expected and actual are nto equal within delta tolerance.
    #
    #   value1.assert is_within(delta, value2)
    #
    # See {WithinAssay}.
    #
    def be_close(delta, exp)
      WithinAssay.to_matcher(exp, delta)
    end

    # Passes if object is empty.
    #
    #   object.assert is_empty
    #
    # See {EmptyAssay}.
    #
    def be_empty
      EmptyAssay.to_matcher
    end

    # Passes if +expected+ == +actual+.
    #
    #   'MY STRING'.should equate_to('my string'.upcase)
    #   'MY STRING'.should_not equate_to('another string')
    #
    # This matcher is not supported by RSpec, but is added so that the
    # EqualityAssay has an explict matcher available.
    #
    # See {EqualityAssay}.
    #
    def equate_to(exp)
      EqualityAssay.to_matcher(exp)
    end

    #
    # Passes if block is satisfied given target object as argument.
    #
    #   5.should satisfy{ |n| n > 3}
    #
    # See {ExecutionAssay}.
    #
    def satisfy(&block)
      ExecutionAssay.to_matcher(&block)
    end

    #
    # Passed if object is +false+.
    #
    #   value.should be_false
    #
    # See {FalseAssay}.
    #
    def be_false
      FalseAssay.to_matcher
    end

    #
    # Passes if actual is the same exact object as expected.
    #
    #   object.should be_identical_to(object)
    #
    # See {IdentityAssay}.
    #
    def equal(obj)
      IdentityAssay.to_matcher(obj)
    end

    #
    # Passes if object is an instance of class.
    #
    #   object.should be_instance_of(class)
    #
    # See {InstanceAssay}.
    #
    def be_instance_of(cls)
      InstanceAssay.to_matcher(cls)
    end

    alias :be_an_instance_of :be_instance_of

    #
    # Pass if object is a kind of class.
    #
    #   object.should be_a_kind_of(class)
    #
    # See {KindAssay}.
    #
    def be_kind_of(cls)
      KindAssay.to_matcher(cls)
    end

    alias :be_a_kind_of :be_kind_of
    alias :be_a         :be_kind_of
    alias :be_an        :be_kind_of

    #
    # Pass if object matches pattern using `#=~` method.
    #
    #   object.should match(regexp)
    #
    # See {MatchAssay}.
    #
    def match(regexp)
      MatchAssay.to_matcher(regexp)
    end

    #
    # Pass if object is +nil+.
    #
    #   value.should be_nil
    #
    # See {NilAssay}.
    #
    def be_nil
      NilAssay.to_matcher
    end

    #
    # Pass if an exception is raised.
    #
    #   lambda { do_something_risky }.should raise_error
    #   lambda { do_something_risky }.should raise_error(PoorRiskDecisionError)
    #
    # See {RaiseAssay}.
    #
    # @todo Support for message matching.
    #
    def raise_error(exception=Exception)
      RaiseAssay.to_matcher(exception)
    end

    #
    # Pass if object responds to message.
    #
    #   object.should respond_to(:method_name)
    #
    # See {RespondAssay}.
    #
    def respond_to(method)
      ResponseAssay.to_matcher(method)
    end

    #
    # Pass if two objects are equal using `#eql?` method.
    #
    #   object1.should eql(object2)
    #
    # See {SameAssay}.
    #
    def eql(exp)
      SameAssay.to_matcher(exp)
    end

    #
    # Pass if procedure throws a specified symbol.
    #
    #   lambda { do_something_risky }.should throw_symbol
    #   lambda { do_something_risky }.should throw_symbol(:that_was_risky)
    #
    # See {ThrowAssay}.
    #
    # @todo Support for throw argument. (Does RSpec even support this?)
    #
    def throw_symbol(sym=nil) #, arg=nil)
      ThrowAssay.to_matcher(sym)
    end

    #
    # Passed if object is +true+.
    #
    #   object.should be_true
    #
    # See {TrueAssay}.
    #
    def be_true
      TrueAssay.to_matcher
    end

=begin
    #
    # Meta-programming routine for creating all the subjective methods.
    #
    def self.bootstrap
      ::Assertion.by_operator.each do |op, const|
        next unless const < Assertion

        name = const.assertive_name.to_sym

        #name = RSPEC_NAMES[name] || name

        define_method("be_#{name}") do |*args|
          const.to_matcher(*args)
        end
      end
    end

    #
    # Do it!
    #
    bootstrap
=end

  end

  module Matchers
    include RSpecMatchers
  end

end

