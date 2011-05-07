require 'assay/assertions/compare_failure'

module Assay

  # Comparison assertion for the #eql? method.
  class SameFailure < CompareFailure

    def self.assertion_name
      :same
    end

    def self.assertion_operator
      :eql?
    end

    # Check assertion.
    def self.pass?(exp, act)
      exp.eql?(act)
    end

    #
    def to_s
      return super unless @arguments.size == 2

      exp = @arguments[0].inspect
      act = @arguments[1].inspect

      if @_negated
        "Expected #{act} to NOT be the same as #{exp}"
      else
        "Expected #{act} to be the same as #{exp}"
      end
    end

  end


  module Assertives
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
      SameFailure.refute(exp, act, opts)
    end

    alias_method :assert_not_same, :refute_same
  end


  module Matchers
    #
    #
    #   object1.assert is_same_as(object2)
    #
    def is_same_as(obj)
      SameFailure.to_matcher(obj)
    end

    #
    #
    #   object1.should be_same_as(object2)
    #
    def be_same_as(obj)
      SameFailure.to_matcher(obj)
    end
  end

end
