require 'assay/compare_failure'

module Assay

  class FalseFailure < CompareFailure

    def self.assertion_name
      :false
    end

    def self.assertion_operator
      :false?
    end

    # Check assertion.
    def self.check(exp)
      FalseClass === exp
    end

    # Check negated assertion.
    def self.check!(exp)
      ! FalseClass === exp
    end

    #
    def to_s
      return super unless @_arguments.size == 1

      exp = @_arguments[0].inspect

      if @_negated
        "Expected #{exp} to NOT be false"
      else
        "Expected #{exp} to be false"
      end
    end

  end


  module Assertable
    # Passed if object is +false+.
    #
    def assert_false(exp, opts={})
      opts[:backtrace] ||= caller
      FalseFailure.assert(exp, opts)
    end

    # Passed if object is not +false+.
    #
    #   assert_not_false(false)
    #
    def assert_not_false(exp, opts={})
      opts[:backtrace] ||= caller
      FalseFailure.assert!(exp, opts)
    end
  end


  module Matchers
    #
    #
    #   value.assert is_false
    #
    def is_false
      FalseFailure.to_matcher
    end

    #
    #
    #   value.should be_false
    #
    def be_false
      FalseFailure.to_matcher
    end
  end

end
