require 'assay/failure'
require 'assay/compare_failure'

module Assay

  class TrueFailure < CompareFailure

    def self.assertion_name
      :true
    end

    def self.assertion_operator
      :true?
    end

    # Check assertion.
    def self.check(exp)
      TrueClass === exp
    end

    # Check negated assertion.
    def self.check!(exp)
      ! TrueClass === exp
    end

    #
    def to_s
      return super unless @_arguments.size == 1

      exp = @_arguments[0].inspect

      if @_negated
        "Expected #{exp} to NOT be true"
      else
        "Expected #{exp} to be true"
      end
    end

  end


  module Assertable
    # Passed if object is +true+.
    #
    def assert_true(exp, opts={})
      opts[:backtrace] ||= caller
      TrueFailure.assert(exp, opts)
    end

    # Passed if object is not +true+.
    #
    #   assert_not_true(false)
    #
    def assert_not_true(exp, opts={})
      opts[:backtrace] ||= caller
      TrueFailure.assert!(exp, opts)
    end
  end


  module Matchers
    # True?
    #
    #   value.assert is_true
    #
    def is_true
      TrueFailure.to_matcher
    end

    # True?
    #
    #   value.should be_true
    #
    def be_true
      TrueFailure.to_matcher
    end
  end

end

