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

    def self.fail_message(exp)
      "Expected #{exp.inspect} to be true"
    end

    def self.fail_message!(exp)
      "Expected #{exp.inspect} to NOT be true"
    end

    def self.check(exp)
      TrueClass === exp
    end

    def self.check!(exp)
      ! TrueClass === exp
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

    # value.assert is_true
    def is_true
      TrueFailure.to_matcher
    end

    # value.should be_true
    def be_true
      TrueFailure.to_matcher
    end

  end

end

