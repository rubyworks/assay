require 'assay/failure'
require 'assay/compare_failure'

module Assay

  class NilFailure < CompareFailure

    def self.assertion_name
      :nil
    end

    def self.assertion_operator
      :nil?
    end

    def self.fail_message(exp)
      "Expected #{exp.inspect} to be nil"
    end

    def self.fail_message!(exp)
      "Expected #{exp.inspect} to NOT be nil"
    end

    def self.check(exp)
      exp.nil?
    end

    def self.check!(exp)
      ! exp.nil?
    end

  end


  module Assertable
    # Passed if object is +nil+.
    #
    def assert_nil(exp, opts={})
      opts[:backtrace] ||= caller
      NilFailure.assert(exp, opts)
    end

    # Passed if object is not +nil+.
    #
    #   assert_not_nil(true)
    #
    def assert_not_nil(exp, opts={})
      opts[:backtrace] ||= caller
      NilFailure.assert!(exp, opts)
    end
  end


  module Matchers

    #
    #
    #   value.assert is_nil
    #
    def is_nil
      NilFailure.to_matcher
    end

    #
    #
    #   value.should be_nil
    #
    def be_nil
      NilFailure.to_matcher
    end

  end

end
