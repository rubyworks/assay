require 'assay/failure'
require 'assay/compare_failure'

module Assay

  class SameFailure < CompareFailure

    def self.assertion_name
      :same
    end

    def self.assertion_operator
      :eql?
    end

    # Check assertion.
    def self.check(exp, act)
      exp.eql?(act)
    end

    # Check negated assertion.
    def self.check!(exp, act)
      !exp.eql?(act)
    end

    #
    def to_s
      return super unless @_arguments.size == 2

      exp = @_arguments[0].inspect
      act = @_arguments[1].inspect

      if @_negated
        "Expected #{act} to NOT be the same as #{exp}"
      else
        "Expected #{act} to be the same as #{exp}"
      end
    end

  end


  module Assertable
    # Passes if +expected+ .eq? +actual+.
    #
    # Note that the ordering of arguments is important,
    # since a helpful error message is generated when this
    # one fails that tells you the values of expected and actual.
    #
    #   assert_same 'MY STRING', 'my string'.upcase
    #
    def assert_same(exp, act, opts={})
      opts[:backtrace] ||= caller
      SameFailure.assert(exp, act, opts)
    end

    # Passes if not +expected+ .eq? +actual+.
    #
    #  assert_not_the_same 'some string', 5
    #
    def refute_same(exp, act, opts={})
      opts[:backtrace] ||= caller
      SameFailure.assert!(exp, act, opts)
    end
  end


  module Matchers
    #
    #
    #   object1.assert is_the_same_as(object2)
    #
    def is_same_as(obj)
      SameFailure.to_matcher(obj)
    end

    #
    #
    #   object1.should be_the_same_as(object2)
    #
    def be_same_as(obj)
      SameFailure.to_matcher(obj)
    end
  end

end
